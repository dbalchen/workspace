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

void processUFF(char *);
void processCIBER(char *);
int isValid(char *);
char * getUFFcol(char *, int);
char * getCiberCol(char *, int,int);
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

	if ((LOOKUP = fopen(argv[1], "rb")) == NULL) {
		printf("ERROR ----> Can Not Open Lookup Input File \n");
		exit(12);
	}

	lookup = malloc((st.st_size + 128) * sizeof(char));

	fread(lookup, st.st_size, 1, LOOKUP);

	if ((IN_FILE = fopen(argv[2], "rb")) == NULL) {
		printf("ERROR ----> Can Not Open Input Filter File \n");
		exit(12);
	}

	memset(inRec, 0, FILEIN);

	while (fread(inRec, FILEIN, 1, IN_FILE)) {
		strncat(workRec, inRec, FILEIN);

		if (strstr(argv[2], "UFF"))
			processUFF(workRec);
		else
			processCIBER(workRec);

		memset(inRec, 0, FILEIN);
	}

	strncat(workRec, inRec, strlen(inRec));

	if (strstr(argv[2], "UFF"))
		processUFF(workRec);
	else
		processCIBER(workRec);
	;

	fclose(IN_FILE);
	return EXIT_SUCCESS;
}

void processCIBER(char *workrec) {
	char ch, *ptr, *bptr;
	char *oMSID, *oMDN, *tMSID, *tMDN;
	long long int total;
	char check[3];

	bptr = workrec;

	while ((ptr = strstr((bptr), "\n"))) {
		ch = *ptr;
		*ptr = '\0';

		check[0] = 0;

		strncpy(check, workrec, 2);

		if (strstr(check, "01")) {
			printf("%s\n", bptr);
			total = 1;
		}
		if (strstr(check, "22")) {

			oMSID = getCiberCol(bptr, 14,28);
			oMDN = getCiberCol(bptr, 32,46);
			tMDN = getCiberCol(bptr, 133,147);

			if (isValid(oMSID) && isValid(oMDN)
					&& isValid(tMDN)) {
				printf("%s\n", bptr);
				total = 1 + total;
			}

			free(oMSID);
			free(tMDN);
			free(oMDN);
		}
		if (strstr(check, "98")) {
			printf("%s\n", bptr);
			total = total + 1;
		}
		if (strstr(check, "32")) {
			printf("%s\n", bptr);
			total = total + 1;
		}
		if (strstr(check, "52")) {
			printf("%s\n", bptr);
			total = total + 1;
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
	char *oMSID, *oMDN, *tMSID, *tMDN;
	long long int total;
	char check[3];

	bptr = workrec;

	while ((ptr = strstr((bptr), "\n"))) {
		ch = *ptr;
		*ptr = '\0';

		check[0] = 0;

		strncpy(check, workrec, 2);

		if (strstr(check, "HR"))
			total = 0;

		if (strstr(check, "DR")) {

			oMSID = getUFFcol(bptr, 19);
			oMDN = getUFFcol(bptr, 21);
			tMDN = getUFFcol(bptr, 24);
			tMSID = getUFFcol(bptr, 23);

			if (isValid(oMSID) && isValid(tMSID) && isValid(oMDN)
					&& isValid(tMDN)) {
				printf("%s\n", bptr);
				total = 1 + total;
			}

			free(oMSID);
			free(tMDN);
			free(oMDN);
			free(tMSID);

		} else {
			printf("%s\n", bptr);
			total = 1 + total;
		}

		if (strstr(check, "TR")) {

			exit(0);
		}

		*ptr = ch;
		bptr = ptr + 1;

		workrec[0] = 0;
		strncat(workrec, bptr, strlen(bptr));
		bptr = workrec;
	}

}

int isValid(char *number) {

	int length;
	char *bptr, *ptr, ch, *suffix;

	char wholeNumber[11], prefix[7], holder[11], check[2];

	long long int before = 0, compare = 0, after = 0;

	if ((length = strlen(number)) >= 10) {
		wholeNumber[0] = 0;

		bptr = number + (length - 10);

		strncat(wholeNumber, bptr, strlen(number));

		ptr = bptr + 6;
		ch = *ptr;
		*ptr = '\0';

		prefix[0] = 0;
		strncat(prefix, bptr, strlen(bptr));

		*ptr = ch;

		if (((bptr = strstr(lookup, prefix)) != 0)) {
			compare = atoll(wholeNumber);

			check[0] = 0;
			strncpy(check, bptr - 1, 2);

			if (((bptr == lookup) || (strstr(check, "\n")))) {
				holder[0] = 0;
				strncat(holder, prefix, strlen(prefix));

				bptr = (strstr(bptr, "\t") + 1);
				ptr = (strstr(bptr, "\t"));
				ch = *ptr;
				*ptr = '\0';
				suffix = pad(bptr, 4);

				strncat(holder, suffix, strlen(suffix));

				before = atoll(holder);
				free(suffix);
				*ptr = ch;

				holder[0] = 0;
				strncat(holder, prefix, strlen(prefix));

				bptr = ptr + 1;
				ptr = (strstr(bptr, "\n"));
				ch = *ptr;
				*ptr = '\0';
				suffix = pad(bptr, 4);
				strncat(holder, suffix, strlen(suffix));
				after = atoll(holder);
				free(suffix);
				*ptr = ch;

				if ((compare >= before) && (compare <= after))
					return 0;
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

char * pad(char *what, int size) {
	char *rptr;

	rptr = malloc(size * sizeof(char));
	rptr[0] = 0;

	while (strlen(rptr) < (size - strlen(what))) {
		strncat(rptr, "0", 1);
	}

	strncat(rptr, what, strlen(what));

	return rptr;
}
