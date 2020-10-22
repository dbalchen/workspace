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

class dta {

private:

const static int num_threads = 10;

std::thread threads[num_threads];

int sess_count = 0;

int accept_client(int server_fd);

public:

	dta();

	int createServer(int port);

	int connectDiameter(std::string server, int port);

	void acceptConection(int csock, int ssock);

	virtual ~dta();

};

#endif /* DEBUG_SRC_DTA_H_ */
