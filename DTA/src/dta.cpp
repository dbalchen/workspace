/*
 * dta.cpp
 *
 *  Created on: Sep 30, 2020
 *      Author: dbalchen
 */

#include <iostream>
#include <bits/stdc++.h>
#include <thread>
#include <future>
#include <string>
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
#include <mutex>

void current_time_point(chrono::system_clock::time_point timePt) {
	time_t timeStamp = chrono::system_clock::to_time_t(timePt);
}

std::mutex door;


#include "diameter.h"
#include "watchdog.h"
#include "client.h"
#include "dta.h"

int main(int argc, char *argv[]) {

	int dta_port = 8888;

	int tcServer_port = 3868;

	std::string tcServer_host = "localhost";

	/*	std::string logfile = argv[4];

	 if(!logfile.empty())
	 {
	 std::ofstream cout(logfile.c_str());
	 }
	 */

	cout << "!!!Szia from dta!!!" << endl; // prints !!!Szia from dDiameter!!!

	// Quick Defaults

	if (argc == 4) {

		dta_port = atoi(argv[1]);

		tcServer_host = argv[2];

		tcServer_port = atoi(argv[3]);
	}

	dta dtao(dta_port, tcServer_host, tcServer_port);
//
//	int srvc = dtao.createServer();
//
//	int hrvc = dtao.connectDiameter();
//
//	std::thread threadObj(watchDog(), hrvc);
//
//	threadObj.detach();
//
//	cout << "DTA: Starting Watchdog server" << endl;
//
//	if (srvc < 0 || hrvc < 0) {
//
//		cerr << "DTA: !!!ERROR starting dta !!!" << endl;
//
//		return -1;
//	}
//
//	dtao.acceptConection(srvc, hrvc);

	cout << "!!!Szia from dta!!!" << endl; // prints !!!Szia from dta!!!

	return 0;
}
