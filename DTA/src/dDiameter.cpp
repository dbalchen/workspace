//============================================================================
// Name        : dDiameter.cpp
// Author      : David Balchen
// Version     : 0.01
// Copyright   : Your copyright notice
// Description : A Linux port of Steve Hauks Diameter test program
//============================================================================

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

const unsigned int 	diameter_success = 2001;
const unsigned int 	diameter_too_busy = 3004;
const unsigned int 	diameter_rating_failed = 5031;
const unsigned int	ccr_application_id = 4;
const unsigned int 	cc_request_type_initial_request = 1;
const unsigned int 	cc_request_type_update_request = 2;
const unsigned int 	cc_request_type_terminal_request = 3;
const unsigned int 	cc_request_type_event_request = 4;
const unsigned int	cc_request_action_direct_debit = 0;
const unsigned int	cc_request_action_refund_account = 1;
const unsigned int	cc_request_action_check_balance = 2;
const unsigned int	cc_request_action_price_enquiry = 3;
const unsigned int	pcc_service = 9;
const unsigned int 	subscription_id_type_e164 = 0;
const unsigned int	subscription_id_type_nai = 3;
unsigned int		end_to_end = 1;
unsigned int		hop_to_hop = 1;

vector<DIAMETER_avp>	avp_list;


std::string	LocalHost;
std::string	RemoteHost;
std::string	LocalIPAddress;
std::string	RemoteIPAddress;
std::string	LocalPort("3868");
std::string	StartTime;
std::string	SessionID;
ofstream	PcapFile;
ofstream	LogFile;
SOCKET		ClientSocket = INVALID_SOCKET;
SOCKET		ServerSocket = INVALID_SOCKET;

char		RecvBuf[8192];


std::string timestamp()
{
	char		time_string[1024];
	time_t		timer_value;
	struct tm	*tptr;
	int		trash;

	timer_value = time((time_t *)0);

	if (timer_value < 0)
	{
		return std::string();
	}

	tptr = (struct tm *)0;
	tptr = gmtime(&timer_value);

	if (tptr <= 0)
	{
		return std::string();
	}

	trash = strftime(time_string,sizeof(time_string),"%Y%m%d%H%M%S",tptr);

	if (trash < 0)
	{
		return std::string();
	}

	return std::string(time_string);
}


void dlog(const char *format, ...)
{
	if (LogFile.is_open())
	{
		char            log_string[2048];
		va_list		arguments;

		LogFile << timestamp() << ": ";
		va_start(arguments, format);
		vsnprintf(log_string,sizeof(log_string),format,arguments);
		va_end(arguments);

		LogFile << log_string;
		LogFile.flush();
	}
}

long long
htonll(long long val)
{
	union
	{
		long 		l[2];
		long long 	ll;
	}u;
	u.ll = val;
	long tmp = u.l[0];
	u.l[0] = htonl(u.l[1]);
	u.l[1] = htonl(tmp);
	return u.ll;
}

unsigned long long
ntohll(unsigned long long val)
{
	union
	{
		long 		l[2];
		long long 	ll;
	}u;
	u.ll = val;
	long tmp = u.l[0];
	u.l[0] = ntohl(u.l[1]);
	u.l[1] = ntohl(tmp);
	return u.ll;
}


int
read_diameter(int client_sock)
{
	int	msg_length = 0;
	int	read_length = 0;
	int	network_msg_length = 0;
	int	retval = -1;

	memset (RecvBuf, 0, sizeof(RecvBuf));

	while (read_length < sizeof(msg_length))
	{
		char	*rp = RecvBuf;
		rp += read_length;
		int	this_read_length = recv (client_sock, rp, (sizeof(msg_length) - read_length), 0);
		if (this_read_length <= 0)
		{
			return -1;
		}
		read_length += this_read_length;
	}

	memcpy ((char *)&network_msg_length, RecvBuf, sizeof(network_msg_length));
	msg_length = ntohl (network_msg_length);
	msg_length &= 0xffffff;
	retval = msg_length;
	msg_length -= sizeof(msg_length);
	read_length = 0;

	while (read_length < msg_length)
	{
		char	*rp = RecvBuf;
		rp += sizeof(msg_length);
		rp += read_length;
		int	this_read_length = recv (client_sock, rp, (msg_length - read_length), 0);
		if (this_read_length <= 0)
		{
			return -1;
		}
		read_length += this_read_length;
	}

	return retval;
}


