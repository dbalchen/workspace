/*
 * dServer.cpp
 *
 *  Created on: Sep 9, 2020
 *      Author: dbalchen
 */

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

#define SOCKET unsigned int
#define INVALID_SOCKET -1
#define SOCKET_ERROR -1

using namespace std;

#include <netdb.h>
#include <unistd.h>
#include <iostream>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <time.h>
#include <sys/io.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include <string>
#include <algorithm>
#include <cctype>
#include <vector>
#include <list>

// Program Specific
#include "cumberland.h"

// Diameter functions
#include "PDCtok.h"
#include "CBBString.h"
#include "CBBByteArray.h"
#include "CBBTokenizer.h"

#include "DIAMETER_defs.h"
#include "DIAMETER_avp.h"
#include "DIAMETER_msg.h"

// Setting up global variables

const unsigned int diameter_success = 2001;
const unsigned int diameter_too_busy = 3004;
const unsigned int diameter_rating_failed = 5031;
const unsigned int ccr_application_id = 4;
const unsigned int cc_request_type_initial_request = 1;
const unsigned int cc_request_type_update_request = 2;
const unsigned int cc_request_type_terminal_request = 3;
const unsigned int cc_request_type_event_request = 4;
const unsigned int cc_request_action_direct_debit = 0;
const unsigned int cc_request_action_refund_account = 1;
const unsigned int cc_request_action_check_balance = 2;
const unsigned int cc_request_action_price_enquiry = 3;
const unsigned int pcc_service = 9;
const unsigned int subscription_id_type_e164 = 0;
const unsigned int subscription_id_type_nai = 3;
unsigned int end_to_end = 1;
unsigned int hop_to_hop = 1;

vector<DIAMETER_avp> avp_list;

std::string LocalHost;
std::string RemoteHost;
std::string LocalIPAddress;
std::string RemoteIPAddress;
std::string LocalPort("3868");
std::string StartTime;
std::string SessionID;
ofstream PcapFile;
ofstream LogFile;
SOCKET ClientSocket = INVALID_SOCKET;
SOCKET ServerSocket = INVALID_SOCKET;

char RecvBuf[8192];

std::string timestamp() {
	char time_string[1024];
	time_t timer_value;
	struct tm *tptr;
	int trash;

	timer_value = time((time_t *) 0);

	if (timer_value < 0) {
		return std::string();
	}

	tptr = (struct tm *) 0;
	tptr = gmtime(&timer_value);

	if (tptr <= 0) {
		return std::string();
	}

	trash = strftime(time_string, sizeof(time_string), "%Y%m%d%H%M%S", tptr);

	if (trash < 0) {
		return std::string();
	}

	return std::string(time_string);
}

void dlog(const char *format, ...) {
	if (LogFile.is_open()) {
		char log_string[2048];
		va_list arguments;

		LogFile << timestamp() << ": ";
		va_start(arguments, format);
		vsnprintf(log_string, sizeof(log_string), format, arguments);
		va_end(arguments);

		LogFile << log_string;
		LogFile.flush();
	}
}

long long htonll(long long val) {
	union {
		long l[2];
		long long ll;
	} u;
	u.ll = val;
	long tmp = u.l[0];
	u.l[0] = htonl(u.l[1]);
	u.l[1] = htonl(tmp);
	return u.ll;
}

unsigned long long ntohll(unsigned long long val) {
	union {
		long l[2];
		long long ll;
	} u;
	u.ll = val;
	long tmp = u.l[0];
	u.l[0] = ntohl(u.l[1]);
	u.l[1] = ntohl(tmp);
	return u.ll;
}

////// Diameter Code

int read_diameter(int client_sock) {
	int msg_length = 0;
	int read_length = 0;
	int network_msg_length = 0;
	int retval = -1;

	memset(RecvBuf, 0, sizeof(RecvBuf));

	while (read_length < sizeof(msg_length)) {
		char *rp = RecvBuf;
		rp += read_length;
		int this_read_length = recv(client_sock, rp,
				(sizeof(msg_length) - read_length), 0);
		if (this_read_length <= 0) {
			return -1;
		}
		read_length += this_read_length;
	}

	memcpy((char *) &network_msg_length, RecvBuf, sizeof(network_msg_length));
	msg_length = ntohl(network_msg_length);
	msg_length &= 0xffffff;
	retval = msg_length;
	msg_length -= sizeof(msg_length);
	read_length = 0;

	while (read_length < msg_length) {
		char *rp = RecvBuf;
		rp += sizeof(msg_length);
		rp += read_length;
		int this_read_length = recv(client_sock, rp, (msg_length - read_length),
				0);
		if (this_read_length <= 0) {
			return -1;
		}
		read_length += this_read_length;
	}

	return retval;
}

