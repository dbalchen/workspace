// #include "StdAfx.h"
#include "PDCtok.h"

PDCtok::PDCtok(std::string s, char delim)
{
	std::stringstream ss(s);
	std::string tok;
	_token_list.clear();
	while (std::getline(ss, tok, delim))
	{
		_token_list.push_back(tok);
	}
	if (_token_list.size() > 0)
	{
		int index = _token_list.size() - 1;
		std::size_t nl = _token_list[index].find("\n");
		if (nl != std::string::npos)
		{
			_token_list[index][nl] = '\0';
		}
	}
}
PDCtok::~PDCtok()
{
	_token_list.clear();
}
std::string
PDCtok::by_index(int index) const
{
	std::string retval;
	if ((index >= 0) && (index < _token_list.size()))
	{
		retval = _token_list[index];
	}
	return retval;
}
std::string
PDCtok::by_string(const std::string tok)
{
	std::string retval;
	vector<std::string>::iterator s_i;
	for (s_i = _token_list.begin();
	     s_i != _token_list.end();
	     ++s_i)
	{
		try
		{
			if (s_i->compare(0,tok.length(),tok) == 0)
			{
				retval = *s_i;
				break;
			}
		}
		catch (...)
		{
			break;
		}
	}
	return retval;
}