int
write_diameter(int client_sock, DIAMETER_msg &msg)
{
	int retval = -1;
	CBBByteArray outbuf = msg.encode_binary();
	char *wp = (char *)(outbuf.GetData());
	retval = send ( client_sock, wp, outbuf.GetSize(), 0 );
	return retval;
}




int
cer_send(int client_sock)
{
	DIAMETER_msg	cer;
	DIAMETER_avp	avp1;
	cer.setCode(DIAMETER_CAPABILITIES_EXCHANGE);
	cer.setFlags(0x80);
	cer.setHopHop(hop_to_hop++);
	cer.setEndEnd(end_to_end++);
	avp1.setCode(AVP_NAME_ORIGIN_HOST);
	avp1.setValue(LocalHost.data());
	cer.setAvp(avp1);
	DIAMETER_avp	avp2;
	avp2.setCode(AVP_NAME_ORIGIN_REALM);
	avp2.setValue("uscc.net");
	cer.setAvp(avp2);
	DIAMETER_avp	avp3;
	avp3.setCode(AVP_NAME_HOST_IP_ADDRESS);
	avp3.setValue(LocalIPAddress.data());
	cer.setAvp(avp3);
	DIAMETER_avp	avp4;
	avp4.setCode(AVP_NAME_VENDOR_ID);
	avp4.setValue(0);
	cer.setAvp(avp4);
	DIAMETER_avp	avp5;
	avp5.setCode(AVP_NAME_PRODUCT_NAME);
	avp5.setValue("Amdocs DCCA");
	cer.setAvp(avp5);
	DIAMETER_avp	avp6;
	avp6.setCode(AVP_NAME_AUTH_APPLICATION_ID);
	avp6.setValue(htonl(ccr_application_id));
	cer.setAvp(avp6);
	return (write_diameter(client_sock, cer));
}


int
dwd_send(int client_sock)
{
	DIAMETER_msg	dwd;
	DIAMETER_avp	avp1;
	dwd.setCode(DIAMETER_DEVICE_WATCHDOG);
	dwd.setFlags(0x80);
	dwd.setHopHop(hop_to_hop++);
	dwd.setEndEnd(end_to_end++);
	avp1.setCode(AVP_NAME_ORIGIN_HOST);
	avp1.setValue(LocalHost.data());
	dwd.setAvp(avp1);
	DIAMETER_avp	avp2;
	avp2.setCode(AVP_NAME_ORIGIN_REALM);
	avp2.setValue("uscc.net");
	dwd.setAvp(avp2);
	return (write_diameter(client_sock, dwd));
}

// Init the session

void
init_session_id(unsigned int val)
{
	char	timestamp[256];
	time_t	current_time = time((time_t *)0);
	sprintf (timestamp,"%s;%u;%u",LocalHost.data(),current_time,val);
	SessionID = std::string(timestamp);
}

