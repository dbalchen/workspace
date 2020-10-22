/////////////////////////////////////////////////////////////////////////////
//
//   FILE: CBBByteArray.C
//
//   PURPOSE:  Defines the class functionality
//
//   CHANGE HISTORY:
//
/////////////////////////////////////////////////////////////////////////////

// #include "StdAfx.h"
#include "CBBByteArray.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <strstream>
#include <string.h>

/////////
//
// Member Function: CBBByteArray
//
// Purpose: Class constructor 
//
// Parameters:  None
//
// Returns: None
//
// Comments:
//
/////////
CBBByteArray::CBBByteArray() 
{
   _array = new CBBBytes();
   _array->_maxSize = 64;
   _array->_bytes = new CBBByte[_array->_maxSize];
   _array->_curSize = 0;
}

/////////
//
// Member Function: CBBByteArray
//
// Purpose: Class constructor 
//
// Parameters:  None
//
// Returns: None
//
// Comments:
//
/////////
CBBByteArray::CBBByteArray(int size) 
{
   _array = new CBBBytes();
   _array->_maxSize = size;
   _array->_bytes = new CBBByte[size];
   _array->_curSize = 0;
}

/////////
//
// Member Function: CBBByteArray
//
// Purpose: Class constructor
//
// Parameters:  None
//
// Returns: None
//
// Comments:
//
/////////
CBBByteArray::CBBByteArray(int size, const CBBByte& byte)
{
   _array = new CBBBytes();
   _array->_maxSize = size;
   _array->_bytes = new CBBByte[_array->_maxSize];
   _array->_curSize = size;
   memset(_array->_bytes, byte, size);
}

/////////
//
// Member Function: CBBByteArray
//
// Purpose: Class constructor 
//
// Parameters:  None
//
// Returns: None
//
// Comments:
//
/////////
CBBByteArray::CBBByteArray(const void * bytes, int size) 
{
   _array = new CBBBytes();
   _array->_maxSize = size;
   _array->_bytes = new CBBByte[size];
   _array->_curSize = size;
   memcpy((void *) _array->_bytes, bytes, size); 
}

/////////
//
// Member Function: CBBByteArray(const CBBString& str)
//
// Purpose: Class constructor
//
// Parameters:  const string& obj - the string to use for assignment
//
// Returns: None
//
// Comments:
//
/////////
CBBByteArray::CBBByteArray(const CBBString& str) 
{
   CBBByteArray data = StringToBytes(str);
  
   data._array->_ref++;
   _array = data._array;
}

/////////
//
// Member Function: CBBByteArray(const CBBByteArray& obj)
//
// Purpose: Class constructor
//
// Parameters:  const CBBByteArray& obj - the object used to copy
//
// Returns: None
//
// Comments:
//
/////////
CBBByteArray::CBBByteArray(const CBBByteArray& obj) 
{
   obj._array->_ref++;
   _array = obj._array;
}

/////////
//
// Member Function: ~CBBByteArray
//
// Purpose: destructor for the class
//
// Parameters: None
//
// Returns: None
//
// Comments:
//
/////////
CBBByteArray::~CBBByteArray()
{
   if((_array != (CBBBytes *)0) && (--_array->_ref == 0))
   {
      	if (_array->_bytes != (CBBByte *)0)
	{
      		delete [] _array->_bytes;
	}
      	_array->_bytes = (CBBByte *)0;
      	delete _array;
	_array = (CBBBytes *)0;
   }
}

/////////
//
// Member Function: operator=(const CBBByteArray& obj)
//
// Purpose: Class assignment operator
//
// Parameters:  const CBBByteArray& obj - the object used to copy
//
// Returns: None
//
// Comments:
//
/////////
CBBByteArray& CBBByteArray::operator=(const CBBByteArray& obj)
{
   if(this != &obj)
   {
      	obj._array->_ref++;
      	
	if ((_array != (CBBBytes *)0) && (--_array->_ref == 0))
      	{
	 	if (_array->_bytes != (CBBByte *)0)
         	delete [] _array->_bytes;
	 	_array->_bytes = (CBBByte *)0;
         	delete _array;
		_array = (CBBBytes *)0;
      }
      
      _array = obj._array;
   }

   return *this;
}

