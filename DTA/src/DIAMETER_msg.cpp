////////////////////////////////////////////
// 
// DIAMETER_MSG
//
////////////////////////////////////////////

//#include "StdAfx.h"
#include <string.h>
#include "DIAMETER_msg.h"

unsigned int				DIAMETER_msg::_msg_version_one     = 0x01000000;
unsigned int				DIAMETER_msg::_msg_flags_request   = 0x80000000;
unsigned int				DIAMETER_msg::_msg_flags_proxyable = 0x40000000;
unsigned int				DIAMETER_msg::_msg_flags_error     = 0x20000000;
unsigned int				DIAMETER_msg::_msg_flags_retrans   = 0x10000000;

DIAMETER_msg::diameter_msg_list_t       DIAMETER_msg::_msg_list[] =
{
	{ DIAMETER_CAPABILITIES_EXCHANGE, 	"Capabilities-Exchange" },
	{ DIAMETER_RE_AUTHORIZATION,		"Re-Authorization"	},
	{ DIAMETER_ACCOUNTING,			"Accounting"		},
	{ DIAMETER_CREDIT_CONTROL,		"Credit-Control"	},
	{ DIAMETER_ABORT_SESSION,		"Abort-Session"		},
	{ DIAMETER_SESSION_TERMINATION,		"Session-Termination"	},
	{ DIAMETER_DEVICE_WATCHDOG,		"Watchdog"		},
	{ DIAMETER_DISCONNECT_PEER,		"Disconnect-Peer"	},
	{ DIAMETER_SPENDING_LIMIT,		"Spending-Limit"	},
	{ DIAMETER_SPENDING_STATUS_NOTIFICATION, "Spending-Status"	},
	{ 0,					0			}
};