///// The CCR Interface
int
gy_ccr_send(int client_sock, unsigned int cc_type, unsigned int requested_action)
{
	DIAMETER_msg	ccr;
	DIAMETER_avp	avp1;
	ccr.setCode(DIAMETER_CREDIT_CONTROL);
	ccr.setFlags(0x80);
	ccr.setHopHop(hop_to_hop++);
	ccr.setEndEnd(end_to_end++);
	ccr.setApplicationID(ccr_application_id);
	avp1.setCode(AVP_NAME_SESSION_ID);
	avp1.setValue(SessionID.data());
	ccr.setAvp(avp1);
	DIAMETER_avp	avp2;
	avp2.setCode(AVP_NAME_ORIGIN_HOST);
	avp2.setValue(LocalHost.data());
	ccr.setAvp(avp2);
	DIAMETER_avp	avp3;
	avp3.setCode(AVP_NAME_ORIGIN_REALM);
	avp3.setValue("uscc.net");
	ccr.setAvp(avp3);
	DIAMETER_avp	avp4;
	avp4.setCode(AVP_NAME_DESTINATION_HOST);
	avp4.setValue(RemoteHost.data());
	ccr.setAvp(avp4);
	DIAMETER_avp	avp5;
	avp5.setCode(AVP_NAME_DESTINATION_REALM);
	avp5.setValue("uscc.net");
	ccr.setAvp(avp5);
	DIAMETER_avp	avp6;
	avp6.setCode(AVP_NAME_AUTH_APPLICATION_ID);
	avp6.setValue(htonl(ccr_application_id));
	ccr.setAvp(avp6);
	DIAMETER_avp	avp7;
	avp7.setCode(AVP_NAME_EVENT_TIMESTAMP);
	avp7.setValue(htonl(1));
	ccr.setAvp(avp7);
	DIAMETER_avp	avp9;
	avp9.setCode(AVP_NAME_CC_REQUEST_TYPE);
	avp9.setValue(htonl(cc_type));
	ccr.setAvp(avp9);
	if (cc_type == cc_request_type_event_request)
	{
		DIAMETER_avp	avp16;
		avp16.setCode(AVP_NAME_REQUESTED_ACTION);
		avp16.setValue(htonl(requested_action));
		ccr.setAvp(avp16);
	}
	DIAMETER_avp	avp10;
	avp10.setCode(AVP_NAME_CC_REQUEST_NUMBER);
	avp10.setValue(htonl(1));
	ccr.setAvp(avp10);
	DIAMETER_avp	avp13;
	avp13.setCode(AVP_NAME_SUBSCRIPTION_ID);
	DIAMETER_avp	avp14;
	avp14.setCode(AVP_NAME_SUBSCRIPTION_ID_TYPE);
	avp14.setValue(htonl(subscription_id_type_e164));
	avp13.setAvp(avp14);
	DIAMETER_avp	avp15;
	avp15.setCode(AVP_NAME_SUBSCRIPTION_ID_DATA);
	avp15.setValue("6084414483");
	avp13.setAvp(avp15);
	ccr.setAvp(avp13);
	DIAMETER_avp	avp17;
	avp17.setCode(AVP_NAME_SERVICE_IDENTIFIER);
	avp17.setValue(htonl(pcc_service));
	ccr.setAvp(avp17);
	vector<DIAMETER_avp>::iterator avp_i;
	for (avp_i = avp_list.begin();
	     avp_i != avp_list.end();
	     ++avp_i)
	{
		ccr.setAvp(*avp_i);
	}
	avp_list.clear();
	return (write_diameter(client_sock, ccr));
}


int
gy_ccr_initial(int client_sock)
{
	DIAMETER_avp	requested_service_unit;
	requested_service_unit.setCode(AVP_NAME_REQUESTED_SERVICE_UNIT);

	DIAMETER_avp	exponent_avp;
	exponent_avp.setCode(AVP_NAME_EXPONENT);
	exponent_avp.setValue(htonl(2));
	DIAMETER_avp	value_digits_avp;
	value_digits_avp.setCode(AVP_NAME_VALUE_DIGITS);
	value_digits_avp.setLongValue(htonll(1000LL));
	DIAMETER_avp	unit_value_avp;
	unit_value_avp.setCode(AVP_NAME_UNIT_VALUE);
	unit_value_avp.setAvp(value_digits_avp);
	unit_value_avp.setAvp(exponent_avp);
	DIAMETER_avp	currency_code_avp;
	currency_code_avp.setCode(AVP_NAME_CURRENCY_CODE);
	currency_code_avp.setValue(htonl(840));	// USD
	DIAMETER_avp	cc_money_avp;
	cc_money_avp.setCode(AVP_NAME_CC_MONEY);
	cc_money_avp.setAvp(unit_value_avp);
	cc_money_avp.setAvp(currency_code_avp);
	requested_service_unit.setAvp(cc_money_avp);
	avp_list.push_back(requested_service_unit);

	DIAMETER_avp	purchase_category_code_avp;
	purchase_category_code_avp.setCode(1104);
	purchase_category_code_avp.setVendorID(11580);
	purchase_category_code_avp.setValue("Charge_Code_Description");
	avp_list.push_back(purchase_category_code_avp);

	DIAMETER_avp	application_type_avp;
	application_type_avp.setCode(1105);
	application_type_avp.setVendorID(11580);
	application_type_avp.setValue("Charge_Code_Description");
	avp_list.push_back(application_type_avp);

	return (gy_ccr_send(client_sock, cc_request_type_initial_request ,0));
}