/////////
//
// Member Function: operator=(const string& str)
//
// Purpose: Class assignment operator
//
// Parameters:  const string& str - the string to use for the assignment
//
// Returns: None
//
// Comments:
//
/////////
CBBByteArray& CBBByteArray::operator=(const CBBString& str)
{
   CBBByteArray data = StringToBytes(str);

   return(*this = data);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
bool CBBByteArray::operator==(const CBBByteArray& obj) const
{
   if (_array == obj._array)
   {
      return true;
   }
    
   if (GetSize() != obj.GetSize())
   {
      return false;
   }

   if (memcmp(_array->_bytes, obj._array->_bytes, GetSize()) == 0)
   {
      return true;
   }

   return false;
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
bool CBBByteArray::operator!=(const CBBByteArray& obj) const
{
   return((*this == obj) ? false : true);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
CBBByte& CBBByteArray::operator[](unsigned int index)
{
	if (index >= (unsigned int)(_array->_curSize))
	{
		return(_array->_bytes[0]);
	}

	if (_array->_ref > 1)
	{
		// CopyReference will copy the reference
		CopyReference();      
	}

	return(_array->_bytes[index]);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
const CBBByte & CBBByteArray::operator[](unsigned int index) const
{
	if (index < (unsigned int)(_array->_curSize))
	{
		return(_array->_bytes[index]);
	}
	else
	{
		return(_array->_bytes[0]);
	}
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
CBBByteArray CBBByteArray::operator+(const CBBByteArray& rhs) const
{
   CBBByteArray tmp(GetSize() + rhs.GetSize());

   tmp.Insert(this->_array->_bytes, GetSize());
   tmp.Insert(rhs._array->_bytes, rhs.GetSize());

   return(tmp);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
CBBByteArray CBBByteArray::operator+(const CBBByte& rhs) const
{
   CBBByteArray tmp(GetSize() + sizeof(rhs));

   tmp.Insert(this->_array->_bytes, GetSize());
   tmp.Insert(&rhs, sizeof(rhs));

   return(tmp);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
const CBBByteArray& CBBByteArray::operator+=(const CBBByteArray& rhs) 
{
   Insert(rhs._array->_bytes, rhs.GetSize());

   return(*this);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
const CBBByteArray& CBBByteArray::operator+=(const CBBByte& rhs) 
{
   Insert(&rhs, sizeof(rhs));

   return(*this);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
int CBBByteArray::Insert(const void * bytes, int bytesSize, int index)
{
   if ((index < -1) || (index > _array->_curSize))
   {
      return(-1);
   }

   int size = ((index == -1) ? _array->_curSize : index);

   int growBy = (bytesSize + size) - _array->_curSize;
   if (growBy < 0)
   {
      growBy = 0;
   }

   Grow(growBy);
   memcpy((void *) (_array->_bytes + size), bytes, bytesSize);

   _array->_curSize = bytesSize + size;

   return(size);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
int CBBByteArray::Replace(const void * bytes, int length, int index)
{
   if ((index < 0) || (index >= _array->_curSize))
   {
      return(-1);
   }

   Grow(length + index);
   memcpy((void *) (_array->_bytes + index), bytes, length);

   _array->_curSize = length + index;
   return(_array->_curSize);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
int CBBByteArray::Prepend(const void * bytes, int bytesSize)
{
   Grow(bytesSize);
   memmove((void *) (_array->_bytes + bytesSize), 
           _array->_bytes, _array->_curSize);

   memcpy((void *) _array->_bytes, bytes, bytesSize);

   _array->_curSize += bytesSize;

   return(0);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
CBBByteArray CBBByteArray::Extract(int length, int index)
{
   if ((length < 0) || (index < 0) || (index >= _array->_curSize))
   {
      return(CBBByteArray());
   }

   // Copy the Reference 
   if (_array->_ref > 1)
   {
      CopyReference();      
   }

   int tmpLength = length;
   if ((index + length) > _array->_curSize)
   {
      tmpLength = _array->_curSize - index; 
   }

   CBBByteArray ret(&_array->_bytes[index], tmpLength);

   _array->_curSize -= tmpLength;

   if ((_array->_curSize - index) > 0)
   {
      memmove(&_array->_bytes[index], (&_array->_bytes[index]) + tmpLength, 
              _array->_curSize - index);
   }

   return(ret);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
int CBBByteArray::Subtract(int length, int index)
{
   if ((length < 0) || (index < 0) || (index >= _array->_curSize))
   {
      return(-1);
   }

   // Copy the Reference 
   if (_array->_ref > 1)
   {
      CopyReference();      
   }

   int tmpLength = length;
   if ((index + length) > _array->_curSize)
   {
      tmpLength = _array->_curSize - index; 
   }

   _array->_curSize -= tmpLength;

   if ((_array->_curSize - index) > 0)
   {
      memmove(&_array->_bytes[index], (&_array->_bytes[index]) + tmpLength, 
              _array->_curSize - index);
   }

   return(_array->_curSize);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
CBBByteArray CBBByteArray::SubArray(int length, int index) const
{
   if ((length < 0) || (index < 0) || (index >= _array->_curSize))
   {
      return(CBBByteArray());
   }

   if ((index + length) > _array->_curSize)
   {
      return(CBBByteArray());
   }

   int tmpLength = length;
   if ((index + length) > _array->_curSize)
   {
      tmpLength = _array->_curSize - index; 
   }

   CBBByteArray ret(&_array->_bytes[index], tmpLength);

   return(ret);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
void CBBByteArray::SetSize(int size)
{
  if ((size > -1) && (size <= _array->_maxSize))
  {
     if (_array->_ref != 1)
     {
        CopyReference();
     }

     _array->_curSize = size;
  }

}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
void CBBByteArray::Clear()
{
   if (_array->_ref != 1)
   {
      CopyReference();
   }

   _array->_curSize = 0;
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
int CBBByteArray::Grow(int bytesSize)
{
   if ((_array->_ref == 1) && 
       ((_array->_curSize + bytesSize) < _array->_maxSize))
   {
      return(_array->_maxSize);
   }

   return(CopyReference(bytesSize));
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
CBBString CBBByteArray::AsHexString()
{
   char * s = new char[(_array->_curSize * 2) + 42];
   s[0] = '\0';

   for (int i = 0; i < _array->_curSize; i++)
   {
      sprintf(s + (i * 2), "%0.2X", _array->_bytes[i]);
   }

   CBBString ret(s);
   delete [] s;

   return(ret);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
CBBString CBBByteArray::AsDumpHexString(const CBBString& pad) const
{
   CBBString ret((size_t)_array->_curSize * 5);
   CBBString hex((size_t)80);
   CBBString ascii((size_t)80);
//   string ret(RWSize_T(_array->_curSize * 5));
//   string hex(RWSize_T(80));
//   string ascii(RWSize_T(80));
   char line[80];

   for (int i = 0; i < _array->_curSize; i++)
   {
      if ((i / 16) && !(i % 16))
      {
         sprintf(line, "%-48.48s  %-16.16s\n", hex.data(), ascii.data());
         ret += (pad + line);
         hex = "";
         ascii = "";
      }

      char tmp[8];
 
      sprintf(tmp, "%0.2X ", _array->_bytes[i]);
      hex += tmp;
      ascii += (char ) ((isprint(_array->_bytes[i])) ? _array->_bytes[i] : '.');
   }

   sprintf(line, "%-48.48s  %-16.16s\n", hex.data(), ascii.data());
   ret += (pad + line);

   return(ret);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
int CBBByteArray::CopyReference(int size)
{
   CBBBytes * tmp = new CBBBytes();
   tmp->_curSize = _array->_curSize;
   tmp->_maxSize = (((tmp->_curSize + size) > _array->_maxSize) ? 
                      _array->_maxSize + size + 64 : _array->_maxSize);
      
   tmp->_bytes = new CBBByte[tmp->_maxSize]; 
   memcpy(tmp->_bytes, _array->_bytes, _array->_curSize);

   if ((_array != (CBBBytes *)0) && (--_array->_ref == 0))
   {
      if (_array->_bytes)
      	delete [] _array->_bytes;
      _array->_bytes = (CBBByte *)0;
      delete _array;
      _array = (CBBBytes *)0;
   }
   _array = tmp;
   return(_array->_maxSize);
}

/////////
//
// Member Function: 
//
// Purpose: 
//
// Parameters:  
//
// Returns: 
//
// Comments:
//
/////////
CBBByteArray CBBByteArray::StringToBytes(const CBBString& str)
{
   CBBString tmpStr = str;
   CBBByteArray array;

   tmpStr.toUpper();

   if (!(tmpStr.length() % 2))
   {
      for (int i = 0; i < (int)(tmpStr.length()); i+=2)
      {
         CBBByte tmp;

         if ((!isxdigit(tmpStr[i])) || (!isxdigit(tmpStr[i + 1])))
         {
            array.Clear();
            return(array);
         }
	 
         tmp = ((tmpStr[i] >= 'A') ? (tmpStr[i] - '7') : (tmpStr[i] - '0'));
         tmp = tmp << 4;

         tmp |= ((tmpStr[i + 1] >= 'A') ? 
                             (tmpStr[i + 1] - '7') : (tmpStr[i + 1] - '0'));

         array.Insert(&tmp, sizeof(tmp));
      }
   }

   return(array);
}
