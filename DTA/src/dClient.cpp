/*
 * dClient.cpp
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

///// The CCR Interface
int gy_ccr_send(int client_sock, unsigned int cc_type,
		unsigned int requested_action) {
	DIAMETER_msg ccr;
	DIAMETER_avp avp1;
	ccr.setCode(DIAMETER_CREDIT_CONTROL);
	ccr.setFlags(0x80);
	ccr.setHopHop(hop_to_hop++);
	ccr.setEndEnd(end_to_end++);
	ccr.setApplicationID(ccr_application_id);
	avp1.setCode(AVP_NAME_SESSION_ID);
	avp1.setValue(SessionID.data());
	ccr.setAvp(avp1);
	DIAMETER_avp avp2;
	avp2.setCode(AVP_NAME_ORIGIN_HOST);
	avp2.setValue(LocalHost.data());
	ccr.setAvp(avp2);
	DIAMETER_avp avp3;
	avp3.setCode(AVP_NAME_ORIGIN_REALM);
	avp3.setValue("uscc.net");
	ccr.setAvp(avp3);
	DIAMETER_avp avp4;
	avp4.setCode(AVP_NAME_DESTINATION_HOST);
	avp4.setValue(RemoteHost.data());
	ccr.setAvp(avp4);
	DIAMETER_avp avp5;
	avp5.setCode(AVP_NAME_DESTINATION_REALM);
	avp5.setValue("uscc.net");
	ccr.setAvp(avp5);
	DIAMETER_avp avp6;
	avp6.setCode(AVP_NAME_AUTH_APPLICATION_ID);
	avp6.setValue(htonl(ccr_application_id));
	ccr.setAvp(avp6);
	DIAMETER_avp avp7;
	avp7.setCode(AVP_NAME_EVENT_TIMESTAMP);
	avp7.setValue(htonl(1));
	ccr.setAvp(avp7);
	DIAMETER_avp avp9;
	avp9.setCode(AVP_NAME_CC_REQUEST_TYPE);
	avp9.setValue(htonl(cc_type));
	ccr.setAvp(avp9);
	if (cc_type == cc_request_type_event_request) {
		DIAMETER_avp avp16;
		avp16.setCode(AVP_NAME_REQUESTED_ACTION);
		avp16.setValue(htonl(requested_action));
		ccr.setAvp(avp16);
	}
	DIAMETER_avp avp10;
	avp10.setCode(AVP_NAME_CC_REQUEST_NUMBER);
	avp10.setValue(htonl(1));
	ccr.setAvp(avp10);
	DIAMETER_avp avp13;
	avp13.setCode(AVP_NAME_SUBSCRIPTION_ID);
	DIAMETER_avp avp14;
	avp14.setCode(AVP_NAME_SUBSCRIPTION_ID_TYPE);
	avp14.setValue(htonl(subscription_id_type_e164));
	avp13.setAvp(avp14);
	DIAMETER_avp avp15;
	avp15.setCode(AVP_NAME_SUBSCRIPTION_ID_DATA);
	avp15.setValue("6084414483");
	avp13.setAvp(avp15);
	ccr.setAvp(avp13);
	DIAMETER_avp avp17;
	avp17.setCode(AVP_NAME_SERVICE_IDENTIFIER);
	avp17.setValue(htonl(pcc_service));
	ccr.setAvp(avp17);
	vector<DIAMETER_avp>::iterator avp_i;
	for (avp_i = avp_list.begin(); avp_i != avp_list.end(); ++avp_i) {
		ccr.setAvp(*avp_i);
	}
	avp_list.clear();
	return (write_diameter(client_sock, ccr));
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

int gy_ccr_event(int client_sock, int requested_action) {
	DIAMETER_avp requested_service_unit;
	requested_service_unit.setCode(AVP_NAME_REQUESTED_SERVICE_UNIT);

	DIAMETER_avp exponent_avp;
	exponent_avp.setCode(AVP_NAME_EXPONENT);
	exponent_avp.setValue(htonl(2));
	DIAMETER_avp value_digits_avp;
	value_digits_avp.setCode(AVP_NAME_VALUE_DIGITS);
	value_digits_avp.setLongValue(htonll(1000LL));
	DIAMETER_avp unit_value_avp;
	unit_value_avp.setCode(AVP_NAME_UNIT_VALUE);
	unit_value_avp.setAvp(value_digits_avp);
	unit_value_avp.setAvp(exponent_avp);
	DIAMETER_avp currency_code_avp;
	currency_code_avp.setCode(AVP_NAME_CURRENCY_CODE);
	currency_code_avp.setValue(htonl(840));	// USD
	DIAMETER_avp cc_money_avp;
	cc_money_avp.setCode(AVP_NAME_CC_MONEY);
	cc_money_avp.setAvp(unit_value_avp);
	cc_money_avp.setAvp(currency_code_avp);
	requested_service_unit.setAvp(cc_money_avp);
	avp_list.push_back(requested_service_unit);

	DIAMETER_avp purchase_category_code_avp;
	purchase_category_code_avp.setCode(1104);
	purchase_category_code_avp.setVendorID(11580);
	purchase_category_code_avp.setValue("Charge_Code_Description");
	avp_list.push_back(purchase_category_code_avp);

	DIAMETER_avp application_type_avp;
	application_type_avp.setCode(1105);
	application_type_avp.setVendorID(11580);
	application_type_avp.setValue("Charge_Code_Description");
	avp_list.push_back(application_type_avp);

	return (gy_ccr_send(client_sock, cc_request_type_event_request,
			requested_action));
}

// Init the session

void init_session_id(unsigned int val) {
	char timestamp[256];
	time_t current_time = time((time_t *) 0);
	sprintf(timestamp, "%s;%u;%u", LocalHost.data(), current_time, val);
	SessionID = std::string(timestamp);
}

///// The CCR Interface

///////
int gy_ccr_initial(int client_sock) {
	DIAMETER_avp requested_service_unit;
	requested_service_unit.setCode(AVP_NAME_REQUESTED_SERVICE_UNIT);

	DIAMETER_avp exponent_avp;
	exponent_avp.setCode(AVP_NAME_EXPONENT);
	exponent_avp.setValue(htonl(2));

	DIAMETER_avp value_digits_avp;
	value_digits_avp.setCode(AVP_NAME_VALUE_DIGITS);
	value_digits_avp.setLongValue(htonll(1000LL));

	DIAMETER_avp unit_value_avp;
	unit_value_avp.setCode(AVP_NAME_UNIT_VALUE);
	unit_value_avp.setAvp(value_digits_avp);
	unit_value_avp.setAvp(exponent_avp);

	DIAMETER_avp currency_code_avp;
	currency_code_avp.setCode(AVP_NAME_CURRENCY_CODE);
	currency_code_avp.setValue(htonl(840));	// USD

	DIAMETER_avp cc_money_avp;
	cc_money_avp.setCode(AVP_NAME_CC_MONEY);
	cc_money_avp.setAvp(unit_value_avp);
	cc_money_avp.setAvp(currency_code_avp);
	requested_service_unit.setAvp(cc_money_avp);
	avp_list.push_back(requested_service_unit);

	DIAMETER_avp purchase_category_code_avp;
	purchase_category_code_avp.setCode(1104);
	purchase_category_code_avp.setVendorID(11580);
	purchase_category_code_avp.setValue("Charge_Code_Description");
	avp_list.push_back(purchase_category_code_avp);

	DIAMETER_avp application_type_avp;
	application_type_avp.setCode(1105);
	application_type_avp.setVendorID(11580);
	application_type_avp.setValue("Charge_Code_Description");
	avp_list.push_back(application_type_avp);

	return (gy_ccr_send(client_sock, cc_request_type_initial_request, 0));
}

int gy_ccr_terminal(int client_sock) {
	DIAMETER_avp requested_service_unit;
	requested_service_unit.setCode(AVP_NAME_REQUESTED_SERVICE_UNIT);

	DIAMETER_avp exponent_avp;
	exponent_avp.setCode(AVP_NAME_EXPONENT);
	exponent_avp.setValue(htonl(2));
	DIAMETER_avp value_digits_avp;
	value_digits_avp.setCode(AVP_NAME_VALUE_DIGITS);
	//value_digits_avp.setLongValue(htonll(0LL));	// CANCEL
	value_digits_avp.setLongValue(htonll(1000LL));	// COMMIT
	DIAMETER_avp unit_value_avp;
	unit_value_avp.setCode(AVP_NAME_UNIT_VALUE);
	unit_value_avp.setAvp(value_digits_avp);
	unit_value_avp.setAvp(exponent_avp);
	DIAMETER_avp currency_code_avp;
	currency_code_avp.setCode(AVP_NAME_CURRENCY_CODE);
	currency_code_avp.setValue(htonl(840));	// USD
	DIAMETER_avp cc_money_avp;
	cc_money_avp.setCode(AVP_NAME_CC_MONEY);
	cc_money_avp.setAvp(unit_value_avp);
	cc_money_avp.setAvp(currency_code_avp);
	requested_service_unit.setAvp(cc_money_avp);
	avp_list.push_back(requested_service_unit);

	DIAMETER_avp purchase_category_code_avp;
	purchase_category_code_avp.setCode(1104);
	purchase_category_code_avp.setVendorID(11580);
	purchase_category_code_avp.setValue("Charge_Code_Description");
	avp_list.push_back(purchase_category_code_avp);

	DIAMETER_avp application_type_avp;
	application_type_avp.setCode(1105);
	application_type_avp.setVendorID(11580);
	application_type_avp.setValue("Charge_Code_Description");
	avp_list.push_back(application_type_avp);

	return (gy_ccr_send(client_sock, cc_request_type_terminal_request, 0));
}

int connect_server(std::string& host, unsigned short network_port) {

	int sockfd, portno;
	struct sockaddr_in serv_addr;
	struct hostent *server;

	char buffer[256];

	portno = atoi("3868");

	sockfd = socket(AF_INET, SOCK_STREAM, 0);

	server = gethostbyname("localhost");

	if (server == NULL) {
		fprintf(stderr, "ERROR, no such host\n");
		exit(0);
	}

	bzero((char *) &serv_addr, sizeof(serv_addr));

	serv_addr.sin_family = AF_INET;

	bcopy((char *) server->h_addr,
			(char *)&serv_addr.sin_addr.s_addr,
			server->h_length);

	serv_addr.sin_port = htons(portno);

	int connection_status = connect(sockfd, (struct sockaddr *) &serv_addr,
			sizeof(serv_addr));

	return sockfd;

}

int main(int argc, char *argv[]) {
	cout << "!!!Szia from dDiameter!!!" << endl; // prints !!!Szia from dDiameter!!!

	//unsigned short server_port = (unsigned short) (strtoul(LocalPort.data(),
	//		(char **) 0, 10));

	int server_port = atoi(LocalPort.data());
	StartTime = timestamp();

	LocalHost = std::string("localhost");

	LocalIPAddress = std::string("192.168.0.1");

	RemoteHost = std::string("192.168.0.1");

	if (RemoteHost.length() > 0) {
		// "LocalPort" in this case is actually remote
		int client_sock = connect_server(RemoteHost, server_port);

		if (client_sock >= 0) {
			bool self_test = false;

			if (cer_send(client_sock) > 0) {
				int msg_length = read_diameter(client_sock);

				if (msg_length > 0) {
					CBBByteArray diameter_raw(RecvBuf, msg_length);
					DIAMETER_msg incoming_message;
			int decode_retval = incoming_message.decode_binary(
							diameter_raw);

					if (decode_retval > 0) {
						self_test = true;
					}
				}
			}

			if ((self_test) && (dwd_send(client_sock) > 0)) {
				self_test = false;

				int msg_length = read_diameter(client_sock);

				if (msg_length > 0) {
					CBBByteArray diameter_raw(RecvBuf, msg_length);
					DIAMETER_msg incoming_message;

					int decode_retval = incoming_message.decode_binary(
							diameter_raw);

					if (decode_retval > 0) {
						self_test = true;
					}
				}
			}

			unsigned int sess_count = 1;

			init_session_id(sess_count++);

			if ((self_test) && (gy_ccr_initial(client_sock) > 0)) {
				self_test = false;

				int msg_length = read_diameter(client_sock);

				if (msg_length > 0) {
					CBBByteArray diameter_raw(RecvBuf, msg_length);
					DIAMETER_msg incoming_message;

					int decode_retval = incoming_message.decode_binary(
							diameter_raw);

					if (decode_retval > 0) {
						self_test = true;
					}
				}
			}

			if ((self_test) && (gy_ccr_terminal(client_sock) > 0)) {
				self_test = false;

				int msg_length = read_diameter(client_sock);

				if (msg_length > 0) {
					CBBByteArray diameter_raw(RecvBuf, msg_length);
					DIAMETER_msg incoming_message;

					int decode_retval = incoming_message.decode_binary(
							diameter_raw);

					if (decode_retval > 0) {
						self_test = true;
					}
				}
			}

			init_session_id(sess_count++);

			if ((self_test)
					&& (gy_ccr_event(client_sock,
       						cc_request_action_direct_debit) > 0)) {
				self_test = false;

				int msg_length = read_diameter(client_sock);

				if (msg_length > 0) {
					CBBByteArray diameter_raw(RecvBuf, msg_length);
					DIAMETER_msg incoming_message;

					int decode_retval = incoming_message.decode_binary(
							diameter_raw);

					if (decode_retval > 0) {
						self_test = true;
					}
				}
			}

			init_session_id(sess_count++);

			if ((self_test)
					&& (gy_ccr_event(client_sock,
							cc_request_action_refund_account) > 0)) {
				self_test = false;

				int msg_length = read_diameter(client_sock);

				if (msg_length > 0) {
					CBBByteArray diameter_raw(RecvBuf, msg_length);
					DIAMETER_msg incoming_message;

					int decode_retval = incoming_message.decode_binary(
							diameter_raw);

					if (decode_retval > 0) {
						self_test = true;
					}
				}
			}

			init_session_id(sess_count++);

			if ((self_test)
					&& (gy_ccr_event(client_sock,
							cc_request_action_check_balance) > 0)) {
				self_test = false;

				int msg_length = read_diameter(client_sock);

				if (msg_length > 0) {
					CBBByteArray diameter_raw(RecvBuf, msg_length);
					DIAMETER_msg incoming_message;

					int decode_retval = incoming_message.decode_binary(
							diameter_raw);

					if (decode_retval > 0) {
						self_test = true;
					}
				}
			}

			init_session_id(sess_count++);

			if ((self_test)
					&& (gy_ccr_event(client_sock,
							cc_request_action_price_enquiry) > 0)) {
				self_test = false;

				int msg_length = read_diameter(client_sock);

 				if (msg_length > 0) {
					CBBByteArray diameter_raw(RecvBuf, msg_length);
					DIAMETER_msg incoming_message;

					int decode_retval = incoming_message.decode_binary(
							diameter_raw);

					if (decode_retval > 0) {
						self_test = true;
					}
				}
			}

			close(client_sock);
		}
	}

	cout << "!!!Szia from dDiameter!!!" << endl; // prints !!!Szia from dDiameter!!!
}

