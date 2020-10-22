//////////////////////////////////////////////////////////////////////////////
//
// File: CBBString.cc
//
// Purpose:
// 	To provide the member implimentations of the CBBString object.
//
//////////////////////////////////////////////////////////////////////////////

// #include "StdAfx.h"

#include <algorithm>
#include <cctype>

#include "CBBString.h"

using std::transform;

/** Default constructor */
CBBString::CBBString()
	: string()
{
}

/** Appending opperator. 
 *
 * This is overloaded due to the problem that was found by Wes and
 * Tony with the '+=' operator in the 'string' object in the Solaris
 * compilor. This may not apply to the g++ compilor.
 */
const CBBString&
CBBString::operator+=(const CBBString& obj)
{
	operator=(*this + obj);
	return(*this);
}

/** Converts all lower case letters to upper case letters.
 */
void
CBBString::toUpper()
{
	transform ((*this).begin(), (*this).end(), (*this).begin(), 
			(int(*)(int))std::toupper);

	return;
}

/** Converts all upper case letters to lower case letters.
 */
void
CBBString::toLower()
{
	transform ((*this).begin(), (*this).end(), (*this).begin(), 
			(int(*)(int))std::tolower);
	return;
}
// EOF
