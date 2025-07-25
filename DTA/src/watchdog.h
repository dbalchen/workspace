/*
 * watchdog.h
 *
 *  Created on: Feb 2, 2021
 *      Author: dbalchen
 */

#ifndef SRC_WATCHDOG_H_
#define SRC_WATCHDOG_H_

void current_time_point(chrono::system_clock::time_point timePt) {

	time_t timeStamp = chrono::system_clock::to_time_t(timePt);

}

class watchDog {

public:

	void operator()(int sockfd);

};

void watchDog::operator()(int sockfd) {

	char buffer[8192];

	while (true) {

		current_time_point(chrono::system_clock::now());

		chrono::system_clock::time_point timePt = chrono::system_clock::now()
				+ chrono::seconds(30);

		// Lock to prevent thread issues

		door.lock();

		if ((dwd_send(sockfd) > 0)) {

//			int msg_length = read_diameter(sockfd);
			int msg_length = read_diameter(sockfd,buffer);

			if (msg_length > 0) {

				CBBByteArray diameter_raw(buffer, msg_length);

				DIAMETER_msg incoming_message;

				int decode_retval = incoming_message.decode_binary(
						diameter_raw);

				cout << "Watchdog TC connect has a return value = " << decode_retval << endl;

			}
		}

		door.unlock();

		this_thread::sleep_until(timePt);

	}
}

#endif /* SRC_WATCHDOG_H_ */
