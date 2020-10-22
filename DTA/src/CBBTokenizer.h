/////////////////////////////////////////////////////////////////////////////
//
//   FILE: CBBTokenizer.H
//
//   PURPOSE: Declare the class data members and member functions
//
//   CHANGE HISTORY:
//
/////////////////////////////////////////////////////////////////////////////
//#ifndef CBBTOKENIZER_H
//#define CBBTOKENIZER_H

#include "CBBString.h"

class CBBTokenizer 
{
   public:
     CBBTokenizer(const CBBString& string);
     CBBTokenizer(const CBBTokenizer& obj);

     virtual ~CBBTokenizer();

     CBBTokenizer& operator=(const CBBTokenizer& obj);

     CBBString operator()(const CBBString& tokens);
     CBBString operator()(); 

     int       IsEnd() { return(_index >= (int)(_string.length())); }

   protected:
   private:

     CBBString _string;
     int _index;
};

//#endif // CBBTOKENIZER_H
