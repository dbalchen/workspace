/*
 * dta.h
 *
 *  Created on: Sep 30, 2020
 *      Author: dbalchen
 */

#ifndef DEBUG_SRC_DTA_H_
#define DEBUG_SRC_DTA_H_

class dta {

private:

	int num_threads = 10;

	int sess_count = 0;

	int port;

	std::string host;

	int sport;

	int accept_client(int server_fd);

public:

	dta(int tport, std::string thost, int sport);

	int createServer(void);

	int connectDiameter(void);

	void acceptConection(int csock, int ssock);

	virtual ~dta();
};

// Define DTA class
dta::dta(int tport, std::string shost, int tsport) {

	port = tport;
	host = shost;
	sport = tsport;
}

int dta::createServer(void) {

	cout << "DTA: Creating a DTA server instance" << endl;

	struct sockaddr_in s_name;
	struct sockaddr *ssdp;
	int s_descr;
	int soption;

	s_descr = (int) socket(PF_INET, SOCK_STREAM, 0);

	s_name.sin_family = AF_INET;

	s_name.sin_addr.s_addr = INADDR_ANY;

	s_name.sin_port = htons(port);

	soption = 1;

	if ((setsockopt(s_descr, SOL_SOCKET, SO_REUSEADDR, (char*) &soption,
			sizeof(soption))) < 0) {

		return -1;
	}

	ssdp = (struct sockaddr*) &s_name;

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
		cerr << "Cannot create a connection to the diameter server." << endl;
		return -1;
	}

	bzero((char*) &serv_addr, sizeof(serv_addr));

	serv_addr.sin_family = AF_INET;

	bcopy((char*) server->h_addr, (char*) &serv_addr.sin_addr.s_addr,
			server->h_length);

	serv_addr.sin_port = htons(sport);

	int connection_status = connect(sockfd, (struct sockaddr*) &serv_addr,
			sizeof(serv_addr));

	if (connection_status < 0) {

		cerr << "Cannot create a connection to the diameter service." << endl;

		return -1;
	}

	if (cer_send(sockfd) > 0) {
		int msg_length = read_diameter(sockfd);

		if (msg_length > 0) {

			CBBByteArray diameter_raw(buffer, msg_length);

			DIAMETER_msg incoming_message;

			int decode_retval = incoming_message.decode_binary(diameter_raw);

		} else {

		}
	} else {

		cerr << "Could not send certificate to TC via diameter." << endl;
	}

	return sockfd;
}

int dta::accept_client(int server_fd) {

	int client_fd = -1;
	socklen_t client_addr_len;
	struct sockaddr_in client_name;
	struct sockaddr *client_name_p;

	memset((struct sockaddr_in*) &client_name, 0, sizeof(struct sockaddr_in));

	client_name_p = (struct sockaddr*) &client_name;

	client_addr_len = sizeof(client_name);

	client_fd = accept(server_fd, client_name_p, &client_addr_len);

	return (client_fd);
}

void dta::acceptConection(int csock, int ssock) {
	// Crazy Stuff here

	int totalThreads = -1;

	std::vector<std::future<int>> threadVector;

	while (true) {

		int client = accept_client(csock);

		sess_count = sess_count + 1;

		totalThreads = totalThreads + 1;

		if (totalThreads > num_threads) {

			for (long unsigned int i = 0; i < threadVector.size(); ++i) {

				int funcreturn = threadVector.at(i).get();

				if (funcreturn != 0)
				{
					cerr << "DTA : Thread ended in Error!!\n" << endl;
				}
			}

			threadVector.clear();
			totalThreads = 1;

		}

		threadVector.push_back(
				std::async(std::launch::async, callDiameter, client, ssock, sess_count)
		);

	}

}


dta::~dta() {
	cout << "Destroying a dta server instance" << endl;
}

#endif /* DEBUG_SRC_DTA_H_ */
