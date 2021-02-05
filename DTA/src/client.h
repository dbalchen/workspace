/*
 * client.h
 *
 *  Created on: Feb 2, 2021
 *      Author: dbalchen
 */

#ifndef SRC_CLIENT_H_
#define SRC_CLIENT_H_

#include <thread>
#include <future>
#include <unistd.h>

using namespace std;

int callDiameter(int client, int server, int sess_count) {

	char buffer[8192];
	unsigned int dRequest;

	int decode_retval;

	vector<std::string> parmList;

	int n = write(client, "Howdy!!!! from the DTA\n", 23);

	bzero((char*) &buffer, sizeof(buffer));

	if (n < 0) {

		cout << "Error writing to client socket" << endl;

	}
	;

	n = read(client, buffer, 255);

	if (n < 0) {

		cout << "Error reading from client socket" << endl;

	}
	;

	std::string request = (std::string(buffer));

	request = request.substr(0, request.length() - 2);

	// Try/catch

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
		return (-1);

	}

	std::string SessionID = init_session_id(sess_count++);

	if ((gy_ccr_initial(server, SessionID, parmList[1]) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {

			CBBByteArray diameter_raw(buffer, msg_length);
			DIAMETER_msg incoming_message;

			decode_retval = incoming_message.decode_binary(diameter_raw);
		} else {

			write(client, "Could not create session ID\n", 28);
			close(client);
			return (-1);

		}

	}

	if ((gy_ccr_event(server, dRequest, SessionID, parmList[1]) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {
			CBBByteArray diameter_raw(RecvBuf, msg_length);
			DIAMETER_msg incoming_message;

			decode_retval = incoming_message.decode_binary(diameter_raw);

		} else {

			write(client, "Failure to complete Transaction\n", 32);
			close(client);
			return (-1);

		}
	}

	if ((gy_ccr_terminal(server, SessionID, parmList[1]) > 0)) {

		int msg_length = read_diameter(server);

		if (msg_length > 0) {
			CBBByteArray diameter_raw(buffer, msg_length);
			DIAMETER_msg incoming_message;

			decode_retval = incoming_message.decode_binary(diameter_raw);

		} else {

			write(client, "Could not commit Transaction\n", 28);
			close(client);
			return (-1);
		}
	}

	write(client, "Transaction Successful\n", 23);

	cout << "Transaction Successful" << endl;

	close(client);

	sleep(30);
	return (0);
}

class clientThread {

private:

	int client;
	int server;
	int sess_count;

	int future;

public:

	bool running = false;

	void spawn();

	void checkThread(void);

	clientThread(int tclient, int tserver, int tsess_count);

};

clientThread::clientThread(int tclient, int tserver, int tsess_count) {

	client = tclient;
	server = tserver;
	sess_count = tsess_count;
	running = true;

}

void clientThread::spawn(void) {

	running = true;
	auto future = std::async(callDiameter, client, server, sess_count);

}

void clientThread::checkThread(void)
{
//	future.get();

	running = false;
}



#endif /* SRC_CLIENT_H_ */
