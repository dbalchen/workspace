/*
 * client.h
 *
 *  Created on: Feb 2, 2021
 *      Author: dbalchen
 */

#ifndef SRC_CALLDIAMETER_H_
#define SRC_CALLDIAMETER_H_

#include <unistd.h>
using namespace std;

int callDiameter(int client, int server, int sess_count) {

	char buffer[8192];
	unsigned int dRequest;
	int decode_retval;

	char RecvBuf[8192];

	cout << "CallDiameter: Running the CallDiameter function" << endl;

	bzero((char*) &buffer, sizeof(buffer));

	long int n = write(client, "Howdy!!!! from the DTA\n", 23);

	if (n < 0) {

		cerr << "Failure writing to client socket" << endl;

		close(client);

		return -1;
	}
	;

	n = read(client, buffer, 255);

	if (n < 0) {

		cerr << "Failure reading from client socket" << endl;

		close(client);

		return -1;
	}
	;

	std::string request = (std::string(buffer));

	request = request.substr(0, request.length());

	// Try/catch

	size_t pos = 0;
	std::string token;

	cout << "DTA:CallDiameter: Parsing the request" << endl;

	vector<std::string> parmList;

	while ((pos = request.find(",")) != std::string::npos) {

		token = request.substr(0, pos);

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

		write(client, "Failure: Transaction Type not Supported\n", 23);

		cerr << "DTA:CallDiameter: Transaction Type not Supported" << endl;

		close(client);

		return (-1);

	}

	std::string SessionID = init_session_id(sess_count-1);

	cout << "DTA:CallDiameter: Initialize the GY Interface" << endl;

	door.lock();

	if ((gy_ccr_initial(server, SessionID, parmList[1], parmList[2]) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {

			CBBByteArray diameter_raw(buffer, msg_length);
			DIAMETER_msg incoming_message;

			decode_retval = incoming_message.decode_binary(diameter_raw);
			cout << "DTA:CallDiameter: Initial Return Value  = " << decode_retval << endl;

		} else {

			door.unlock();

			write(client, "Could not create session ID\n", 28);

			cerr << "DTA:CallDiameter: Failure to create session ID" << endl;

			close(client);

			return (-1);

		}
	}

// From Amdocs


	if ((gy_ccr_event(server, dRequest, SessionID, parmList[1], parmList[2]) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {
			CBBByteArray diameter_raw(RecvBuf, msg_length);
			DIAMETER_msg incoming_message;

			decode_retval = incoming_message.decode_binary(diameter_raw);
			cout << "DTA:CallDiameter: Rated event return value " << decode_retval << endl;

		} else {

			door.unlock();

			write(client, "Failure to complete Transaction\n", 32);

			cerr << "DTA:CallDiameter: Failure to complete Transaction" << endl;

			close(client);
			return (-1);

		}
	}

	SessionID = init_session_id(sess_count);

	if ((gy_ccr_terminal(server, SessionID, parmList[1], parmList[2], dRequest) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {

			CBBByteArray diameter_raw(buffer, msg_length);
			DIAMETER_msg incoming_message;

			decode_retval = incoming_message.decode_binary(diameter_raw);
			cout << "DTA:CallDiameter: Terminate Return Value " << decode_retval << endl;

		} else {

			door.unlock();

			write(client, "Could not commit Transaction\n", 28);

			cerr << "DTA:CallDiameter: Could not commit Transaction" << endl;

			close(client);
			return (-1);

		}
	}

	door.unlock();

	write(client, "Transaction Successful \n", 25);

	cout << "DTA:CallDiameter: Transaction Successful" << endl;

	close(client);

	cout << "DTA:CallDiameter: Client Closed" << endl;
	return (0);
}

#endif /* SRC_CALLDIAMETER_H_ */
