////////////////////////////////////////////
// 
// DIAMETER_AVP
//
//
////////////////////////////////////////////
#ifndef _DIAMETER_AVP_H
#define _DIAMETER_AVP_H

#include <vector>
#include <stdlib.h>

//#include <Winsock2.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>

#include "CBBByteArray.h"
#include "DIAMETER_defs.h"

class DIAMETER_avp
{
  public :
	DIAMETER_avp();
	DIAMETER_avp(const DIAMETER_avp& obj);
	virtual ~DIAMETER_avp();
	DIAMETER_avp& operator=(const DIAMETER_avp& obj);
	virtual CBBByteArray encode_binary();
	virtual int decode_binary (CBBByteArray &packet);
	virtual CBBString encode_string();
	virtual int decode_string (char *sp, int offset, int length);
	virtual void setCode(unsigned int code) { _code = code; }
	virtual void setFlags(unsigned int flags) { _flags = flags; }
	virtual void setVendorID(unsigned int vendor) { _vendor = vendor; }
	virtual void setAvp(const DIAMETER_avp& avp) { _group_avp.push_back(avp); }
	virtual void setLongValue(const unsigned long long value);
	virtual void setValue(const unsigned int value);
	virtual void setValue(const CBBByteArray& value) { _value = value; }
	virtual void setValue(const CBBString& value);
	virtual unsigned int getCode() const { return _code; }
	virtual unsigned int getFlags() const { return _flags; }
	virtual unsigned int getVendorID() const { return _vendor; }
	virtual unsigned int getValueAsInt();
	virtual unsigned long long getValueAsLongLong();
	virtual CBBByteArray getTimeValue(int offset = 0) const;
	virtual CBBByteArray getValue() const { return _value; }
	virtual CBBString getValueAsString();
	virtual int getNumAvp() const { return (int)(_group_avp.size()); }
	virtual DIAMETER_avp getAvp(int index) const;
  	
  	virtual unsigned int getAvpCodeFromName(CBBString& name);
  	virtual CBBString getAvpNameFromCode(unsigned int code, unsigned int vendor);
  	virtual unsigned int getAvpTypeFromName(CBBString& name);
  	virtual unsigned int getAvpTypeFromCode(unsigned int code, unsigned int vendor);
  	virtual bool getAvpMandatoryFromCode(unsigned int code, unsigned int vendor);
  	virtual unsigned int getAvpVendorFromName(CBBString& name);
  	virtual unsigned int getAvpVendorFromCode(unsigned int code);
  
  	virtual unsigned long dd_i(const CBBString& ip) const;
	virtual CBBByteArray colon_i(const CBBString& ip) const;
  	virtual CBBString i_dd(const unsigned long ip) const;
  	virtual unsigned long long htonll(const unsigned long long value) const;
  	virtual unsigned long long ntohll(const unsigned long long value) const;
  private :
	// RFC 3588
	typedef struct diameter_avp_hdr_s
	{
		unsigned int	_code;
		unsigned int	_flags_length;
	}diameter_avp_hdr_t;
	typedef struct diameter_vendor_avp_hdr_s
	{
		unsigned int	_code;
		unsigned int	_flags_length;
		unsigned int	_vendor;
	}diameter_vendor_avp_hdr_t;
	typedef struct diameter_avp_list_s
	{
		unsigned int	_code;
		const char	*_name;
		unsigned int	_type;
		unsigned int	_vendor;
		bool 		_mandatory;
	}diameter_avp_list_t;
	typedef union endian_ll
	{
		unsigned long long ll;
		unsigned char	    c[8];
	}endian_ll_t;
	
	unsigned int		_code;
	unsigned int		_flags;
	unsigned int		_vendor;
	CBBByteArray		_value;
	vector<DIAMETER_avp>	_group_avp;

	static unsigned int		_avp_flags_vendor;
	static unsigned int		_avp_flags_mandatory;
	static unsigned int		_avp_flags_protected;
	static diameter_avp_list_t	_avp_list[];
};
#endif
