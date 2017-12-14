/*
  ============================================================================
  Name        : AplxExtract.c 
  Author      : David Balchen 
  Version     : 2.0
  Copyright   : U.S. Cellular Description 
  Description : APLX extract program
  ============================================================================
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define RECLEN 512
#define VARLEN 40
#define FILEIN 4096
#define OUTLEN 120
static char hex_table [17]= "0123456789abcdef";

int  bin_to_hex(char * , char *, int);
char *pad = "                         ";
char dialedDigits[VARLEN];
char OrigMsid[VARLEN];
char modID[VARLEN];
char callType[VARLEN];
char ansStat[VARLEN];
char servFeat[VARLEN];
char OrigNum[VARLEN];
char esn[VARLEN];
char startDate[VARLEN];
char startTime[VARLEN];
char duration[VARLEN];
char ocli[VARLEN];
char tcli[VARLEN];
char struct_code[VARLEN];
char output[OUTLEN];

void process42329(char *,char *,int);
void process42330(char *,char *,int);
void process42331(char *,char *,int);
void process42332(char *,char *,int);
void process42333(char *,char *,int);
void process42334(char *,char *,int);
void process42335(char *,char *,int);
void process42336(char *,char *,int);
void process42337(char *,char *,int);
void process42338(char *,char *,int);

void pullInfo (char *, char *);
void clearVars(void);
void processRecord(char *,char *,int);
void printOut(char *,int);

int main(int argc, char *argv[]) {

  FILE *IN_FILE;

  char charIn[FILEIN] = {'\0'} ;
  char hexID[(FILEIN*2) + 1] = {'\0'} ;

  char workrec[(FILEIN*2) + RECLEN] =  {'\0'} ;
  char record[RECLEN] = {'\0'} ;
  char *ptr,*bptr,ch;

  if((IN_FILE = fopen(argv[1],"rb")) == NULL)
    {
      printf("ERROR ----> Can Not Open Input File (INFL) \n");
      exit(12);
    }

  while(fread(charIn,FILEIN,1,IN_FILE))
    {

      bin_to_hex(charIn,hexID,FILEIN);
      hexID[FILEIN*2] = '\0';

      strncat(workrec,hexID,strlen(hexID));
      if((bptr = strstr(workrec,"aa")));
      {

	while((ptr = strstr((bptr) + 2,"aa")))
	  {
	    ch = *ptr;*ptr = '\0';

	    if(argc <= 2 || strstr(bptr,argv[2]))
	      {
		strncat(record,bptr,strlen(bptr));
		processRecord(record,argv[2],argc);
		record[0] = '\0';
	      }

	    *ptr = ch;
	    bptr = ptr;

	  }
	workrec[0] = '\0';

	strncat(workrec,bptr,strlen(bptr));

      }

    }
  processRecord(record,argv[2],argc);

  return(0);
}

void processRecord(char *rec,char *find,int targs)
{
  char structureCode[6];

  if(targs <= 2 || strstr(rec,find))
    {
      strncpy(structureCode,rec+2,5);
      structureCode[5] = '\0';

      if(strstr("42329",structureCode)) process42329(rec,find,targs);
      if(strstr("42330",structureCode))
	{
	  process42330(rec,find,targs);
	}
      if(strstr("42331",structureCode))
	{
	  process42331(rec,find,targs);
	}
      if(strstr("42332",structureCode)) process42332(rec,find,targs);
      if(strstr("42333",structureCode))
	{

	  process42333(rec,find,targs);
	}
      if(strstr("42334",structureCode))
	{

	  process42334(rec,find,targs);
	}
      if(strstr("42335",structureCode)) process42335(rec,find,targs);
      if(strstr("42336",structureCode)) process42336(rec,find,targs);
      if(strstr("42337",structureCode)) process42337(rec,find,targs);
      if(strstr("42338",structureCode)) process42338(rec,find,targs);

    }
}

void process42329(char *rec,char *find, int targs)
{
  char *ptr;
  clearVars();
  strncat(dialedDigits,"000000000000",11);
  ptr = rec;
  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}

      if(strstr(modID,"90002"))
	{
	  dialedDigits[0] = '\0';
	  pullInfo(dialedDigits,ptr + 8);
	}

      modID[0] = '\0';
      ptr++;
    }

  strncat(callType,rec + 8,3);
  strncat(ansStat,rec + 42,1);
  strncat(servFeat,rec + 54,3);
  strncat(OrigNum,rec + 67,10);
  strncat(esn,rec + 184,11);
  strncat(startDate,rec + 203,8);
  strncat(startTime,rec + 212,7);
  strncat(duration,rec + 220,9);
  strncat(ocli,rec + 232,4);
  strncat(tcli,rec + 155,4);
  strncat(struct_code,"42329",5);
  printOut(find,targs);
}

void process42330(char *rec,char *find, int targs)
{
  char *ptr;
  clearVars();
  strncat(dialedDigits,"000000000000",11);
  ptr = rec;
  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}

      if(strstr(modID,"90002"))
	{
	  dialedDigits[0] = '\0';
	  pullInfo(dialedDigits,ptr + 8);
	}

      modID[0] = '\0';
      ptr++;
    }

  strncat(callType,rec + 8,3);
  strncat(ansStat,rec + 42,1);
  strncat(servFeat,rec + 54,3);
  strncat(OrigNum,rec + 67,10);
  strncat(esn,rec + 222,11);
  strncat(startDate,rec + 241,8);
  strncat(startTime,rec + 250,7);
  strncat(duration,rec + 258,9);
  strncat(ocli,rec + 270,4);
  strncat(tcli,rec + 155,4);
  strncat(struct_code,"42330",5);

  printOut(find, targs);
}

void process42331(char *rec,char *find, int targs)
{
  char *ptr;

  clearVars();
  strncat(dialedDigits,"000000000000",11);
  ptr = rec;
  while ( (ptr=strstr(ptr,"c331c")) != NULL )
    {
      dialedDigits[0] = '\0';
      strncat(dialedDigits,ptr+14,10);
      modID[0] = '\0';
      ptr++;
    }

  ptr = rec;
  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}

      modID[0] = '\0';
      ptr++;
    }

  strncat(OrigNum,rec+63,10);
  strncat(callType,rec + 8,3);
  strncat(ansStat,rec + 42,1);
  strncat(servFeat,rec + 50,3);
  strncat(esn,rec + 132,11);
  strncat(startDate,rec + 151,8);
  strncat(startTime,rec + 160,7);
  strncat(duration,rec + 168,9);
  strncat(ocli,rec + 103,4);
  strncat(tcli,rec + 208,4);
  strncat(struct_code,"42331",5);

  printOut(find, targs);
}

void process42332(char *rec,char *find, int targs)
{
  char *ptr;
  clearVars();
  strncat(dialedDigits,"000000000000",11);
  ptr = rec;
  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}

      if(strstr(modID,"90002"))
	{
	  dialedDigits[0] = '\0';
	  pullInfo(dialedDigits,ptr + 8);
	}

      modID[0] = '\0';
      ptr++;
    }

  strncat(callType,rec + 8,3);
  strncat(ansStat,rec + 42,1);
  strncat(servFeat,rec + 54,3);
  strncat(OrigNum,rec + 67,10);
  strncat(esn,rec + 222,11);
  strncat(startDate,rec + 240,8);
  strncat(startTime,rec + 250,7);
  strncat(duration,rec + 258,9);
  strncat(ocli,rec + 270,4);
  strncat(tcli,rec + 280,4);
  strncat(struct_code,"42330",5);

  printOut(find, targs);
}

void process42333(char *rec,char *find, int targs)
{
  char *ptr;
  clearVars();

  strncat(dialedDigits,"000000000000",11);
  ptr = rec;
  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}

      if(strstr(modID,"90002"))
	{
	  dialedDigits[0] = '\0';
	  pullInfo(dialedDigits,ptr + 8);
	}

      modID[0] = '\0';
      ptr++;
    }

  strncat(callType,rec + 8,3);
  strncat(ansStat,rec + 42,1);
  strncat(servFeat,rec + 54,3);
  strncat(OrigNum,rec + 67,10);
  strncat(esn,rec + 184,11);
  strncat(startDate,rec + 241,8);
  strncat(startTime,rec + 250,7);
  strncat(duration,rec + 258,9);
  strncat(ocli,rec + 270,4);
  strncat(tcli,rec + 155,4);
  strncat(struct_code,"42333",5);

  printOut(find,targs);
}

void process42334(char *rec,char *find, int targs)
{

  char *ptr;

  clearVars();

  strncat(dialedDigits,"000000000000",11);
  ptr = rec;
  while ( (ptr=strstr(ptr,"c331c")) != NULL )
    {
      dialedDigits[0] = '\0';
      strncat(dialedDigits,ptr+14,10);
      modID[0] = '\0';
      ptr++;
    }

  ptr = rec;
  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}

      modID[0] = '\0';
      ptr++;
    }

  strncat(OrigNum,rec+63,10);
  strncat(callType,rec + 8,3);
  strncat(ansStat,rec + 42,1);
  strncat(servFeat,rec + 50,3);
  strncat(esn,rec + 132,11);
  strncat(startDate,rec + 151,8);
  strncat(startTime,rec + 160,7);
  strncat(duration,rec + 168,8);
  strncat(ocli,rec + 103,4);
  strncat(tcli,rec + 246,4);
  strncat(struct_code,"42334",5);

  printOut(find, targs);
}

void process42335(char *rec,char *find, int targs)
{
  char *ptr;
  clearVars();

  ptr = rec;

  strncat(dialedDigits,"000000000000",11);

  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}

      modID[0] = '\0';
      ptr++;
    }

  ptr = rec;
  ptr=strstr(ptr,"c331c");

  dialedDigits[0] = '\0';
  pullInfo(dialedDigits,ptr + 11);

  strncat(callType,rec + 8,3);
  strncat(ansStat,rec + 42,1);
  strncat(servFeat,rec + 50,3);
  strncat(OrigNum,rec + 63,10);
  strncat(esn,rec + 132,11);
  strncat(startDate,rec + 179,8);
  strncat(startTime,rec + 188,7);
  strncat(duration,rec + 196,9);
  strncat(ocli,rec + 103,4);
  strncat(tcli,rec + 103,4);
  strncat(struct_code,"42335",5);
  printOut(find,targs);
}

void process42336(char *rec,char *find, int targs)
{
  char *ptr;
  clearVars();

  ptr = rec;

  strncat(dialedDigits,"000000000000",11);

  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}

      if(strstr(modID,"90002"))
	{
	  dialedDigits[0] = '\0';
	  pullInfo(dialedDigits,ptr + 8);
	}

      modID[0] = '\0';
      ptr++;
    }

  strncat(callType,rec + 8,3);
  strncat(ansStat,rec + 42,1);
  strncat(servFeat,"???",3);
  strncat(OrigNum,rec + 53,10);
  strncat(esn,rec + 76,11);
  strncat(startDate,rec + 95,8);
  strncat(startTime,rec + 104,7);
  strncat(duration,rec + 112,9);
  strncat(ocli,"????",4);
  strncat(tcli,rec + 162,4);
  strncat(struct_code,"42336",5);
  printOut(find,targs);
}

void process42337(char *rec,char *find, int targs)
{
  char *ptr;
  clearVars();

  ptr = rec;

  strncat(dialedDigits,"000000000000",11);

  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}

      if(strstr(modID,"90002"))
	{
	  dialedDigits[0] = '\0';
	  pullInfo(dialedDigits,ptr + 8);
	}

      modID[0] = '\0';
      ptr++;
    }

  strncat(callType,rec + 8,3);
  strncat(ansStat,"?",1);
  strncat(servFeat,rec + 38,3);
  strncat(OrigNum,rec + 51,10);
  strncat(esn,rec + 62,11);
  strncat(startDate,rec + 81,8);
  strncat(startTime,rec + 90,7);
  strncat(duration,rec + 98,9);
  strncat(ocli,rec + 138,4);
  strncat(tcli,"????",4);
  strncat(struct_code,"42337",5);
  printOut(find,targs);
}

void process42338(char *rec,char *find, int targs)
{
  char *ptr;
  clearVars();

  ptr = rec;

  strncat(dialedDigits,"000000000000",11);

  while ( (ptr=strstr(ptr,"621")) != NULL )
    {
      strncat(modID,ptr+8,5);

      if(strstr(modID,"10830"))
	{
	  pullInfo(OrigMsid,ptr + 8);
	}
      modID[0] = '\0';
      ptr++;
    }

  strncat(callType,rec + 8,3);
  strncat(ansStat,"?",1);
  strncat(servFeat,"???",3);
  strncat(OrigNum,rec + 45,10);
  strncat(esn,rec + 56,11);
  strncat(startDate,rec + 75,8);
  strncat(startTime,rec + 84,7);
  strncat(duration,rec + 92,9);
  strncat(ocli,rec + 104,4);
  strncat(tcli,"????",4);
  strncat(struct_code,"42338",5);
  printOut(find,targs);
}

void printOut(char *find, int targs)
{
  char *ptr;
  char tmp[30];
  int durtmp;

  output[0] = '\0';

  if ((targs <= 2) ||
      ((targs >= 4) && (strstr(ocli, find) || strstr(tcli,find))) ||
      ((targs == 3) && (strstr(dialedDigits, find) || strstr(OrigNum, find) || strstr(OrigMsid, find))))

    {
      strncat(output,(strncat(struct_code,pad,8)),8);
      strncat(output,(strncat(callType,pad,7)),7);

      if(ansStat[0] == '0')
	{
	  ansStat[0] = 'Y';
	}
      else if(ansStat[0] == '1'){
	ansStat[0] = 'N';
      }

      strncat(output,(strncat(ansStat,pad,3)),3);

      strncat(output,(strncat(servFeat,pad,4)),4);

      strncat(output,(strncat(OrigNum,pad,11)),11);

      strncat(output,(strncat(esn,pad,12)),12);

      strncat(output,(strncat(OrigMsid+1,pad,11)),11);

      tmp[0] = '\0';
      ptr = startDate; strncat(tmp,ptr+4,2); strncat(tmp,"/",1);
      strncat(tmp,ptr+6,2);strncat(tmp,"/",1);
      strncat(tmp,ptr,4);
      strncat(output,(strncat(tmp,pad,12)),12);

      tmp[0] = '\0';
      ptr = startTime; strncat(tmp,ptr,2);strncat(tmp,":",1);
      strncat(tmp,ptr+2,2);strncat(tmp,":",1);
      strncat(tmp,ptr+4,2);
      strncat(output,(strncat(tmp,pad,9)),9);

      tmp[0] = '\0';
      strncat(tmp,duration+1,5); durtmp = atoi(tmp)*60;
      tmp[0] = '\0';
      strncat(tmp,duration+6,2); durtmp = durtmp + atoi(tmp);

      tmp[0] = '\0';
      sprintf(tmp,"%i",durtmp);
      duration[0] = '\0'; strncat(duration,"0000",4);

      strncat(duration,tmp,strlen(tmp));
      tmp[0] = '\0';
      durtmp = strlen(duration)- 5;
      strncat(tmp,duration + durtmp,5);
      strncat(output,(strncat(tmp,pad,6)),6);

      if(dialedDigits[0] == '0')
	{
	  strncat(output,(strncat(dialedDigits+1,pad,16)),16);
	}
      else
	{
	  strncat(output,(strncat(dialedDigits,pad,16)),16);
	}

      strncat(output,(strncat(ocli,pad,6)),6);

      strncat(output,(strncat(tcli,pad,6)),6);

      printf("%s\n",output);
    }
  return;
}

void pullInfo (char *info, char *ptr )
{
  char *top;
  char *bottom;
  int count;

  top = strstr(ptr,"c") + 1;
  bottom = strstr(top + 1,"c");
  count = (int ) (bottom - top);
  strncpy(info,top,count);
  info[count] = '\0';

  return;
}

void clearVars()
{
  dialedDigits[0] = '\0';
  OrigMsid[0]= '\0';
  modID[0] = '\0';
  callType[0] = '\0';
  ansStat[0] = '\0';
  servFeat[0] = '\0';
  OrigNum[0] = '\0';
  startDate[0]  = '\0';
  startTime[0] = '\0';
  duration[0] = '\0';
  ocli[0] = '\0';
  tcli[0] = '\0';
  esn[0] = '\0';
  struct_code[0] = '\0';
}

int bin_to_hex (char *bin, char *hex, int lng)
{
  int ch;
  int ch2;

  if (lng <= 0) return -1;

  while (lng-- > 0)
    {
      ch= *bin++ & 0x00FF;
      ch2= (ch >> 4) & 0x000F;
      ch &= 0x000F;

      *hex++= hex_table [ch2];
      *hex++= hex_table [ch];
    }
  *hex= 0;

  return 0;
}
