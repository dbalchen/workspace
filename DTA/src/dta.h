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

	int num_threads = 11;

	int sess_count = 0;

	short unsigned int port;

	std::string host;

	short unsigned int sport;

	int client_connection(int server_fd);

	void acceptConection(int csock, int ssock);

public:

	dta(short unsigned int tport, std::string thost, short unsigned int sport);

	int createServer(void);

	int connectDiameter(void);

	virtual ~dta();
};

// Define DTA class
dta::dta(short unsigned int tport, std::string shost, short unsigned int tsport) {

	port = tport;	host = shost;	sport = tsport;

	int srvc = this->createServer();

	int hrvc = this->connectDiameter();

	if (srvc < 0 || hrvc < 0) {

		cerr << "DTA: !!!ERROR starting dta !!!" << endl;

		exit(-1);
	}

	cout << "DTA: Started Watchdog server" << endl;

	std::thread threadObj(watchDog(), hrvc);

	threadObj.detach();

	cout << "DTA: Accepting Connections" << endl;

	this->acceptConection(srvc, hrvc);

	cout << "DTA: " << endl;

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

int dta::client_connection(int server_fd) {

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

	int totalThreads = 0;

	std::vector<std::future<int>> threadVector;

	while (true) {

		int client = client_connection(csock);

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
