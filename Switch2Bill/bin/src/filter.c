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

#define FILEIN 5120
#define WRKLEN 6144

void processUFF(char *, char *);
void processCIBER(char *, char *);
int isValid(char *, int);
char * getUFFcol(char *, int);
char * getCiberCol(char *, int,int);
char * pad(char *, int);
char * putUFFcol(char *, int, long long int);
char * putCiberCol(char *,long long int, long long int);

static char *lookup, *lookupMIN;

int main(int argc, char *argv[]) {

	FILE *IN_FILE;
	FILE *LOOKUP;
	FILE *LOOKUPMIN;

	char inRec[FILEIN];
	char workRec[WRKLEN];
	struct stat st;

	workRec[0] = 0;

	if (argc < 2) {
		printf("Not enough parameters\n");
		exit(0);
	}

	stat(argv[1], &st);

	if ((LOOKUP = fopen(argv[1], "rb")) == NULL) {
		printf("ERROR ----> Can Not Open Lookup Input MDN File \n");
		exit(12);
	}

	lookup = malloc((st.st_size + 128) * sizeof(char));

	fread(lookup, st.st_size, 1, LOOKUP);

	stat(argv[2], &st);

	if ((LOOKUPMIN = fopen(argv[2], "rb")) == NULL) {
		printf("ERROR ----> Can Not Open Lookup Input MSID File \n");
		exit(12);
	}

	lookupMIN = malloc((st.st_size + 128) * sizeof(char));

	fread(lookupMIN, st.st_size, 1, LOOKUPMIN);

	if ((IN_FILE = fopen(argv[3], "rb")) == NULL) {
		printf("ERROR ----> Can Not Open Input Filter File \n");
		exit(12);
	}

	memset(inRec, 0, FILEIN);

	while (fread(inRec, FILEIN, 1, IN_FILE)) {
		strncat(workRec, inRec, FILEIN);

		if (strstr(argv[3], "UFF"))
			processUFF(workRec,argv[3]);
		else
			processCIBER(workRec,argv[3]);

		memset(inRec, 0, FILEIN);
	}

	strncat(workRec, inRec, strlen(inRec));

	if (strstr(argv[3], "UFF"))
		processUFF(workRec,argv[3]);
	else
		processCIBER(workRec,argv[3]);

	fclose(IN_FILE);
	return EXIT_SUCCESS;
}

void processCIBER(char *workrec, char * filename) {
	char ch, *ptr, *bptr, *rptr;
	char *orig;
	long long int total, charge;
	int which;
	char check[3];

	bptr = workrec;

	while ((ptr = strstr((bptr), "\n"))) {
		ch = *ptr;
		*ptr = '\0';

		check[0] = 0;

		strncpy(check, workrec, 2);

		if(!strstr(check,"01") && !strstr(check,"98"))
		{
			if(strstr(filename,"SDATACBR_FDATACBR"))
			{
				orig = getCiberCol(bptr, 14,28);
				which = 1;
			}
			else {
				orig = getCiberCol(bptr, 31,45);
				which = 0;
			}
		}

		if (strstr(check, "01")) {
			printf("%s\n", bptr);
			total = 1;
			charge = 0;
		}

		if (strstr(check, "22")) {

			if (isValid(orig, which)) {
				printf("%s\n", bptr);
				total = 1 + total;
				rptr = getCiberCol(bptr,71,80);
				charge = charge + atoll(rptr);
				free(rptr);
			}
			else {
				fprintf(stderr,"%s\n", bptr);
			}

			free(orig);
		}

		if (strstr(check, "98")) {

			total = total + 1;
			bptr = putCiberCol(bptr,total,charge);
			printf("%s\n", bptr);

		}

		if (strstr(check, "32")) {
			if (isValid(orig, which)) {
				printf("%s\n", bptr);
				total = 1 + total;
				rptr = getCiberCol(bptr,71,80);
				charge = charge + atoll(rptr);
				free(rptr);
			}
			else {
				fprintf(stderr,"%s\n", bptr);
			}

			free(orig);
		}

		if (strstr(check, "52")) {
			if (isValid(orig, which)) {
				printf("%s\n", bptr);
				total = 1 + total;
				rptr = getCiberCol(bptr,71,80);
				charge = charge + atoll(rptr);
				free(rptr);
			}
			else {
				fprintf(stderr,"%s\n", bptr);
			}

			free(orig);
		}

		*ptr = ch;
		bptr = ptr + 1;

		workrec[0] = 0;
		strncat(workrec, bptr, strlen(bptr));

		bptr = workrec;
	}

}

