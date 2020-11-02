/*
 * dta.h
 *
 *  Created on: Sep 30, 2020
 *      Author: dbalchen
 */

#ifndef DEBUG_SRC_DTA_H_
#define DEBUG_SRC_DTA_H_

/*
 *
 */

using namespace std;

class dta {

private:

	const static int num_threads = 10;

	std::vector<std::thread> vecOfThreads;

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

#endif /* DEBUG_SRC_DTA_H_ */