int
gy_ccr_terminal(int client_sock)
{
	DIAMETER_avp	requested_service_unit;
	requested_service_unit.setCode(AVP_NAME_REQUESTED_SERVICE_UNIT);

	DIAMETER_avp	exponent_avp;
	exponent_avp.setCode(AVP_NAME_EXPONENT);
	exponent_avp.setValue(htonl(2));
	DIAMETER_avp	value_digits_avp;
	value_digits_avp.setCode(AVP_NAME_VALUE_DIGITS);
	//value_digits_avp.setLongValue(htonll(0LL));	// CANCEL
	value_digits_avp.setLongValue(htonll(1000LL));	// COMMIT
	DIAMETER_avp	unit_value_avp;
	unit_value_avp.setCode(AVP_NAME_UNIT_VALUE);
	unit_value_avp.setAvp(value_digits_avp);
	unit_value_avp.setAvp(exponent_avp);
	DIAMETER_avp	currency_code_avp;
	currency_code_avp.setCode(AVP_NAME_CURRENCY_CODE);
	currency_code_avp.setValue(htonl(840));	// USD
	DIAMETER_avp	cc_money_avp;
	cc_money_avp.setCode(AVP_NAME_CC_MONEY);
	cc_money_avp.setAvp(unit_value_avp);
	cc_money_avp.setAvp(currency_code_avp);
	requested_service_unit.setAvp(cc_money_avp);
	avp_list.push_back(requested_service_unit);

	DIAMETER_avp	purchase_category_code_avp;
	purchase_category_code_avp.setCode(1104);
	purchase_category_code_avp.setVendorID(11580);
	purchase_category_code_avp.setValue("Charge_Code_Description");
	avp_list.push_back(purchase_category_code_avp);

	DIAMETER_avp	application_type_avp;
	application_type_avp.setCode(1105);
	application_type_avp.setVendorID(11580);
	application_type_avp.setValue("Charge_Code_Description");
	avp_list.push_back(application_type_avp);

	return (gy_ccr_send(client_sock, cc_request_type_terminal_request ,0));
}


int
gy_ccr_event(int client_sock, int requested_action)
{
	DIAMETER_avp	requested_service_unit;
	requested_service_unit.setCode(AVP_NAME_REQUESTED_SERVICE_UNIT);

	DIAMETER_avp	exponent_avp;
	exponent_avp.setCode(AVP_NAME_EXPONENT);
	exponent_avp.setValue(htonl(2));
	DIAMETER_avp	value_digits_avp;
	value_digits_avp.setCode(AVP_NAME_VALUE_DIGITS);
	value_digits_avp.setLongValue(htonll(1000LL));
	DIAMETER_avp	unit_value_avp;
	unit_value_avp.setCode(AVP_NAME_UNIT_VALUE);
	unit_value_avp.setAvp(value_digits_avp);
	unit_value_avp.setAvp(exponent_avp);
	DIAMETER_avp	currency_code_avp;
	currency_code_avp.setCode(AVP_NAME_CURRENCY_CODE);
	currency_code_avp.setValue(htonl(840));	// USD
	DIAMETER_avp	cc_money_avp;
	cc_money_avp.setCode(AVP_NAME_CC_MONEY);
	cc_money_avp.setAvp(unit_value_avp);
	cc_money_avp.setAvp(currency_code_avp);
	requested_service_unit.setAvp(cc_money_avp);
	avp_list.push_back(requested_service_unit);

	DIAMETER_avp	purchase_category_code_avp;
	purchase_category_code_avp.setCode(1104);
	purchase_category_code_avp.setVendorID(11580);
	purchase_category_code_avp.setValue("Charge_Code_Description");
	avp_list.push_back(purchase_category_code_avp);

	DIAMETER_avp	application_type_avp;
	application_type_avp.setCode(1105);
	application_type_avp.setVendorID(11580);
	application_type_avp.setValue("Charge_Code_Description");
	avp_list.push_back(application_type_avp);

	return (gy_ccr_send(client_sock, cc_request_type_event_request ,requested_action));
}


void
release_interface()
{
	//WSACleanup ();

}


