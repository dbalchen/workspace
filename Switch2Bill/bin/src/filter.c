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
int checkTrailer(char *, char *, int);

int main(int argc, char *argv[]) {

	FILE *IN_FILE;
	FILE *LOOKUP;

	char inRec[FILEIN];
	char workRec[WRKLEN];

	char *lookup;
	struct stat st;


	workRec[0] = 0;

	if(argc == 0)
	{
		printf("No file given\n");
		exit(0);
	}


	stat(argv[1],&st);

	lookup = malloc((st.st_size + 128)*sizeof(char));

	if((LOOKUP = fopen(argv[1],"rb")) == NULL)
	{
		printf("ERROR ----> Can Not Open Lookup Input File \n");
		exit(12);
	}

	fread(lookup,st.st_size,1,LOOKUP);

	if((IN_FILE = fopen(argv[2],"rb")) == NULL)
	{
		printf("ERROR ----> Can Not Open Input Filter File \n");
		exit(12);
	}

	while(fread(inRec,FILEIN,1,IN_FILE))
	{
		strncat(workRec,inRec,FILEIN);

		processUFF(workRec);

		inRec[0] = 0;
	}

	strncat(workRec,inRec,FILEIN);

	processUFF(workRec);

	fclose(IN_FILE);
	return EXIT_SUCCESS;
}

void processUFF(char *workrec)
{
	char ch,*ptr,*bptr;

	if(checkTrailer(workrec,"TR",0)) return;

	if((bptr = strstr(workrec,"HR")) || (bptr = strstr(workrec,"DR")) || (bptr = strstr(workrec,"TR")))
	{
		while((ptr = strstr((bptr),"\n")))
		{
			ch = *ptr;*ptr = '\0';

			if(checkTrailer(bptr,"TR",1)) return;

			printf("%s\n",bptr);

			*ptr = ch;
			bptr = ptr+1;

			workrec[0] = 0;
			strncat(workrec,bptr,strlen(bptr));

			bptr = workrec;
		}

	}

	if(checkTrailer(workrec,"TR",0)) return;
}

int checkTrailer(char *workrec,char *look, int pass )
{
	char check[2];
	char *find;

	check[0] = 0;

	strncpy(check,workrec,2);

	if(strstr(check,look))
	{

		if((find = strstr((workrec),"\n")))
		{
			*find = '\0';
			pass = 1;
		}

		if(pass){
			printf("%s\n",workrec);
			exit(0);
		}

	}
	return 0;
}