DIAMETER_msg::DIAMETER_msg() :
	_application_id(0),
	_hop_hop(0),
	_end_end(0),
	_flags(0),
	_code(0)
{
}
DIAMETER_msg::DIAMETER_msg(const DIAMETER_msg& obj) :
	_code(obj._code),
	_flags(obj._flags),
	_application_id(obj._application_id),
	_hop_hop(obj._hop_hop),
	_end_end(obj._end_end),
	_avp(obj._avp)
{
}
DIAMETER_msg&
DIAMETER_msg::operator=(const DIAMETER_msg& obj)
{
	if (this != &obj)
	{
		_code = obj._code;
		_flags = obj._flags;
		_application_id = obj._application_id;
		_hop_hop = obj._hop_hop;
		_end_end = obj._end_end;
		_avp = obj._avp;
	}
	return *this;

}
DIAMETER_msg::~DIAMETER_msg()
{
	_avp.clear();
}
CBBByteArray 
DIAMETER_msg::encode_binary()
{
	CBBByteArray		retval;
	CBBByteArray		avp_payload;
	unsigned int		flags_command;
	unsigned int		version_length;
	diameter_msg_hdr_t 	hdr;
	
	if (_avp.size() > 0)
	{
		for (int i = 0; i < (int)(_avp.size()); i++)
		{
			DIAMETER_avp avp = _avp[i];
			CBBByteArray avp_binary = avp.encode_binary();
			if (avp_binary.GetSize() > 0)
			{
				avp_payload += avp_binary;
				if ((avp_binary.GetSize() % 4) > 0)
				{
					int padding = (4 - (avp_binary.GetSize() % 4));
					while (padding > 0)
					{
						avp_payload += (CBBByte)0;
						padding--;
					}
				}
			}
		}
	}
	
	version_length = avp_payload.GetSize();
	version_length += sizeof(diameter_msg_hdr_t);
	version_length |= _msg_version_one;

	flags_command = (((_flags & 0xff) << 24) | (_code & 0xffffff));
	hdr._version_length = htonl(version_length);
	hdr._flags_command = htonl(flags_command);
	hdr._application_id = htonl(_application_id);
	hdr._hop_hop = htonl(_hop_hop);
	hdr._end_end = htonl(_end_end);
	retval += CBBByteArray ((char *)&hdr,sizeof(diameter_msg_hdr_t));
	retval += avp_payload;
	return retval;
}
int
DIAMETER_msg::decode_binary (CBBByteArray &packet)
{
	int retval = 0;
	diameter_msg_hdr_t	hdr;

	if (packet.GetSize() < sizeof(diameter_msg_hdr_t)) return retval;
	
	memcpy ((char *)&hdr,packet.GetData(),sizeof(diameter_msg_hdr_t));
	
	unsigned int length = 0;
	unsigned int version_length = ntohl(hdr._version_length);
	unsigned int flags_command = ntohl(hdr._flags_command);
	_code = flags_command & 0xffffff;
	_flags = ((flags_command >> 24) & 0xff);
	_hop_hop = ntohl(hdr._hop_hop);
	_end_end = ntohl(hdr._end_end);
	_application_id = ntohl(hdr._application_id);
	length = version_length & 0xffffff;
	retval = length;
	length -= sizeof(diameter_msg_hdr_t);
	CBBByteArray jnk = packet.Extract(sizeof(diameter_msg_hdr_t));

	if (length > (unsigned int)(packet.GetSize()))
	{
		retval = 0;
		return retval;
	}
	
	bool recursion = true;

	while(recursion == true)
	{
		DIAMETER_avp	avp;
		int reduce = avp.decode_binary(packet);
		if (reduce > 0)
		{
			setAvp(avp);
			// align to word boundary
			if ((reduce % 4) > 0)
			{
				int alignment = (4 - (reduce % 4));
				CBBByteArray recurse_jnk = packet.Extract(alignment);
			}
		}
		else
		{
			recursion = false;
		}
	}
	return retval;
}
CBBString 
DIAMETER_msg::encode_string()
{
	const CBBString start_tag("<msg>");
	const CBBString stop_tag("</msg>");
	const CBBString command_start_tag("<command>");
	const CBBString command_stop_tag("</command>");
	const CBBString application_start_tag("<application>");
	const CBBString application_stop_tag("</application>");
	const CBBString hop_start_tag("<hop>");
	const CBBString hop_stop_tag("</hop>");
	const CBBString end_start_tag("<end>");
	const CBBString end_stop_tag("</end>");
	const CBBString request("-Request");
	const CBBString answer("-Answer");
	CBBString name = getNameFromCode(_code);
	CBBString	retval;
	
	if (name.length() > 0)
	{
		char cmd[256];
		retval += start_tag;
		retval += "\n";
		retval += command_start_tag;
		retval += name;
		if (_flags & ((_msg_flags_request >> 24) & 0xff))
		{
			retval += request;
		}
		else
		{
			retval += answer;
		}
		retval += command_stop_tag;
		retval += "\n";
		retval += application_start_tag;
		sprintf (cmd,"0x%x",_application_id);
		retval += CBBString(cmd);
		retval += application_stop_tag;
		retval += "\n";
		retval += hop_start_tag;
		sprintf (cmd,"%u",_hop_hop);
		retval += CBBString(cmd);
		retval += hop_stop_tag;
		retval += "\n";
		retval += end_start_tag;
		sprintf (cmd,"%u",_end_end);
		retval += CBBString(cmd);
		retval += end_stop_tag;
		retval += "\n";
		
		for (int i = 0; i < (int)(_avp.size()); i++)
		{
			retval += _avp[i].encode_string();
		}
		retval += stop_tag;
		retval += "\n";
	}
	return retval;
}
int
DIAMETER_msg::decode_string(char *osp, int offset, int length)
{
	const CBBString start_tag("<msg>");
	const CBBString stop_tag("</msg>");
	const CBBString command_start_tag("<command>");
	const CBBString command_stop_tag("</command>");
	const CBBString application_start_tag("<application>");
	const CBBString application_stop_tag("</application>");
	const CBBString hop_start_tag("<hop>");
	const CBBString hop_stop_tag("</hop>");
	const CBBString avp_start_tag("<avp>");
	const CBBString end_start_tag("<end>");
	const CBBString end_stop_tag("</end>");
	const CBBString hex_base("0x");

	char *sp = osp;
	int retval = 0;

	// <msg>
	// <command>name</command>
	// <application>value</application>
	// <hop>value</hop>
	// <end>value</end>
	// .... <avp></avp>
	// </msg>  
	//

	char *command_start = (char *)0;
	char *command_end = (char *)0;
	char *application_start = (char *)0;
	char *application_end = (char *)0;
	char *hop_start = (char *)0;
	char *hop_end = (char *)0;
	char *end_start = (char *)0;
	char *end_end = (char *)0;
	bool in_command_tag = false;
	bool in_application_tag = false;
	bool in_hop_tag = false;
	bool in_end_tag = false;
	bool in_stop_tag = false;
	
	// keep going as long as we can parse the </msg> end tag
	while (((offset + retval + (int)(stop_tag.length())) < length) &&
	       (in_stop_tag == false))
	{
 		if (strncmp(sp,avp_start_tag.data(),avp_start_tag.length()) == 0)
		{
			DIAMETER_avp avp;
			int gavp_retval = avp.decode_string(sp,offset+retval,length);
			if (gavp_retval != 0)
			{
				_avp.push_back(avp);
				retval += gavp_retval;
				sp += gavp_retval;
			}
			else
			{
				return 0;
			}
		}
		else if (strncmp (sp,start_tag.data(),start_tag.length()) == 0)
		{
			sp += start_tag.length();
			retval += start_tag.length();
			in_stop_tag = false;
		}
		else if (strncmp (sp,stop_tag.data(),stop_tag.length()) == 0)
		{
			sp += stop_tag.length();
			retval += stop_tag.length();
			in_stop_tag = true;
		}
		else if (strncmp (sp,command_start_tag.data(),command_start_tag.length()) == 0)
		{
			sp += command_start_tag.length();
			retval += command_start_tag.length();
			command_start = sp;
			command_end = sp;
			in_command_tag = true;
		}
		else if (strncmp (sp,command_stop_tag.data(),command_stop_tag.length()) == 0)
		{
			sp += command_stop_tag.length();
			retval += command_stop_tag.length();
			in_command_tag = false;
		}
		else if (strncmp (sp,application_start_tag.data(),application_start_tag.length()) == 0)
		{
			sp += application_start_tag.length();
			retval += application_start_tag.length();
			application_start = sp;
			application_end = sp;
			in_application_tag = true;
		}
		else if (strncmp (sp,application_stop_tag.data(),application_stop_tag.length()) == 0)
		{
			sp += application_stop_tag.length();
			retval += application_stop_tag.length();
			in_application_tag = false;
		}
		else if (strncmp (sp,hop_start_tag.data(),hop_start_tag.length()) == 0)
		{
			sp += hop_start_tag.length();
			retval += hop_start_tag.length();
			hop_start = sp;
			hop_end = sp;
			in_hop_tag = true;
		}
		else if (strncmp (sp,hop_stop_tag.data(),hop_stop_tag.length()) == 0)
		{
			sp += hop_stop_tag.length();
			retval += hop_stop_tag.length();
			in_hop_tag = false;
		}
		else if (strncmp (sp,end_start_tag.data(),end_start_tag.length()) == 0)
		{
			sp += end_start_tag.length();
			retval += end_start_tag.length();
			end_start = sp;
			end_end = sp;
			in_end_tag = true;
		}
		else if (strncmp (sp,end_stop_tag.data(),end_stop_tag.length()) == 0)
		{
			sp += end_stop_tag.length();
			retval += end_stop_tag.length();
			in_end_tag = false;
		}
		else if (in_command_tag == true)
		{
			command_end++;
			sp++;
			retval++;
		}
		else if (in_application_tag == true)
		{
			application_end++;
			sp++;
			retval++;
		}
		else if (in_hop_tag == true)
		{
			hop_end++;
			sp++;
			retval++;
		}
		else if (in_end_tag == true)
		{
			end_end++;
			sp++;
			retval++;
		}
		else
		{
			sp++;
			retval++;
		}
 	}
      	
	if ((command_start != (char *)0) && (command_end != (char *)0))
	{
		while (command_start != command_end)
		{
			if ((*command_start != ' ') &&
			    (*command_start != '\t') &&
			    (*command_start != '\r') &&
			    (*command_start != '\n'))
			{
				break;
			}
			command_start++;
		}
		while (command_end != command_start)
		{
			if ((*command_end != ' ') &&
			    (*command_end != '\t') &&
			    (*command_end != '\r') &&
			    (*command_end != '<') &&
			    (*command_end != '\n'))
			{
				command_end++;
				break;
			}
			command_end--;
		}
		if (command_end == command_start) command_end++;        // single character
      		CBBString commandString = CBBString(command_start,command_end - command_start);
      		unsigned int code = getCodeFromName(commandString);
      		bool is_request = getTypeFromName(commandString);
		if (code == 0) return 0;
		_code = code;
		if (is_request) 
		{
			_flags = ((_msg_flags_request >> 24) & 0xff);
		}
		else
		{
			_flags = 0;
		}
	}
	else
	{
		return 0;
	}
      	
	if ((application_start != (char *)0) && (application_end != (char *)0))
	{
		while (application_start != application_end)
		{
			if ((*application_start != ' ') &&
			    (*application_start != '\t') &&
			    (*application_start != '\r') &&
			    (*application_start != '\n'))
			{
				break;
			}
			application_start++;
		}
		while (application_end != application_start)
		{
			if ((*application_end != ' ') &&
			    (*application_end != '\t') &&
			    (*application_end != '\r') &&
			    (*application_end != '<') &&
			    (*application_end != '\n'))
			{
				application_end++;
				break;
			}
			application_end--;
		}
		if (application_end == application_start) application_end++;        // single character
      		
		CBBString applicationString = CBBString(application_start,application_end - application_start);
		unsigned int signed_value;
		if (strncmp(applicationString.data(),hex_base.data(),hex_base.length()) == 0)
		{
			signed_value = strtoul(applicationString.data(),(char **)0,16);
		}
		else
		{
			signed_value = strtoul(applicationString.data(),(char **)0,10);
		}
		_application_id = signed_value;
	}
	else
	{
		_application_id = DIAMETER_APPLICATION_GX;
	}
	
	if ((hop_start != (char *)0) && (hop_end != (char *)0))
	{
		while (hop_start != hop_end)
		{
			if ((*hop_start != ' ') &&
			    (*hop_start != '\t') &&
			    (*hop_start != '\r') &&
			    (*hop_start != '\n'))
			{
				break;
			}
			hop_start++;
		}
		while (hop_end != hop_start)
		{
			if ((*hop_end != ' ') &&
			    (*hop_end != '\t') &&
			    (*hop_end != '\r') &&
			    (*hop_end != '<') &&
			    (*hop_end != '\n'))
			{
				hop_end++;
				break;
			}
			hop_end--;
		}
		if (hop_end == hop_start) hop_end++;        // single character
      		
		CBBString hopString = CBBString(hop_start,hop_end - hop_start);
		unsigned int signed_value;
		if (strncmp(hopString.data(),hex_base.data(),hex_base.length()) == 0)
		{
			signed_value = strtoul(hopString.data(),(char **)0,16);
		}
		else
		{
			signed_value = strtoul(hopString.data(),(char **)0,10);
		}
		_hop_hop = signed_value;
	}
	else
	{
		_hop_hop = 0;
	}
	
	if ((end_start != (char *)0) && (end_end != (char *)0))
	{
		while (end_start != end_end)
		{
			if ((*end_start != ' ') &&
			    (*end_start != '\t') &&
			    (*end_start != '\r') &&
			    (*end_start != '\n'))
			{
				break;
			}
			end_start++;
		}
		while (end_end != end_start)
		{
			if ((*end_end != ' ') &&
			    (*end_end != '\t') &&
			    (*end_end != '\r') &&
			    (*end_end != '<') &&
			    (*end_end != '\n'))
			{
				end_end++;
				break;
			}
			end_end--;
		}
		if (end_end == end_start) end_end++;        // single character
      		
		CBBString endString = CBBString(end_start,end_end - end_start);
		unsigned int signed_value;
		if (strncmp(endString.data(),hex_base.data(),hex_base.length()) == 0)
		{
			signed_value = strtoul(endString.data(),(char **)0,16);
		}
		else
		{
			signed_value = strtoul(endString.data(),(char **)0,10);
		}
		_end_end = signed_value;
	}
	else
	{
		_end_end = 0;
	}

	return retval;
}
DIAMETER_avp
DIAMETER_msg::getAvp(int index) const
{
	if ((index >= 0) && (index < (int)(_avp.size())))
	{
		return (_avp[index]);
	}
	else
	{
		return DIAMETER_avp();
	}
}
unsigned int 
DIAMETER_msg::getCodeFromName(CBBString& name)
{
	diameter_msg_list_t	*msg_p;

	for (msg_p = _msg_list; msg_p->_code != 0; msg_p++)
	{
		if (strncmp ((char *)name.data(),msg_p->_name,strlen(msg_p->_name)) == 0)
		{
			return msg_p->_code;
		}
	}
	return 0;
}
CBBString
DIAMETER_msg::getNameFromCode(unsigned int code)
{
	diameter_msg_list_t	*msg_p;

	for (msg_p = _msg_list; msg_p->_code != 0; msg_p++)
	{
		if (msg_p->_code == code)
		{
			return CBBString(msg_p->_name);
		}
	}
	return CBBString();
}
bool
DIAMETER_msg::getTypeFromName(CBBString& name)
{
	diameter_msg_list_t	*msg_p;

	for (msg_p = _msg_list; msg_p->_code != 0; msg_p++)
	{
		CBBString request(msg_p->_name);
		CBBString answer(msg_p->_name);
		request += "-Request";
		answer += "-Answer";
		if (strcmp ((char *)name.data(),(char *)request.data()) == 0)
		{
			return true;
		}
		else if (strcmp ((char *)name.data(),(char *)answer.data()) == 0)
		{
			return false;
		}
	}
	return false;
}