int get_interface()
{
//	WORD		wVersionRequested;
//	WSADATA		wsaData;
//	int 		err;
//	char		hostname_buffer[1024];
//	struct hostent  *hp;
	unsigned char	my_ip[4];
/*
	wVersionRequested = MAKEWORD (2, 2);

	err = WSAStartup (wVersionRequested, &wsaData);

	if ( err != 0 ) {
		printf ("Winsock2 interface not ready, err = %d\n",err);
		return -1;
	}

	if ( LOBYTE (wsaData.wVersion ) != 2 ||
	     HIBYTE (wsaData.wVersion ) != 2 )
	{
		printf ("Incompatible winsock2 version = %d\n",wsaData.wVersion);
		return -1;
	}

	if (gethostname(hostname_buffer, sizeof(hostname_buffer)) == SOCKET_ERROR)
	{
//		printf ("Cannot obtain own hostname, error = %d\n", WSAGetLastError());
		return -1;
	}
*/

//	LocalHost = std::string(hostname_buffer);

	LocalHost = std::string("ubuntu");;
/*
	if ((hp = gethostbyname(hostname_buffer)) == NULL)
	{
//		printf ("Cannot resolve %s, error = %d\n",hostname_buffer, WSAGetLastError());
		return -1;
	}

	my_ip[0] = ((struct in_addr *)(hp->h_addr))->S_un.S_un_b.s_b1;
	my_ip[1] = ((struct in_addr *)(hp->h_addr))->S_un.S_un_b.s_b2;
	my_ip[2] = ((struct in_addr *)(hp->h_addr))->S_un.S_un_b.s_b3;
	my_ip[3] = ((struct in_addr *)(hp->h_addr))->S_un.S_un_b.s_b4;

	sprintf (hostname_buffer,"%u.%u.%u.%u",
		(unsigned int)my_ip[0],
		(unsigned int)my_ip[1],
		(unsigned int)my_ip[2],
		(unsigned int)my_ip[3]);

	LocalIPAddress = std::string(hostname_buffer);
*/

	LocalIPAddress = std::string("192.168.0.1");
	return 0;
}

int accept_client(int server_fd)
{
	int	 		client_fd = -1;
	socklen_t		client_addr_len;
	struct sockaddr_in	client_name;
	struct sockaddr		*client_name_p;

	memset ((struct sockaddr_in *)&client_name, 0, sizeof(struct sockaddr_in));

	client_name_p = (struct sockaddr *)&client_name;
	client_addr_len = sizeof(client_name);
	client_fd = accept (server_fd, client_name_p, &client_addr_len);
/*
	if (client_fd > 0)
	{
		unsigned char 	client_ip[4];
		char		cmd[64];
		client_ip[0] = client_name.sin_addr.S_un.S_un_b.s_b1;
		client_ip[1] = client_name.sin_addr.S_un.S_un_b.s_b2;
		client_ip[2] = client_name.sin_addr.S_un.S_un_b.s_b3;
		client_ip[3] = client_name.sin_addr.S_un.S_un_b.s_b4;

		sprintf (cmd,"%u.%u.%u.%u",
				(unsigned int)client_ip[0],
				(unsigned int)client_ip[1],
				(unsigned int)client_ip[2],
				(unsigned int)client_ip[3]);
		RemoteIPAddress = std::string(cmd);

//		dlog ("Accepted client from %s\n",RemoteIPAddress.data());
	}
*/
	return (client_fd);
}


int
setup_server (unsigned short listen_port)
{
	struct sockaddr_in	s_name;
	struct sockaddr		*ssdp;
	int	 		s_descr;
	int			soption;

	s_descr = (int)socket(PF_INET, SOCK_STREAM, 0);

	if (s_descr < 0)
	{
//		dlog ("Cannot create server listener, error = %d\n", WSAGetLastError());
		return(-1);
	}

	s_name.sin_family = AF_INET;
	s_name.sin_addr.s_addr = INADDR_ANY;
	s_name.sin_port = htons(listen_port);

	soption = 1;

	if (setsockopt(s_descr, SOL_SOCKET, SO_REUSEADDR, (char *)&soption, sizeof(soption)) != 0)
	{
		//dlog ("Cannot set socket re-use on listener, error = %d\n", WSAGetLastError());
		return (-1);
	}

	ssdp = (struct sockaddr *)&s_name;

	if (bind(s_descr, ssdp, sizeof(s_name)) < 0)
	{
		//dlog ("Cannot bind() listener, error = %d\n", WSAGetLastError());
		return (-1);
	}

	if (listen(s_descr, 1) < 0)
	{
		//dlog ("Cannot listen() on listener, error = %d\n", WSAGetLastError());
		return (-1);
	}

	return s_descr;
}




