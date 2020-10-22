/*
 * dta.cpp
 *
 *  Created on: Sep 30, 2020
 *      Author: dbalchen
 */

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

#include "dta.h"
#include "diameter.h"

void clientProcess(int client, int server, int sess_count)
{
	int n = write(client,"Howdy!!!! from the DTA\n",23);

	char buffer[8192];

	if (n < 0){cout << "Error writing to client socket" << endl;};

	std::string SessionID = init_session_id(sess_count++);

	if ((gy_ccr_initial(server,SessionID) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {

			CBBByteArray diameter_raw(buffer, msg_length);
			DIAMETER_msg incoming_message;

			int decode_retval = incoming_message.decode_binary(
					diameter_raw);

		}
	}

	if ((gy_ccr_terminal(server,SessionID) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {
			CBBByteArray diameter_raw(buffer, msg_length);
			DIAMETER_msg incoming_message;

			int decode_retval = incoming_message.decode_binary(
					diameter_raw);

		}
	}


	if ((gy_ccr_event(server,cc_request_action_direct_debit,SessionID) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {
			CBBByteArray diameter_raw(RecvBuf, msg_length);
			DIAMETER_msg incoming_message;

			int decode_retval = incoming_message.decode_binary(
					diameter_raw);


		}
	}


	close(client);
}


dta::dta() {

}

int dta::createServer(int port)
{
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

	if((setsockopt(s_descr, SOL_SOCKET, SO_REUSEADDR, (char *) &soption, sizeof(soption))) < 0){

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

int dta::connectDiameter(std::string host, int port)
{

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

	serv_addr.sin_port = htons(port);

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

			int decode_retval = incoming_message.decode_binary(
					diameter_raw);

		}
	}


	if ((dwd_send(sockfd) > 0)) {

		int msg_length = read_diameter(sockfd);

		if (msg_length > 0) {
			CBBByteArray diameter_raw(buffer, msg_length);
			DIAMETER_msg incoming_message;

			int decode_retval = incoming_message.decode_binary(
					diameter_raw);

		}
	}

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


void dta::acceptConection(int csock,int ssock){

	int totalThreads = 0;

	while(true){

		int client = accept_client(csock);

		sess_count = sess_count + 1;

		totalThreads = totalThreads + 1;

		if(totalThreads <= num_threads)
		{
//			threads[totalThreads - 1] = std::thread(clientProcess,client,sess_count);
			clientProcess(client,ssock,sess_count);
		}
		else {

			int n = write(client,"Sorry to many connections... Please try again later\n",52);
			if (n < 0){cout << "Error writing to client socket" << endl;};

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

	int hport = atoi(argv[3]);

	dta dtao;

	int srvc = dtao.createServer(port);

	int hrvc = dtao.connectDiameter(host, hport);

	if (srvc < 0 || hrvc < 0)
	{
		cout << "!!!ERROR starting dta !!!" << endl; // prints !!!Szia from dta!!!

		return -1;
	}

	dtao.acceptConection(srvc,hrvc);

	cout << "!!!Szia from dta!!!" << endl; // prints !!!Szia from dta!!!

	return 0;

}
