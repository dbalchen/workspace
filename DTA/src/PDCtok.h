#ifndef _PDCTOK_H
#define _PDCTOK_H
#include <sys/types.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>

using namespace std;

//
// general purpose string tokenizer
//
class PDCtok
{
	public :
		PDCtok(std::string s, char delim = '|');
		virtual ~PDCtok();
		int count() const { return _token_list.size(); }
//		int count() const { return (int) _token_list.size(); }
		std::string by_index(const int index) const;
		std::string by_string(const std::string tok);
	private :
		vector<std::string>	_token_list;
};
#endif