int
connect_server(std::string& host, unsigned short network_port)
{
	struct sockaddr_in	server_name;
	struct sockaddr		*server_name_p;
	struct hostent		*hp;

	memset ((char *)&server_name, 0, sizeof(server_name));
	server_name_p = (struct sockaddr *)&server_name;
	int	server_sock = socket (PF_INET, SOCK_STREAM, 0);

	if (server_sock < 0)
	{
		return -1;
	}

	hp = gethostbyname(host.data());

	if (hp == NULL)
	{
		close (server_sock);
		return -1;
	}

	server_name.sin_family = PF_INET;
	memcpy ( (char *)&server_name.sin_addr, hp->h_addr, hp->h_length );

	server_name.sin_port = htons ( network_port );

	int connection_status = connect ( server_sock, server_name_p, sizeof(server_name) );

	for (int connect_trials = 0; (connect_trials < 30) && (connection_status < 0); connect_trials++)
	{
		sleep(1000);
		connection_status = connect (server_sock, server_name_p, sizeof(server_name) );
	}

	if (connection_status < 0)
	{
		dlog("Connection to %s:%u timed out\n",host.data(), network_port );
		close (server_sock);
		return -1;
	}
	else
	{
		unsigned char 	server_ip[4];
		char		cmd[64];
		/*
		server_ip[0] = server_name.sin_addr.S_un.S_un_b.s_b1;
		server_ip[1] = server_name.sin_addr.S_un.S_un_b.s_b2;
		server_ip[2] = server_name.sin_addr.S_un.S_un_b.s_b3;
		server_ip[3] = server_name.sin_addr.S_un.S_un_b.s_b4;

		sprintf (cmd,"%u.%u.%u.%u",
				(unsigned int)server_ip[0],
				(unsigned int)server_ip[1],
				(unsigned int)server_ip[2],
				(unsigned int)server_ip[3]);

		*/
		RemoteIPAddress = std::string(cmd);

//		dlog("Connected to %s:%u\n",host.data(), network_port );

		return server_sock;
	}
}


bool
//my_getopt (int argc, TCHAR *argv[])
my_getopt (int argc,char *argv[])
{
	char 				cmd[4096];
	wchar_t				wcmd[4096];
	vector<std::string>		option_list;
	vector<std::string>::iterator	option_index;

/*	for (int i = 1; i < argc; i++)
	{
		WideCharToMultiByte(CP_ACP,0,argv[i],wcslen(argv[i])+1,cmd,sizeof(cmd),NULL,NULL);
		std::string opt(cmd);
		option_list.push_back(opt);
	}

	for(option_index = option_list.begin(); option_index != option_list.end(); )
	{
		if (option_index->find("-p") != std::string::npos)
		{
			++option_index;
			if (option_index != option_list.end())
			{
				LocalPort = *option_index;
			}
		}
		else if (option_index->find("-h") != std::string::npos)
		{
			++option_index;
			if (option_index != option_list.end())
			{
				RemoteHost = *option_index;
			}
		}
		else if (option_index->find("-l") != std::string::npos)
		{
			wchar_t	*cwd = _wgetcwd((wchar_t *)0,0);
			if (cwd != (wchar_t *)0)
			{
				WideCharToMultiByte(CP_ACP,0,cwd,wcslen(cwd)+1,cmd,sizeof(cmd),NULL,NULL);
				std::string logfile(cmd);
				logfile += "\\";
				logfile += LocalHost;
				logfile += "_";
				logfile += StartTime;
				logfile += ".out";

				LogFile.open(logfile.data());

				if (LogFile.is_open() == false)
				{
					return false;
				}
			}
		}
		else
		{
		}

		++option_index;
	}
	*/
	return true;
}



// a TCHAR was here... may need to port