int write_diameter(int client_sock, DIAMETER_msg &msg) {
	int retval = -1;
	CBBByteArray outbuf = msg.encode_binary();
	char *wp = (char *) (outbuf.GetData());
	retval = send(client_sock, wp, outbuf.GetSize(), 0);
	return retval;
}

int cer_send(int client_sock) {
	DIAMETER_msg cer;
	DIAMETER_avp avp1;
	cer.setCode(DIAMETER_CAPABILITIES_EXCHANGE);
	cer.setFlags(0x80);
	cer.setHopHop(hop_to_hop++);
	cer.setEndEnd(end_to_end++);
	avp1.setCode(AVP_NAME_ORIGIN_HOST);
	avp1.setValue(LocalHost.data());
	cer.setAvp(avp1);
	DIAMETER_avp avp2;
	avp2.setCode(AVP_NAME_ORIGIN_REALM);
	avp2.setValue("uscc.net");
	cer.setAvp(avp2);
	DIAMETER_avp avp3;
	avp3.setCode(AVP_NAME_HOST_IP_ADDRESS);
	avp3.setValue(LocalIPAddress.data());
	cer.setAvp(avp3);
	DIAMETER_avp avp4;
	avp4.setCode(AVP_NAME_VENDOR_ID);
	avp4.setValue(0);
	cer.setAvp(avp4);
	DIAMETER_avp avp5;
	avp5.setCode(AVP_NAME_PRODUCT_NAME);
	avp5.setValue("Amdocs DCCA");
	cer.setAvp(avp5);
	DIAMETER_avp avp6;
	avp6.setCode(AVP_NAME_AUTH_APPLICATION_ID);
	avp6.setValue(htonl(ccr_application_id));
	cer.setAvp(avp6);
	return (write_diameter(client_sock, cer));
}

int dwd_send(int client_sock) {
	DIAMETER_msg dwd;
	DIAMETER_avp avp1;
	dwd.setCode(DIAMETER_DEVICE_WATCHDOG);
	dwd.setFlags(0x80);
	dwd.setHopHop(hop_to_hop++);
	dwd.setEndEnd(end_to_end++);
	avp1.setCode(AVP_NAME_ORIGIN_HOST);
	avp1.setValue(LocalHost.data());
	dwd.setAvp(avp1);
	DIAMETER_avp avp2;
	avp2.setCode(AVP_NAME_ORIGIN_REALM);
	avp2.setValue("uscc.net");
	dwd.setAvp(avp2);
	return (write_diameter(client_sock, dwd));
}

int setup_server(unsigned short listen_port) {
	struct sockaddr_in s_name;
	struct sockaddr *ssdp;
	int s_descr;
	int soption;

	s_descr = (int) socket(PF_INET, SOCK_STREAM, 0);

	if (s_descr < 0) {
		//		"Cannot create server listener, error = %d\n", WSAGetLastError());
		return (-1);
	}

	s_name.sin_family = AF_INET;
	s_name.sin_addr.s_addr = INADDR_ANY;
	s_name.sin_port = htons(listen_port);

	soption = 1;

	if (setsockopt(s_descr, SOL_SOCKET, SO_REUSEADDR, (char *) &soption,
			sizeof(soption)) != 0) {
		//dlog ("Cannot set socket re-use on listener, error = %d\n", WSAGetLastError());
		return (-1);
	}

	ssdp = (struct sockaddr *) &s_name;

	if (bind(s_descr, ssdp, sizeof(s_name)) < 0) {
		//dlog ("Cannot bind() listener, error = %d\n", WSAGetLastError());
		return (-1);
	}

	if (listen(s_descr, 1) < 0) {
		//dlog ("Cannot listen() on listener, error = %d\n", WSAGetLastError());
		return (-1);
	}

	return s_descr;
}

