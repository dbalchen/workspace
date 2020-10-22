////////////////////////////////////////////
// 
// DIAMETER_MSG
//
//
////////////////////////////////////////////
#ifndef _DIAMETER_MSG_H
#define _DIAMETER_MSG_H

#include <vector>
#include "CBBByteArray.h"
#include "DIAMETER_defs.h"
#include "DIAMETER_avp.h"

class DIAMETER_msg
{
  public :
	DIAMETER_msg();
	DIAMETER_msg(const DIAMETER_msg& obj);
	virtual ~DIAMETER_msg();
	DIAMETER_msg& operator=(const DIAMETER_msg& obj);
	virtual CBBByteArray encode_binary();
	virtual int decode_binary (CBBByteArray &packet);
	virtual CBBString encode_string();
	virtual int decode_string (char *sp, int offset, int length);
	virtual void setCode(unsigned int code) { _code = code; }
	virtual void setFlags(unsigned int flags) { _flags = flags; }
	virtual void setApplicationID(unsigned int app_id) { _application_id = app_id; }
	virtual void setHopHop(unsigned int id) { _hop_hop = id; }
	virtual void setEndEnd(unsigned int id) { _end_end = id; }
	virtual void setAvp(const DIAMETER_avp& avp) { _avp.push_back(avp); }
	virtual unsigned int getCode() const { return _code; }
	virtual unsigned int getFlags() const { return _flags; }
	virtual unsigned int getApplicationID() const { return _application_id; }
	virtual unsigned int getHopHop() const { return _hop_hop; }
	virtual unsigned int getEndEnd() const { return _end_end; }
	virtual int getNumAvp() const { return (int)(_avp.size()); }
	virtual DIAMETER_avp getAvp(int index) const;
	virtual CBBString getNameFromCode(unsigned int code);
	virtual unsigned int getCodeFromName(CBBString& name);
	virtual bool getTypeFromName(CBBString& name);
  	
  private :
	// RFC 3588
	typedef struct diameter_msg_hdr_s
	{
		unsigned int	_version_length;
		unsigned int	_flags_command;
		unsigned int	_application_id;
		unsigned int	_hop_hop;
		unsigned int	_end_end;
	}diameter_msg_hdr_t;
	
	typedef struct diameter_msg_list_s
	{
		unsigned int	_code;
		const char	*_name;
	}diameter_msg_list_t;
	
	unsigned int		_code;
	unsigned int		_flags;
	unsigned int		_application_id;
	unsigned int		_hop_hop;
	unsigned int		_end_end;
	vector<DIAMETER_avp>	_avp;

	static unsigned int		_msg_version_one;
	static unsigned int		_msg_flags_request;
	static unsigned int		_msg_flags_proxyable;
	static unsigned int		_msg_flags_error;
	static unsigned int		_msg_flags_retrans;
	static diameter_msg_list_t	_msg_list[];

};
#endif