int main(int argc,char *argv[])
{
	cout << "!!!Szia from dDiameter!!!" << endl; // prints !!!Szia from dDiameter!!!

	int	retval = 0;

	StartTime = timestamp();


	if (get_interface() > 0)
	{
		if ((my_getopt(argc,argv) == true) && (LocalPort.length() > 0))
		{
			unsigned short 	server_port = (unsigned short)(strtoul(LocalPort.data(),(char **)0,10));

			if (RemoteHost.length() > 0)
			{
				// "LocalPort" in this case is actually remote
				int		client_sock = connect_server(RemoteHost, server_port);
				if (client_sock >= -1) //0)
				{
					bool self_test = false;

					if (cer_send(client_sock) > 0)
					{
						int msg_length = read_diameter(client_sock);

						if (msg_length > 0)
						{
							CBBByteArray 	diameter_raw(RecvBuf,msg_length);
							DIAMETER_msg	incoming_message;

							int decode_retval = incoming_message.decode_binary(diameter_raw);

							if (decode_retval > 0)
							{
								self_test = true;
							}
						}
					}

					if ((self_test) && (dwd_send(client_sock) > 0))
					{
						self_test = false;

						int msg_length = read_diameter(client_sock);

						if (msg_length > 0)
						{
							CBBByteArray 	diameter_raw(RecvBuf,msg_length);
							DIAMETER_msg	incoming_message;

							int decode_retval = incoming_message.decode_binary(diameter_raw);

							if (decode_retval > 0)
							{
								self_test = true;
							}
						}
					}

					unsigned int sess_count = 1;

					init_session_id(sess_count++);

					if ((self_test) && (gy_ccr_initial(client_sock) > 0))
					{
						self_test = false;

						int msg_length = read_diameter(client_sock);

						if (msg_length > 0)
						{
							CBBByteArray 	diameter_raw(RecvBuf,msg_length);
							DIAMETER_msg	incoming_message;

							int decode_retval = incoming_message.decode_binary(diameter_raw);

							if (decode_retval > 0)
							{
								self_test = true;
							}
						}
					}

					if ((self_test) && (gy_ccr_terminal(client_sock) > 0))
					{
						self_test = false;

						int msg_length = read_diameter(client_sock);

						if (msg_length > 0)
						{
							CBBByteArray 	diameter_raw(RecvBuf,msg_length);
							DIAMETER_msg	incoming_message;

							int decode_retval = incoming_message.decode_binary(diameter_raw);

							if (decode_retval > 0)
							{
								self_test = true;
							}
						}
					}

					init_session_id(sess_count++);

					if ((self_test) && (gy_ccr_event(client_sock, cc_request_action_direct_debit) > 0))
					{
						self_test = false;

						int msg_length = read_diameter(client_sock);

						if (msg_length > 0)
						{
							CBBByteArray 	diameter_raw(RecvBuf,msg_length);
							DIAMETER_msg	incoming_message;

							int decode_retval = incoming_message.decode_binary(diameter_raw);

							if (decode_retval > 0)
							{
								self_test = true;
							}
						}
					}

					init_session_id(sess_count++);

					if ((self_test) && (gy_ccr_event(client_sock, cc_request_action_refund_account) > 0))
					{
						self_test = false;

						int msg_length = read_diameter(client_sock);

						if (msg_length > 0)
						{
							CBBByteArray 	diameter_raw(RecvBuf,msg_length);
							DIAMETER_msg	incoming_message;

							int decode_retval = incoming_message.decode_binary(diameter_raw);

							if (decode_retval > 0)
							{
								self_test = true;
							}
						}
					}

					init_session_id(sess_count++);

					if ((self_test) && (gy_ccr_event(client_sock, cc_request_action_check_balance) > 0))
					{
						self_test = false;

						int msg_length = read_diameter(client_sock);

						if (msg_length > 0)
						{
							CBBByteArray 	diameter_raw(RecvBuf,msg_length);
							DIAMETER_msg	incoming_message;

							int decode_retval = incoming_message.decode_binary(diameter_raw);

							if (decode_retval > 0)
							{
								self_test = true;
							}
						}
					}

					init_session_id(sess_count++);

					if ((self_test) && (gy_ccr_event(client_sock, cc_request_action_price_enquiry) > 0))
					{
						self_test = false;

						int msg_length = read_diameter(client_sock);

						if (msg_length > 0)
						{
							CBBByteArray 	diameter_raw(RecvBuf,msg_length);
							DIAMETER_msg	incoming_message;

							int decode_retval = incoming_message.decode_binary(diameter_raw);

							if (decode_retval > 0)
							{
								self_test = true;
							}
						}
					}

					close(client_sock);
				}
			}
			else
			{
				// server start
				dlog("%s preparing server socket at %s:%s\n",LocalHost.data(),LocalIPAddress.data(),LocalPort.data());
				int		server_sock = setup_server(server_port);

				if (server_sock >= 0)
				{
					dlog("%s established server socket at %s:%s\n",LocalHost.data(),LocalIPAddress.data(),LocalPort.data());

					// Waiting for a connection

					int	client_sock = accept_client(server_sock);

					while (client_sock > 0)
					{
						int msg_length = read_diameter(client_sock);

						if (msg_length < 0)
						{
							close(client_sock);
							close(server_sock);
							client_sock = -1;
							server_sock = -1;
						}
						else
						{
							CBBByteArray 	diameter_raw(RecvBuf,msg_length);
							DIAMETER_msg	incoming_message;

							int decode_retval = incoming_message.decode_binary(diameter_raw);

							if (decode_retval > 0)
							{
								unsigned int    msg_flags_request   = 0x80;
								unsigned int 	flags = incoming_message.getFlags();
								std::string	debug_str("Received ");

								switch (incoming_message.getCode())
								{
									case DIAMETER_CAPABILITIES_EXCHANGE :
									{
										debug_str += "Capabilities-Exchange";
									}
									break;
									case DIAMETER_DEVICE_WATCHDOG :
									{
										debug_str += "Device-Watchdog";
									}
									break;
									case DIAMETER_CREDIT_CONTROL :
									{
										debug_str += "Credit-Control";
									}
									break;
									default :
									{
										dlog("Unknown DIAMETER code (%u)\n",
											incoming_message.getCode());
									}
								}

								if (flags & msg_flags_request)
								{
									debug_str += "-Request";

									dlog("%s\n",debug_str.data());
									// copy in the session id from the incoming
									DIAMETER_avp session_id;
									session_id.setCode(AVP_NAME_SESSION_ID);

									for (int k = 0; k < incoming_message.getNumAvp(); k++)
									{
										if (incoming_message.getAvp(k).getCode() == AVP_NAME_SESSION_ID)
										{
											CBBString session_value = incoming_message.getAvp(k).getValueAsString();
											session_id.setValue(session_value);
										}
									}

									const unsigned int      diameter_success = 2001;
									const unsigned int 	gy_app_id = htonl(4);

									DIAMETER_msg	answer_message;
									DIAMETER_avp 	result_code;
									DIAMETER_avp 	origin_host;
									DIAMETER_avp 	origin_realm;
									DIAMETER_avp	origin_state_id;

									answer_message.setFlags(0);
									answer_message.setCode(incoming_message.getCode());
									answer_message.setApplicationID(incoming_message.getApplicationID());
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

									switch (incoming_message.getCode())
									{
										case DIAMETER_CREDIT_CONTROL :
										{
											unsigned int	cc_request_type_int = 0;
											unsigned int	cc_request_number_int = 0;

											for (int k = 0; k < incoming_message.getNumAvp(); k++)
											{
												if (incoming_message.getAvp(k).getCode() == AVP_NAME_CC_REQUEST_NUMBER)
												{
													cc_request_number_int = incoming_message.getAvp(k).getValueAsInt();
												}
												if (incoming_message.getAvp(k).getCode() == AVP_NAME_CC_REQUEST_TYPE)
												{
													cc_request_type_int = incoming_message.getAvp(k).getValueAsInt();
												}
											}

											answer_message.setAvp(session_id);
											answer_message.setAvp(result_code);

											DIAMETER_avp	cc_request_type;
											cc_request_type.setCode(AVP_NAME_CC_REQUEST_TYPE);
											cc_request_type.setValue((const unsigned int)htonl(cc_request_type_int));
											answer_message.setAvp(cc_request_type);

											DIAMETER_avp	cc_request_number;
											cc_request_number.setCode(AVP_NAME_CC_REQUEST_NUMBER);
											cc_request_number.setValue((const unsigned int)htonl(cc_request_number_int));
											answer_message.setAvp(cc_request_number);

											DIAMETER_avp	auth_application_id;
											auth_application_id.setCode(AVP_NAME_AUTH_APPLICATION_ID);
											auth_application_id.setValue((const unsigned int)gy_app_id);
											answer_message.setAvp(auth_application_id);

											answer_message.setAvp(origin_host);
											answer_message.setAvp(origin_realm);
										}
										break;
										case DIAMETER_CAPABILITIES_EXCHANGE :
										{
											DIAMETER_avp	host_ip_address;
											DIAMETER_avp	product_name;
											DIAMETER_avp	vendor_id;
											DIAMETER_avp	firmware_revision;
											DIAMETER_avp	auth_application_id;
											DIAMETER_avp	acct_application_id;
											DIAMETER_avp	inband_security_id;

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
											auth_application_id.setCode(AVP_NAME_AUTH_APPLICATION_ID);
											auth_application_id.setValue(gy_app_id);
											acct_application_id.setCode(AVP_NAME_ACCT_APPLICATION_ID);
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
										case DIAMETER_DEVICE_WATCHDOG :
										{
											answer_message.setAvp(result_code);
											answer_message.setAvp(origin_host);
											answer_message.setAvp(origin_realm);
											answer_message.setAvp(origin_state_id);
										}
										break;
										default :
										{
										}
										break;
									}

									write_diameter(client_sock,answer_message);
								}
							}
						}
					}
				}
				else
				{
					dlog("%s failed to establish server socket at %s:%s\n",LocalHost.data(),LocalIPAddress.data(),LocalPort.data());
				}
			}
		}
		else
		{
			retval = -1;
		}
		release_interface();
	}
	else
	{
		retval = -1;
	}


	cout << "!!!Szia from dDiameter!!!" << endl; // prints !!!Szia from dDiameter!!!
	return retval;
}