int accept_client(int server_fd) {
	int client_fd = -1;
	socklen_t client_addr_len;
	struct sockaddr_in client_name;
	struct sockaddr *client_name_p;

	memset((struct sockaddr_in *) &client_name, 0, sizeof(struct sockaddr_in));

	client_name_p = (struct sockaddr *) &client_name;
	client_addr_len = sizeof(client_name);
	client_fd = accept(server_fd, client_name_p, &client_addr_len);

	return (client_fd);
}

int main(int argc, char *argv[]) {
	unsigned short server_port = (unsigned short) (strtoul(LocalPort.data(),
			(char **) 0, 10));

	cout << "!!!Szia from dDiameter!!!" << endl; // prints !!!Szia from dDiameter!!!

	StartTime = timestamp();

	LocalHost = std::string("ubuntu");

	LocalIPAddress = std::string("192.168.0.1");

	int server_sock = setup_server(server_port);

	while(true)
	{

		int client_sock = accept_client(server_sock);

		while (client_sock > 0) {
			int msg_length = read_diameter(client_sock);

			if (msg_length < 0) {
				close(client_sock);
				close(server_sock);
				client_sock = -1;
				server_sock = -1;
			} else {
				CBBByteArray diameter_raw(RecvBuf, msg_length);
				DIAMETER_msg incoming_message;

				int decode_retval = incoming_message.decode_binary(diameter_raw);

				if (decode_retval > 0) {
					unsigned int msg_flags_request = 0x80;
					unsigned int flags = incoming_message.getFlags();

					cout << "!!! Received !!!" << endl;
					switch (incoming_message.getCode()) {
					case DIAMETER_CAPABILITIES_EXCHANGE: {
						//					debug_str += "Capabilities-Exchange";
						cout << "!!! Capabilities-Exchange !!!" << endl;
					}
					break;
					case DIAMETER_DEVICE_WATCHDOG: {
						//					debug_str += "Device-Watchdog";
						cout << "!!! Device-Watchdog !!!" << endl;

					}
					break;
					case DIAMETER_CREDIT_CONTROL: {
						//					debug_str += "Credit-Control";
						cout << "!!! Credit-Control !!!" << endl;
					}
					break;
					default: {


						//					dlog("Unknown DIAMETER code (%u)\n",
						//							incoming_message.getCode());
						cout << "!!! Unknown DIAMETER code !!!" << endl;
					}
					}

					if (flags & msg_flags_request) {
						//					debug_str += "-Request";

						//					dlog("%s\n", debug_str.data());
						// copy in the session id from the incoming
						DIAMETER_avp session_id;
						session_id.setCode(AVP_NAME_SESSION_ID);

						for (int k = 0; k < incoming_message.getNumAvp(); k++) {
							if (incoming_message.getAvp(k).getCode() == AVP_NAME_SESSION_ID) {
								CBBString session_value =
										incoming_message.getAvp(k).getValueAsString();
								session_id.setValue(session_value);
							}
						}

						const unsigned int diameter_success = 2001;
						const unsigned int gy_app_id = htonl(4);

						DIAMETER_msg answer_message;
						DIAMETER_avp result_code;
						DIAMETER_avp origin_host;
						DIAMETER_avp origin_realm;
						DIAMETER_avp origin_state_id;

						answer_message.setFlags(0);
						answer_message.setCode(incoming_message.getCode());
						answer_message.setApplicationID(
								incoming_message.getApplicationID());
						answer_message.setHopHop(incoming_message.getHopHop());
						answer_message.setEndEnd(incoming_message.getEndEnd());

						result_code.setCode(AVP_NAME_RESULT_CODE);
						result_code.setValue(htonl(diameter_success));
						origin_host.setCode(AVP_NAME_ORIGIN_HOST);
						origin_host.setValue(LocalHost.data());
						origin_realm.setCode(AVP_NAME_ORIGIN_REALM);
						origin_realm.setValue("uscc.net");
						origin_state_id.setCode(AVP_NAME_ORIGIN_STATE_ID);
						origin_state_id.setValue(htonl(0x1));

						switch (incoming_message.getCode()) {
						case DIAMETER_CREDIT_CONTROL: {
							unsigned int cc_request_type_int = 0;
							unsigned int cc_request_number_int = 0;

							for (int k = 0; k < incoming_message.getNumAvp(); k++) {
								if (incoming_message.getAvp(k).getCode() == AVP_NAME_CC_REQUEST_NUMBER) {
									cc_request_number_int = incoming_message.getAvp(
											k).getValueAsInt();
								}
								if (incoming_message.getAvp(k).getCode() == AVP_NAME_CC_REQUEST_TYPE) {
									cc_request_type_int =
											incoming_message.getAvp(k).getValueAsInt();
								}
							}

							answer_message.setAvp(session_id);
							answer_message.setAvp(result_code);

							DIAMETER_avp cc_request_type;
							cc_request_type.setCode(AVP_NAME_CC_REQUEST_TYPE);
							cc_request_type.setValue(
									(const unsigned int) htonl(
											cc_request_type_int));
							answer_message.setAvp(cc_request_type);

							DIAMETER_avp cc_request_number;
							cc_request_number.setCode(AVP_NAME_CC_REQUEST_NUMBER);
							cc_request_number.setValue(
									(const unsigned int) htonl(
											cc_request_number_int));
							answer_message.setAvp(cc_request_number);

							DIAMETER_avp auth_application_id;
							auth_application_id.setCode(
									AVP_NAME_AUTH_APPLICATION_ID);
							auth_application_id.setValue(
									(const unsigned int) gy_app_id);
							answer_message.setAvp(auth_application_id);

							answer_message.setAvp(origin_host);
							answer_message.setAvp(origin_realm);
						}
						break;
						case DIAMETER_CAPABILITIES_EXCHANGE: {
							DIAMETER_avp host_ip_address;
							DIAMETER_avp product_name;
							DIAMETER_avp vendor_id;
							DIAMETER_avp firmware_revision;
							DIAMETER_avp auth_application_id;
							DIAMETER_avp acct_application_id;
							DIAMETER_avp inband_security_id;

							answer_message.setAvp(result_code);
							host_ip_address.setCode(AVP_NAME_HOST_IP_ADDRESS);
							host_ip_address.setValue(LocalIPAddress.data());
							origin_state_id.setCode(AVP_NAME_ORIGIN_STATE_ID);
							origin_state_id.setValue(htonl(0x1));
							product_name.setCode(AVP_NAME_PRODUCT_NAME);
							product_name.setValue("Amdocs DCCA");
							vendor_id.setCode(AVP_NAME_VENDOR_ID);
							vendor_id.setValue(11580);
							firmware_revision.setCode(AVP_NAME_FIRMWARE_REVISION);
							firmware_revision.setValue(htonl(0x1));
							auth_application_id.setCode(
									AVP_NAME_AUTH_APPLICATION_ID);
							auth_application_id.setValue(gy_app_id);
							acct_application_id.setCode(
									AVP_NAME_ACCT_APPLICATION_ID);
							acct_application_id.setValue(gy_app_id);
							inband_security_id.setCode(AVP_NAME_INBAND_SECURITY_ID);
							inband_security_id.setValue(0x0);

							answer_message.setAvp(origin_host);
							answer_message.setAvp(origin_realm);
							answer_message.setAvp(host_ip_address);
							answer_message.setAvp(origin_state_id);
							answer_message.setAvp(product_name);
							answer_message.setAvp(vendor_id);
							answer_message.setAvp(firmware_revision);
							answer_message.setAvp(auth_application_id);
							answer_message.setAvp(acct_application_id);
							answer_message.setAvp(inband_security_id);
						}
						break;
						case DIAMETER_DEVICE_WATCHDOG: {
							answer_message.setAvp(result_code);
							answer_message.setAvp(origin_host);
							answer_message.setAvp(origin_realm);
							answer_message.setAvp(origin_state_id);
						}
						break;
						default: {
						}
						break;
						}

						write_diameter(client_sock, answer_message);
					}
				}
			}
		}

	}

	int retval = 0;

	cout << "!!!Szia from dDiameter!!!" << endl; // prints !!!Szia from dDiameter!!!

	return retval;
}

