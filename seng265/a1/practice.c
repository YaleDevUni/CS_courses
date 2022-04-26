#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

int main(){
   int ret;
   time_t start, end;
   struct tm info, info1;
   char buffer[80];

   info.tm_year = 2001 - 1900;
   info.tm_mon = 7 ;
   info.tm_mday = 4;
   info.tm_hour = 0;
   info.tm_min = 0;
   info.tm_sec = 1;
   info.tm_isdst = -1;

   info1.tm_year = 2001 - 1900;
   info1.tm_mon = 7 ;
   info1.tm_mday = 4;
   info1.tm_hour = 0;
   info1.tm_min = 0;
   info1.tm_sec = 11;
   info1.tm_isdst = -1;

   start = mktime(&info);
    end = mktime(&info1);
    double difft;
    difft = difftime(end,start);
    printf("%f",difft);
    exit(0);
}