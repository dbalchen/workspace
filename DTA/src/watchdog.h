/*
 * watchdog.h
 *
 *  Created on: Feb 2, 2021
 *      Author: dbalchen
 */

#ifndef SRC_WATCHDOG_H_
#define SRC_WATCHDOG_H_

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

		if ((dwd_send(sockfd) > 0)) {

			int msg_length = read_diameter(sockfd);

			if (msg_length > 0) {
				CBBByteArray diameter_raw(buffer, msg_length);
				DIAMETER_msg incoming_message;

				int decode_retval = incoming_message.decode_binary(
						diameter_raw);

			}
		}

		this_thread::sleep_until(timePt);

	}
}

#endif /* SRC_WATCHDOG_H_ */
