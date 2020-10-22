/////////////////////////////////////////////////////////////////////////////
//
//   FILE: CBBByteArray.H
//
//   PURPOSE: Declare the class data members and member functions
//
//   CHANGE HISTORY:
//
/////////////////////////////////////////////////////////////////////////////
#ifndef _CBBBYTEARRAY_H
#define _CBBBYTEARRAY_H

#include "CBBDefs.h"
#include "CBBString.h"

class CBBByteArray
{
   public:

     CBBByteArray();
     CBBByteArray(int maxSize);
     CBBByteArray(int maxSize, const CBBByte& byte);
     CBBByteArray(const void *bytes, int length);
     CBBByteArray(const CBBString& obj);
     CBBByteArray(const CBBByteArray& obj);
     virtual ~CBBByteArray();

     CBBByteArray& operator=(const CBBByteArray& obj);
     CBBByteArray& operator=(const CBBString& str);

     bool operator==(const CBBByteArray& obj) const;
     bool operator!=(const CBBByteArray& obj) const;

     virtual CBBByteArray operator+(const CBBByteArray& obj) const;
     virtual const CBBByteArray& operator+=(const CBBByteArray& obj);

     virtual CBBByteArray operator+(const CBBByte& byte) const;
     virtual const CBBByteArray& operator+=(const CBBByte& byte);

     virtual CBBByte& operator[](unsigned int);
     virtual const CBBByte& operator[](unsigned int) const;

     virtual int Insert(const void *bytes, int length, int index = -1);
     virtual int Prepend(const void *bytes, int length);
     virtual int Replace(const void *bytes, int length, int index = 0);

     virtual CBBByteArray Extract(int length, int index = 0);
     virtual int Subtract(int length, int index = 0);
     virtual CBBByteArray SubArray(int length, int index = 0) const;

     int Grow(int size);

     void Clear();
     int GetSize() const { return (_array->_curSize); }
     void SetSize(int size);

     int GetMaxSize() const { return (_array->_maxSize); }
     const CBBByte *GetData() const { return( _array->_bytes); }
 
     virtual CBBString AsHexString();
     virtual CBBString AsDumpHexString(const CBBString& pad = "") const;
     
   protected:   

     virtual CBBByteArray StringToBytes(const CBBString& str);

   private:
   
     int CopyReference(int size = 0);

     struct CBBBytes
     {
        CBBBytes() : _ref(1), _bytes(0), _maxSize(0), _curSize(0)
         { }  

        int _maxSize;
        int _curSize;
        CBBByte * _bytes;
        int _ref;
     };
     
     CBBBytes * _array;
};

#endif // _CBBBYTEARRAY_H
