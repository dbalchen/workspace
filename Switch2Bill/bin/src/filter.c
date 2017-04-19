/*
 ============================================================================
 Name        : filter.c
 Author      : David Balchen
 Version     :
 Copyright   : 
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

#define FILEIN 5128
#define WRKLEN 6144

void processUFF(char *);
void processCIBER(char *);
int checkTrailer(char *, char *, int);
int isValid(char *);
char * getUFFcol(char *, int);
char * pad(char *, int);

static char *lookup;

int main(int argc, char *argv[]) {

	FILE *IN_FILE;
	FILE *LOOKUP;

	char inRec[FILEIN];
	char workRec[WRKLEN];
	struct stat st;

	workRec[0] = 0;

	if (argc < 2) {
		printf("Not enough parameters\n");
		exit(0);
	}

	stat(argv[1], &st);

	lookup = malloc((st.st_size + 128) * sizeof(char));

	if ((LOOKUP = fopen(argv[1], "rb")) == NULL) {
		printf("ERROR ----> Can Not Open Lookup Input File \n");
		exit(12);
	}

	fread(lookup, st.st_size, 1, LOOKUP);

	if ((IN_FILE = fopen(argv[2], "rb")) == NULL) {
		printf("ERROR ----> Can Not Open Input Filter File \n");
		exit(12);
	}

	while (fread(inRec, FILEIN, 1, IN_FILE)) {
		strncat(workRec, inRec, FILEIN);

		if(strstr(argv[2],"UFF"))processUFF(workRec);
		else processCIBER(workRec);

		memset(inRec, 0, FILEIN);
	}

	strncat(workRec, inRec, strlen(inRec));

	if(strstr(argv[2],"UFF"))processUFF(workRec);
	else processCIBER(workRec);;

	fclose(IN_FILE);
	return EXIT_SUCCESS;
}

void processCIBER(char *workrec) {
	char ch, *ptr, *bptr;
	char *oMSID,*tMSID;
	char check[3];

	bptr = workrec;

	while ((ptr = strstr((bptr), "\n")))
	{
		ch = *ptr;
		*ptr = '\0';

		check[0] = 0;

		strncpy(check, workrec, 2);

		if(strstr(check,"01"))
		{
			printf("%s\n", bptr);
		}
		if(strstr(check,"22"))
		{
			printf("%s\n", bptr);
		}
		if(strstr(check,"98"))
		{
			printf("%s\n", bptr);
		}
		if(strstr(check,"32"))
		{
			printf("%s\n", bptr);
		}
		if(strstr(check,"52"))
		{
			printf("%s\n", bptr);
		}
		*ptr = ch;
		bptr = ptr + 1;

		workrec[0] = 0;
		strncat(workrec, bptr, strlen(bptr));

		bptr = workrec;
	}

}

void processUFF(char *workrec) {
	char ch, *ptr, *bptr;
	char *oMSID, *oMDN, *tMSID, *tMDN, *dd;


	if (checkTrailer(workrec, "TR", 0))
		return;

	if ((bptr = strstr(workrec, "HR")) || (bptr = strstr(workrec, "DR"))
			|| (bptr = strstr(workrec, "TR"))) {

		while ((ptr = strstr((bptr), "\n"))) {
			ch = *ptr;
			*ptr = '\0';

			//			if(strstr(bptr,"DR|APLX|1756|20170403172305662421|0|0|morg|20170403|17051700|18000|26132|26132|0061|1615"))
			//			{
			//			printf("The last record is %s\n",bptr);
			//			}
			if (checkTrailer(bptr, "TR", 1))
				exit(0);

			if (strstr(bptr, "DR|")) {

				oMSID = getUFFcol(bptr, 19);
				oMDN = getUFFcol(bptr, 21);
				dd = getUFFcol(bptr, 25);
				tMDN = getUFFcol(bptr, 24);
				tMSID = getUFFcol(bptr, 23);

				if (isValid(oMSID) && isValid(tMSID) && isValid(oMDN)
						&& isValid(tMDN) && isValid(dd))
					printf("%s\n", bptr);

				free(oMSID);
				free(dd);
				free(tMDN);
				free(oMDN);
				free(tMSID);


			} else {
				printf("%s\n", bptr);
			}

			*ptr = ch;
			bptr = ptr + 1;

			workrec[0] = 0;
			strncat(workrec, bptr, strlen(bptr));
			bptr = workrec;
		}


	}

	if (checkTrailer(workrec, "TR", 0))
		return;
}

int checkTrailer(char *record, char *look, int pass) {
	char check[3];
	char *find;

	check[0] = 0;

	strncpy(check, record, 2);

	if (strstr(check, look)) {

		if ((find = strstr((record), "\n"))) {
			*find = '\0';
			pass = 1;
		}

		if (pass) {
			printf("%s\n", record);
			return 1;
		}

	}
	return 0;
}

int isValid(char *number) {

	int length;
	char *bptr, *ptr, ch, *suffix;

	char wholeNumber[11], prefix[7], holder[11], check[2];

	long long int before = 0, compare = 0, after = 0;

	if((length=strlen(number)) >= 10)
	{
		wholeNumber[0] = 0;

		bptr = number + (length-10);

		strncat(wholeNumber,bptr, strlen(number));

		ptr = bptr + 6;
		ch = *ptr;
		*ptr = '\0';

		prefix[0] = 0;
		strncat(prefix,bptr,strlen(bptr));

		*ptr = ch;

		if(((bptr = strstr(lookup,prefix)) != 0))
		{
			compare = atoll(wholeNumber);

			check[0] = 0;
			strncpy(check, bptr-1,2);

			if (((bptr == lookup) || (strstr(check,"\n"))))
			{
				holder[0] = 0;
				strncat(holder,prefix, strlen(prefix));

				bptr = (strstr(bptr,"\t") + 1);
				ptr = (strstr(bptr,"\t"));
				ch = *ptr;
				*ptr = '\0';
				suffix = pad(bptr,4);

				strncat(holder,suffix,strlen(suffix));

				before = atoll(holder);
				free(suffix);
				*ptr = ch;

				holder[0] = 0;
				strncat(holder,prefix, strlen(prefix));

				bptr = ptr + 1;
				ptr = (strstr(bptr,"\n"));
				ch = *ptr;
				*ptr = '\0';
				suffix = pad(bptr,4);
				strncat(holder,suffix,strlen(suffix));
				after = atoll(holder);
				free(suffix);
				*ptr = ch;

				if((compare >= before) && (compare <= after)) return 0;
			}

		}
	}
	return 1;
}

char * getUFFcol(char *record, int colnum) {
	unsigned int a;
	char *bptr, *ptr, ch, *rptr;

	bptr = record;

	for (a = 0; a < colnum; a++) {
		bptr = strstr(bptr, "|") + 1;
	}

	ptr = strstr(bptr, "|");
	ch = *ptr;
	*ptr = '\0';

	rptr = malloc((strlen(bptr)+1) * sizeof(char));

	strcpy(rptr, bptr);
	*ptr = ch;

	bptr = record;
	return rptr;
}

char * getCiberCol (char *record, int start, int end)
{
	char *bptr, *ptr, ch, *rptr;

	bptr = record + start;
	ptr = record + end + 1;
	ch = *ptr;
	*ptr = '\0';

	rptr = malloc((strlen(bptr)+1) * sizeof(char));

	strcpy(rptr, bptr);
	*ptr = ch;

	bptr = record;

	return rptr;
}

char * pad(char *what, int size)
{
	char *rptr;

	rptr = malloc(size * sizeof(char));
	rptr[0] = 0;

	while(strlen(rptr) < (size - strlen(what)))
	{
		strncat(rptr,"0",1);
	}


	strncat(rptr,what,strlen(what));

	return rptr;
}
