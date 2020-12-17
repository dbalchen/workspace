/*
 * dta.cpp
 *
 *  Created on: Sep 30, 2020
 *      Author: dbalchen
 */

#include <microhttpd.h>
#include <iostream>
#include <bits/stdc++.h>
#include <thread>
using namespace std;

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <chrono>

#include "dta.h"
#include "diameter.h"

#include <mutex>

std::mutex mu;

void current_time_point(chrono::system_clock::time_point timePt) {
	time_t timeStamp = chrono::system_clock::to_time_t(timePt);
	//	cout << std::ctime(&timeStamp) << endl;
}


void watchDog(int sockfd) {

	char buffer[8192];

	while (true) {

		current_time_point(chrono::system_clock::now());

		chrono::system_clock::time_point timePt = chrono::system_clock::now()
		+ chrono::seconds(30);

		if ((dwd_send(sockfd) > 0)) {

			int msg_length = read_diameter(sockfd);

			if (msg_length > 0) {
				CBBByteArray diameter_raw(buffer, msg_length);
				DIAMETER_msg incoming_message;

				int decode_retval = incoming_message.decode_binary(
						diameter_raw);

			}
		}

		this_thread::sleep_until(timePt);

	}
}

void clientProcess(int client, int server, int sess_count) {
	char buffer[8192];
	unsigned int dRequest;
	int decode_retval;

	vector<std::string> parmList;

	int n = write(client, "Howdy!!!! from the DTA\n", 23);

	bzero((char *) &buffer, sizeof(buffer));

	if (n < 0) {

		cout << "Error writing to client socket" << endl;

	};

	n = read(client, buffer, 255);

	if (n < 0) {

		cout << "Error reading from client socket" << endl;

	};

	std::string request = (std::string(buffer));

	request = request.substr(0, request.length() - 2);

	size_t pos = 0;
	std::string token;

	while ((pos = request.find(",")) != std::string::npos) {
		token = request.substr(0, pos);
		std::cout << token << std::endl;
		parmList.push_back(token);
		request.erase(0, pos + 1);
	}

	parmList.push_back(request);

	vector<std::string> v1;

	v1.operator =(parmList);

	if (parmList[0].compare("DEBIT") == 0) {
		dRequest = cc_request_action_direct_debit;
	}

	else if (parmList[0].compare("CREDIT") == 0) {
		dRequest = cc_request_action_refund_account;

	} else {

		write(client, "Transaction Type not Supported\n", 23);
		close(client);

	}

	std::string SessionID = init_session_id(sess_count++);

	if ((gy_ccr_initial(server, SessionID, parmList[1]) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {

			CBBByteArray diameter_raw(buffer, msg_length);
			DIAMETER_msg incoming_message;

			decode_retval = incoming_message.decode_binary(diameter_raw);
		}
		else {

			write(client, "Could not create session ID\n", 28);
			close(client);

		}

	}

	if ((gy_ccr_event(server, dRequest, SessionID, parmList[1]) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {
			CBBByteArray diameter_raw(RecvBuf, msg_length);
			DIAMETER_msg incoming_message;

			decode_retval = incoming_message.decode_binary(diameter_raw);

		}
		else {

			write(client, "Failure to complete Transaction\n", 32);
			close(client);

		}
	}

	if ((gy_ccr_terminal(server, SessionID, parmList[1]) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {
			CBBByteArray diameter_raw(buffer, msg_length);
			DIAMETER_msg incoming_message;

			decode_retval = incoming_message.decode_binary(diameter_raw);

		}
		else {

			write(client, "Could not commit Transaction\n", 28);
			close(client);
		}
	}

	write(client, "Transaction Successful\n", 23);

	close(client);
}

// Define DTA class
dta::dta(int tport, std::string shost, int tsport) {

	port = tport;
	host = shost;
	sport = tsport;
}

int dta::createServer(void) {
	cout << "Creating a dta server instance" << endl;

	struct sockaddr_in s_name;
	struct sockaddr *ssdp;
	int s_descr;
	int soption;

	s_descr = (int) socket(PF_INET, SOCK_STREAM, 0);

	s_name.sin_family = AF_INET;

	s_name.sin_addr.s_addr = INADDR_ANY;

	s_name.sin_port = htons(port);

	soption = 1;

	if ((setsockopt(s_descr, SOL_SOCKET, SO_REUSEADDR, (char *) &soption,
			sizeof(soption))) < 0) {

		return -1;
	}

	ssdp = (struct sockaddr *) &s_name;

	if (bind(s_descr, ssdp, sizeof(s_name)) < 0) {

		return -1;

	}

	if (listen(s_descr, 1) < 0) {

		return -1;
	}

	return s_descr;

}

int dta::connectDiameter(void) {

	int sockfd;
	struct sockaddr_in serv_addr;
	struct hostent *server;
	char buffer[8192];

	sockfd = socket(AF_INET, SOCK_STREAM, 0);

	server = gethostbyname(host.c_str());

	if (server == NULL) {
		cout << "Cannot create a connection to the diameter server." << endl;
		return -1;
	}

	bzero((char *) &serv_addr, sizeof(serv_addr));

	serv_addr.sin_family = AF_INET;

	bcopy((char *) server->h_addr,
			(char *)&serv_addr.sin_addr.s_addr,
			server->h_length);

	serv_addr.sin_port = htons(sport);

	int connection_status = connect(sockfd, (struct sockaddr *) &serv_addr,
			sizeof(serv_addr));

	if (connection_status < 0) {

		cout << "Cannot create a connection to the diameter service." << endl;

		return -1;
	}

	if (cer_send(sockfd) > 0) {
		int msg_length = read_diameter(sockfd);

		if (msg_length > 0) {

			CBBByteArray diameter_raw(buffer, msg_length);

			DIAMETER_msg incoming_message;

			int decode_retval = incoming_message.decode_binary(diameter_raw);

		}
	}

	std::thread threadObj(watchDog, sockfd);
	threadObj.detach();

	vecOfThreads.push_back(std::move(threadObj));

	return sockfd;
}

int dta::accept_client(int server_fd) {

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

void dta::acceptConection(int csock, int ssock) {

	int totalThreads = 0;

	while (true) {

		int client = accept_client(csock);

		sess_count = sess_count + 1;

		totalThreads = totalThreads + 1;

		if (totalThreads <= num_threads) {

			//			threads[totalThreads - 1] = std::thread(clientProcess,client,sess_count);

			clientProcess(client, ssock, sess_count);

		}
		else {

			int n = write(client,
					"Sorry to many connections... Please try again later\n",
					52);

			if (n < 0) {

				cout << "Error writing to client socket" << endl;

			};

			close(client);
		}

	}
}

dta::~dta() {
	cout << "Destroying a dta server instance" << endl;
}

int main(int argc, char *argv[]) {

	/*	std::string logfile = argv[4];

	 if(!logfile.empty())
	 {
	 std::ofstream cout(logfile.c_str());
	 }
	 */

	cout << "!!!Szia from dta!!!" << endl; // prints !!!Szia from dDiameter!!!

	int port = atoi(argv[1]);

	std::string host = argv[2];

	int sport = atoi(argv[3]);

	dta dtao(port, host, sport);

	int srvc = dtao.createServer();

	int hrvc = dtao.connectDiameter();

	if (srvc < 0 || hrvc < 0) {

		cout << "!!!ERROR starting dta !!!" << endl;

		return -1;
	}

	dtao.acceptConection(srvc, hrvc);

	cout << "!!!Szia from dta!!!" << endl; // prints !!!Szia from dta!!!

	return 0;
}
