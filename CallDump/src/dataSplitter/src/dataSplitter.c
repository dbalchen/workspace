/*
  ============================================================================
  Name        : dataSplitter.c
  Author      : David Balchen
  Version     :
  Copyright   : U.S. Cellular
  Description : Splits UFF Data files to the correct markets using the MIN_LR table.
  ============================================================================
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>

#define FILEIN 4096
#define RECLEN 1024
#define TMRKET 6

void openSplitFiles(char *, FILE **);
char *loadMin_Lr(char *);
void processRec(char *, char *, FILE **, long *);
char *pointField(char *, int, const char);
void closeSplitFiles(char *, FILE **, long *);
void processTrailer(char *, FILE **, long *);

int main(int argc, char **argv) {

  FILE *splitFiles[TMRKET+1], *IN_FILE;

  char buffer[FILEIN + RECLEN] = { '\0' };
  char workrec[RECLEN] = { '\0' };
  char *ptr, *bptr, ch, *min_lr;
  long recordCount[] = { 0, 0, 0, 0, 0, 0, 0 };
  int i;
  size_t count;


  min_lr = loadMin_Lr("minLr.db");

  chdir(argv[1]);

  if ((IN_FILE = fopen(argv[2], "rb")) == NULL)
    printf("ERROR ----> Can Not Open Input File (INFL) \n"), exit(12);

  openSplitFiles(argv[2], splitFiles);
  ptr = buffer;

  do {
    count = fread(ptr, 1, FILEIN, IN_FILE);

    if (count <= 0)
      break;

    ptr = buffer;

    while ((bptr = strchr((ptr), '\n'))) {
      ch = *bptr;
      *bptr = '\0';


      if (strstr(ptr, "HR|")) {

	for (i = 0; i <= 6; i++) {
	  fprintf(splitFiles[i], "%s\n", ptr);
	}

      } else if (strstr(ptr, "TR|")) {
	processTrailer(ptr, splitFiles, recordCount);

      } else {
	processRec(ptr, min_lr, splitFiles, recordCount);
      }

      *bptr = ch;
      ptr = bptr + 1;
    }

    workrec[0] = '\0';
    strncat(workrec, ptr, strlen(ptr));
    memset(buffer, 0, sizeof(buffer));
    strncat(buffer, workrec, strlen(workrec));

    ptr = buffer + strlen(buffer);

  } while (count == FILEIN);

  closeSplitFiles(argv[2], splitFiles, recordCount);

  free(min_lr);

  fclose(IN_FILE);

  return EXIT_SUCCESS;
}

char *loadMin_Lr(char *filename) {
  FILE *fp;
  long filesize;
  char *buffer;

  fp = fopen(filename, "rb");
  if (!fp)
    perror(filename), exit(1);

  fseek(fp, 0L, SEEK_END);
  filesize = ftell(fp);
  rewind(fp);

  buffer = calloc(1, filesize + 1);
  if (!buffer)
    fclose(fp), fputs("memory alloc fails", stderr), exit(1);

  if (1 != fread(buffer, filesize, 1, fp))
    fclose(fp), free(buffer), fputs("entire read fails", stderr), exit(1);

  return buffer;
}

void openSplitFiles(char *file, FILE **splitFiles) {
  int i;
  char file_name[248] = { '\0' };

  for (i = 0; i < TMRKET; i++) {
    file_name[0] = '\0';

    sprintf(file_name, "%s.m0%i", file, i + 1);

    if ((splitFiles[i] = fopen(file_name, "w")) == NULL)
      printf("ERROR ----> Can Not Open Input File %s \n", file_name), exit(
									   12);
  }

  sprintf(file_name, "%s.etc", file);
  if ((splitFiles[TMRKET] = fopen(file_name, "w")) == NULL)
    printf("ERROR ----> Can Not Open Input File %s \n", file_name), exit(12);

  return;
}

void closeSplitFiles(char *file, FILE **splitFiles, long *reccount) {
  int i;
  char file_name[248] = { '\0' };

  for (i = 0; i <= TMRKET; i++) {
    file_name[0] = '\0';

    if (i != TMRKET)
      sprintf(file_name, "%s.m0%i", file, i + 1);
    else
      sprintf(file_name, "%s.etc", file);

    if (reccount[i] == 0) {
      fclose(splitFiles[i]);
      remove(file_name);
    } else {
      fclose(splitFiles[i]);
    }

  }
  return;
}
void processRec(char *record, char *min_lr, FILE ** sfiles, long *reccount) {

  char *cptr, *bptr;
  long long mdn, left, right;
  int market = 0;
  char clean[16] = { '\0' };

  if (strstr(record, "DR|")) {

    if (strstr(record, "|MT|")) {

      cptr = pointField(record, 23, '|');
      if (*cptr == '|')
	cptr = pointField(record, 24, '|');

    } else {
      cptr = pointField(record, 19, '|');

      if (*cptr == '|')
	cptr = pointField(record, 21, '|');
    }

    strncpy(clean, cptr, strchr(cptr, '|') - cptr);

    mdn = atoll(clean);

    clean[6] = 0;

    cptr = min_lr;

    while ((cptr = strstr(cptr, clean))) {
      bptr = pointField(cptr, 1, '\t');
      strncat(clean, bptr, strchr(bptr, '\t') - bptr);

      left = atoll(clean);

      clean[6] = 0;
      bptr = pointField(cptr, 2, '\t');

      strncat(clean, bptr, strchr(bptr, '\t') - bptr);

      right = atoll(clean);

      if ((mdn >= left) && (mdn <= right)) {
	clean[0] = 0;
	strncat(clean, pointField(cptr, 5, '\t') + 2, 1);
	market = atoi(clean);
	break;
      }

      clean[6] = 0;
      cptr = cptr + 6;

    }

    if (market != 0) {
      fprintf(sfiles[market - 1], "%s\n", record);
      reccount[market - 1] = reccount[market - 1] + 1;
    } else {
      fprintf(sfiles[6], "%s\n", record);
      reccount[6] = reccount[6] + 1;
    }

  }
  return;
}

char *pointField(char *rec, int num, const char delim) {
  int count;
  char *point;

  point = rec;

  for (count = 0; count < num; count++) {
    point = strchr(point, delim);
    point++;
  }

  return point;
}

void processTrailer(char *record, FILE ** files, long *recordcount) {
  char trailer[128] = { '\0' };
  char RecTotal[12] = { '\0' };
  int recLen;
  char *end_ptr;
  int i = 0;

  end_ptr = pointField(record, 5, '|');
  *end_ptr = 0;
  recLen = strlen(record);

  strncpy(trailer, record, recLen);

  for (i = 0; i <= 6; i++) {
    sprintf(RecTotal, "%li", (recordcount[i] + 2));
    strncat(trailer, RecTotal, strlen(RecTotal));
    fprintf(files[i], "%s\n", trailer);
    trailer[recLen] = 0;
    memset(RecTotal, 0, sizeof(RecTotal));
  }
  return;
}

