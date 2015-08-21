/*************************************************************************************
 * PROGRAM      : ntiConversion
 * AUTHOR       : David Balchen
 * DATE-WRITTEN : 06/28/2004
 * DESCRIPTION  : Takes an nti formated file and prints out a CallDump report for
 *                a given search string.
 *************************************************************************************
 * 06/28/2004 Initial revision - DGB
**************************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "nti15.h"

#define DATELEN 10
#define SCRATCHLEN 200
#define WLEN (RECLEN*2 + 1)

static int cellsite = 0;

static char hex_table [17]= "0123456789abcdef";

static char *bitmask[] = {"NNNN","YNNN","NYNN","YYNN","NNYN","YNYN","NYYN","YYYN","NNNY","YNNY","NYNY","YYNY","NNYY","YNYY","NYYY","YYYY"};

static char daytable[2][13] = {
  {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
  {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
};


void write_out_record(char *, char *, char *);

int  hex2int(char *str);

int  bin_to_hex(char * , char *, int);

void month_day(int , int , int *, int *);

int main(int argc, char *argv[])
{

  FILE *IN_FILE;

  char inRec[RECLEN];
  char workRec[WLEN];
  char year[5];
  char ch,*ptr,*bptr;

  workRec[WLEN] = 0; 
  year[0] = 0; 

  if(argc > 3)
    {
      cellsite = 1;
    }

  if((IN_FILE = fopen(argv[1],"rb")) == NULL)
    {
      printf("ERROR ----> Can Not Open Input File (QPFL) \n");
      exit(12);
    }

  strncpy(year,strstr(argv[1],"_T")+2,4);

  while(fread(inRec,RECLEN,1,IN_FILE))
    {

      bin_to_hex (inRec,workRec,2);
      
      workRec[4]= '\0';

      if(!strstr("c0c0",workRec) && !strstr("c3c3",workRec)  && !strstr("c5c5",workRec))
	{

	  bin_to_hex (inRec,workRec,RECLEN);

	  if(strstr(workRec,argv[2]))
	    {
             
	      if((bptr = strstr(workRec,"f7")))
		{
		  while((ptr = strstr((bptr)+ F7LEN,"f7"))) 
		    {
		      ch = *ptr;*ptr = '\0';

		     		      write_out_record(bptr,argv[2],year);
				      //	             printf("%s\n",bptr);
		      *ptr = ch;
		      bptr = ptr;
		    }

		  		  write_out_record(bptr,argv[2],year); 
				  //	           printf("%s\n",bptr);
		}
	    }
	}
    }

  fclose(IN_FILE);
  return(0);
}

void write_out_record(char *rec, char *find,char *yr)
{
  char output[OUTLEN];
  char scratch[SCRATCHLEN];
  char bitarray[BITARRAYLEN];
  char hexnum;
  char *ptr;
  int  a,month,day;
  char tnoutput[TNOUTLEN];
  char clioutput[(CLILEN*2) + 2];
  char date[DATELEN+1];

  tnoutput[0] = 0;
  clioutput[0] = 0;
  scratch[0] = 0;
  output[0] = 0;
  bitarray[0] = 0;
  date[0]=0;

  strncat(scratch,rec+MSIDPOS,MSIDLEN);
  while((ptr = strstr(scratch,"f"))) *ptr = ' ';
  strcat(tnoutput,scratch);
  scratch[0] = 0;

  strcat(tnoutput," ");
  strncat(scratch,rec+CALLTNPOS,TNLEN);
  while((ptr = strstr(scratch,"f"))) *ptr = ' ';
  strcat(tnoutput,scratch);
  scratch[0] = 0;

  strcat(tnoutput," ");
  tnoutput[strlen(tnoutput)] = 0;

  strncat(scratch,rec+DIALTNPOS,DIALTNLEN);
  while((ptr = strstr(scratch,"f")) || (ptr = strstr(scratch,"c")) || (ptr = strstr(scratch,"b")))
    *ptr = ' ';

  strcat(tnoutput,scratch);
  scratch[0] = 0;
  strcat(tnoutput," ");
  tnoutput[strlen(tnoutput)] = 0;

  strncat(scratch,rec+CALDTNPOS,CALDTNLEN);

  while((ptr = strstr(scratch,"f")) || (ptr = strstr(scratch,"c")) || (ptr = strstr(scratch,"b")))
    {  
*ptr = ' ';

  strcat(tnoutput,scratch);
  scratch[0] = 0;
  tnoutput[strlen(tnoutput)] = 0;

  strncat(clioutput,rec+OCLIPOS,CLILEN);
  strncat(clioutput," ",1);
  strncat(clioutput,rec+TCLIPOS,CLILEN);

  if((!cellsite && strstr(tnoutput,find)) || (cellsite && strstr(clioutput,find) ) )

    {

      strncat(scratch,rec+DOYPOS,DOYLEN);
      month_day(atoi(yr),atoi(scratch),&month,&day);
      sprintf(date,"%02i/%02i/%s",month,day,yr);
      strncat(output,date,DATELEN);
      scratch[0] = 0;

      strcat(output," ");
      strncat(output,rec+STIMEHRPOS ,TIMELEN);
      strcat(output,":");
      strncat(output,rec+STIMEMIPOS ,TIMELEN);
      strcat(output,":");
      strncat(output,rec+STIMESCPOS ,TIMELEN);

      strcat(output,"  ");
      strncat(scratch,rec+DURPOS ,DURLEN);
      while((ptr = strstr(scratch,"b"))) *ptr = '0';
      if(strstr(scratch,"000000"))
	strcat(output,"      ");
      else
	strcat(output,scratch);
      scratch[0] = 0;
      strcat(output,"  ");

      strncat(scratch,rec+ESNPOS ,ESNLEN);
      while((ptr = strstr(scratch,"b"))) *ptr = ' ';
      strcat(output,scratch);
      scratch[0] = 0;

      strcat(output,"  ");
      strcat(output,tnoutput);

      strcat(output," ");
      strncat(scratch,rec+CTPOS,CTLEN);

      if(scratch[0] == '0')
	{
	  strcat(output,"M-M ");
	}
      else {
	if(scratch[0] == '1')
	  {
	    strcat(output,"M-L ");
	  }
	else
	  {
	    if(scratch[0] == '2')
	      {
		strcat(output,"M-OP");
	      }
	    else
	      {
		if(scratch[0] == '3')
		  {
		    strcat(output,"L-M ");
		  }
		else {
		  if(scratch[0] == '4')
		    {
		      strcat(output,"L-L ");
		    }
		  else {
		    strcat(output,"??? ");
		  }
		}
	      }
	  }
      }
      scratch[0] = 0;
      strcat(output," ");


      strncat(scratch,rec+ANSPOS,ANSLEN);
 
      if(scratch[0] == '0' || scratch[0] == '1')
	{
	  strcat(output,"Y  ");
	}
      else {
	
	strcat(output,"N  ");
      }  
      scratch[0] = 0;

      strncat(scratch,rec+BITPOS,BITLEN);
      for(a = 0;a < strlen(scratch);a++)
	{
	  hexnum = scratch[a];
	  strcat(bitarray,bitmask[hex2int(&hexnum)]);
	}

      /* o3w */
      scratch[0] = 0;
      strncat(output,&bitarray[O3WPOS],1);

      /* tc */
      strcat(output,"  ");
      strncat(output,&bitarray[TCPOS],1);
      strcat(output,"  ");

      /* tcf */
      if(bitarray[TCF1POS] == 'Y' || bitarray[TCF2POS] == 'Y' ||  bitarray[TCF3POS] == 'Y')
	strcat(output,"Y");
      else strcat(output,"N");
      strcat(output,"  ");

      /* oss */
      strncat(output,&bitarray[OSSPOS],1);

      strcat(output,"    ");
      strcat(output,clioutput);
      printf("%s\n",output);

    }

}
}
/* -------------------------------------------------------------------------*/

/* month_day: set month, day from day of year */
void month_day(int year, int yearday, int *pmonth, int *pday)
{
  int i, leap;

  leap = (((year % 4) == 0) && ((year % 100) != 0)) ||
    ((year % 400) == 0);
  for (i=1; yearday>daytable[leap][i]; i++) {
    yearday -= daytable[leap][i];
  }
  *pmonth=i;
  *pday=yearday;
}

  
/* -------------------------------------------------------------------------*/
int hex2int(char *str)
{
  int digit,c;            
    
  /* calculate each hex character's decimal value */
  c = *str;
  if (c >= '0' && c <= '9')
    digit = c - '0';
  else if (c >= 'a' && c <= 'f') {
    switch (c) {
    case 'a':
      digit = 10;
      break;
    case 'b':
      digit = 11;
      break;
    case 'c':
      digit = 12;
      break;
    case 'd':
      digit = 13;
      break;
    case 'e':
      digit = 14;
      break;
    case 'f':
      digit = 15;
      break;
    default:
      break;
    }
  }
  else
    return -1;  /* invalid input encountered */
  return digit;
}



/* ------------------------------------------------------------------------ */
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

