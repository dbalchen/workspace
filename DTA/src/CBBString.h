/////////////////////////////////////////////////////////////////////////////
//
//   FILE: CBBString.H
//
//   PURPOSE: Declare the class data members and member functions
//
//   CHANGE HISTORY:
//
/////////////////////////////////////////////////////////////////////////////
#ifndef _CBBSTRING_H
#define _CBBSTRING_H

#include <string>

#include "CBBDefs.h"

using std::string;

class CBBString : public string
{
  public:

    // Default constuctor
    CBBString();

    CBBString(const char *cstr) : string(cstr)
    {
    }
    CBBString(const char *cstr, int size) : string(cstr, size)
    {
    }
    CBBString(char cstr) : string(1, cstr)
    {
    }
    CBBString(char cstr, int size) : string(size, cstr)
    {
    }
    CBBString(size_t size) : string()
    {
	    reserve(size);
    }

    CBBString(CBBString& cstr, int stridx, int strlen) 
	    : string (cstr, stridx, strlen)
    {
    }

    CBBString(const CBBString& obj) : string(obj)
    {
    }
    CBBString(const string& obj) : string(obj)
    {
    }

    virtual ~CBBString()
    {
    }

    CBBString& operator=(const CBBString& obj)
    {
	string::operator=(obj);
	return *this;
    }

    virtual const CBBString& operator+=(const CBBString& obj);
    virtual const CBBString& operator+=(const CBBByte& obj)
    {
	    append(1,(char)obj);
	    return *this;
    }

    void toUpper();
    void toLower();

  protected:   

  private:
};
#endif // _CBBSTRING_H
