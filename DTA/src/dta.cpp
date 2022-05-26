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

// Global thread lock
std::mutex door;

// Default Values

std::string LocalHost = "Localhost";

std::string LocalIPAddress = "192.168.0.1";

std::string RemoteHost = "Localhost" ; //"mqr35batch.uscc.com";

// Default Ports
short unsigned int dta_port = 8888;

short unsigned int tcd_port = 3868;//11151;

// Application includes
#include "diameter.h"
#include "watchdog.h"
#include "callDiameter.h"
#include "dta.h"

// Main Function

int main(int argc, char *argv[]) {

	if (argc == 6) {

		LocalHost = argv[1];

		LocalIPAddress = argv[2];

		dta_port = (unsigned short) atoi(argv[3]);

		RemoteHost = argv[4];

		tcd_port = (unsigned short) atoi(argv[5]);

	} else if (argc == 7) {

		std::string logfile = argv[6];

		freopen(logfile.c_str(), "w", stdout);

	} else {

		// Add for future

	}

	cout << "!!!Szia from dta!!!" << endl; // prints Szia!!!

	// Start the DTA server application.

	dta dtao(dta_port, RemoteHost, tcd_port);

	// Stop the DTA server application

	cout << "!!!Szia from dta!!!" << endl; // prints Szia!!!

	return 0;
}