void processUFF(char *workrec, char * filename) {
	char ch, *ptr, *bptr;
	char *orig, *term;
	long long int total;
	char check[3];
	int which;
	bptr = workrec;

	while ((ptr = strstr((bptr), "\n"))) {
		ch = *ptr;
		*ptr = '\0';

		check[0] = 0;

		strncpy(check, workrec, 2);

		if(strstr(check,"DR"))
		{
			if(strstr(filename,"SAAA1_FUFF"))
			{
				orig = getUFFcol(bptr, 19);
				term = getUFFcol(bptr, 23);
				which = 1;
			}
			else {
				orig = getUFFcol(bptr, 21);
				term = getUFFcol(bptr, 24);
				which = 0;
			}

		}

		if (strstr(check, "HR"))
		{
			total = 1;
			printf("%s\n", bptr);
		}

		if (strstr(check, "DR")) {

			if (isValid(orig, which) && isValid(term, which)) {
				printf("%s\n", bptr);
				total = 1 + total;
			}
			else {
				fprintf(stderr,"%s\n", bptr);
			}

			free(orig);
			free(term);

			total = 1 + total;
		}

		if (strstr(check, "TR")) {
			total = 1 + total;
			bptr = putUFFcol(bptr,6,total);
			printf("%s\n", bptr);
			exit(0);
		}

		*ptr = ch;
		bptr = ptr + 1;

		workrec[0] = 0;
		strncat(workrec, bptr, strlen(bptr));
		bptr = workrec;
	}

}

int isValid(char *number, int which) {
	int length;
	char *bptr;

	char wholeNumber[11];

	if ((length = strlen(number)) >= 10) {
		wholeNumber[0] = 0;

		bptr = number + (length - 10);

		strncat(wholeNumber, bptr, strlen(number));

		if(which)
		{
			if(strstr(lookupMIN, wholeNumber)) return 0;
		}
		else {
			if(strstr(lookup, wholeNumber)) return 0;
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

	rptr = malloc((strlen(bptr) + 1) * sizeof(char));

	strcpy(rptr, bptr);
	*ptr = ch;

	bptr = record;
	return rptr;
}

char * getCiberCol(char *record, int start, int end) {
	char *bptr, *ptr, ch, *rptr;

	bptr = record + start;
	ptr = bptr + 10;
	ch = *ptr;
	*ptr = '\0';

	rptr = malloc((strlen(bptr) + 1) * sizeof(char));

	strcpy(rptr, bptr);
	*ptr = ch;

	return rptr;
}

char * putUFFcol(char *record, int colnum, long long int total) {

	unsigned int a;
	char *bptr, *ptr, *rptr;
	char ch;
	char sTotal[32];

	colnum--;
	sprintf(sTotal,"%lli",total);

	bptr = record;
	ptr = bptr;

	for (a = 0; a < colnum; a++) {
		ptr = strstr(ptr, "|") + 1;
	}

	ch = *ptr;
	*ptr = '\0';

	rptr = malloc((strlen(bptr)+strlen(sTotal) + 1) * sizeof(char));

	rptr[0] = 0;

	strcat(rptr,bptr);
	strcat(rptr,sTotal);


	return rptr;
}

char * putCiberCol(char *record,long long int total, long long int charge)
{
	char sTotal[32], *ptr, *bptr;
	unsigned int a;

	sprintf(sTotal,"%lli",total);

	ptr = pad(sTotal,4);

	bptr = record + 21;

	for (a = 0; a < 4; a++)
	{
		*(bptr + a) = *(ptr + a);
	}

	free(ptr);

	sprintf(sTotal,"%lli",charge);

	ptr = pad(sTotal,12);

	bptr = record + 25;

	for (a = 0; a < 12; a++)
	{
		*(bptr + a) = *(ptr + a);
	}

	free(ptr);

	return record;
}
char * pad(char *what, int size) {
	char *rptr;

	rptr = malloc((size+1) * sizeof(char));
	rptr[0] = 0;

	while (strlen(rptr) < (size - strlen(what))) {
		strncat(rptr, "0", 1);
	}

	strncat(rptr, what, strlen(what));

	return rptr;
}
