/*
    Author: Yeil Park
    Institution: University of Victoria
    Class: SENG265 2022 spring
    Date: 14/02/2022
    Description: This program will parse xml file that is structed with specific format. 
                 And the parsed content will be printed in specific format. Please refer
                 2022-f1-races-americas.xml file and test outputs.
*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

#define MAX_LINE_LEN 200
#define MAX_EVENTS 1000
/*
    Function: main
    Description: represents the entry point of the program.
    Inputs:
        - argc: indicates the number of arguments to be passed to the program.
        - argv: an array of strings containing the arguments passed to the program.
    Output: an integer describing the result of the execution of the program:
        - 0: Successful execution.
        - 1: Erroneous execution.
*/
void convert_time(char* input,char* mytime);
void format_event_detail(char* myevent);
void format_event_date(char* myevent);
void convert_month(char* input,int month);
int get_event_num(char events[][MAX_LINE_LEN]);
void print_events(char events[][MAX_LINE_LEN],int eventNum);
void read_file(char* file_name, char events[][MAX_LINE_LEN],int eventLen);
int filter_events(char events[][MAX_LINE_LEN],char* start,char* end,int arrLen);
void process_ordering(char events[][MAX_LINE_LEN],int lineLen);
int get_event_time(char* event,int option);
int get_events_len(char* file_name);
int get_input_time(char* inputTime);
void get_content(char* arg,char* content,char* symbol, int place);
int main(int argc, char *argv[])
{
    /* Starting calling your own code from this point. */
    // Ideally, please try to decompose your solution into multiple functions that are called from a concise main() function.
    if(argc<4){ // if input from the terminal less than it requires than exit
        exit(0);
    }
    char file_name[100];
    char startDate[50];
    char endDate[50];
    get_content(startDate,argv[1],"=",1); //argv[1]'s input must be --start=2022/3/1 format
    get_content(endDate,argv[2],"=",1);   //argv[2]'s input must be --end=2022/12/31 format
    get_content(file_name,argv[3],"=",1); //argv[3]'s input must be --file=2022-f1-races-americas.xml format
    int eventLen = get_events_len(file_name); //count event's number
    char events[eventLen][MAX_LINE_LEN];  
    read_file(file_name,events,eventLen); //read and modify events, and store it to events[][] 
    int filteredLen = filter_events(events,startDate,endDate,eventLen); //filter the events by given dates
    process_ordering(events,filteredLen); //ordering by using bubble sort, low date to high
    print_events(events,filteredLen);     //print events by given format

    exit(0);
}
    // Function: read_file
    // Description: open file and store the values in the array
    // Inputs:
    //     - file_name: indicates string of file name that will be open in this fuction.
    //     - events[][MAX_LINE_LEN]: an array of strings, and events will be stored as description/timezone/....
    //     - eventLen: integer of events length
void read_file(char* file_name, char events[][MAX_LINE_LEN],int eventLen){
    for(int i =0; i<eventLen;i++){
        events[i][0]='\0';
    }
    int eventChildNum = 9;
    int cnt = 0;
    int event_cnt = 0;
    char buffer[MAX_LINE_LEN];
    FILE* filePointer;
    filePointer = fopen(file_name, "r");
    while(fgets(buffer, MAX_LINE_LEN, filePointer)) {
        char *ret, *ret2; 
        ret = strstr(buffer,"event");
        ret2 = strstr(buffer,"calendar");
        if(ret!=NULL||ret2!=NULL){
        }
        else{ 
            char temp[strlen(buffer)];
            get_content(temp,buffer,"<>",2);
            strcat(events[event_cnt],temp);
            strcat(events[event_cnt],"/");
            cnt++;
        }
        if(cnt==eventChildNum){
            event_cnt++;
            cnt=0;
        }
    }
    fclose(filePointer);
}
    // Function: get_content
    // Description: parse string that user wants from content variables, and the parsed string
    //               will be stroed in given parmeter arg.
    // Inputs:
    //     - arg: string variable that can access outside of this function. Parsed string will be stroed in here
    //     - content: it should contains string, and user want to parse the string from here
    //     - symbol: symbols of delimiter in string type.
    //     - place: integer that shows which place will be extracted in content. starting from 0
void get_content(char* arg,char* content,char* symbol, int place){
    int cnt = 0;
    char temp[MAX_LINE_LEN];
    strcpy(temp,content);
    char* piece = strtok(temp,symbol);
    while(piece != NULL){
        if(cnt == place){
            strcpy(arg, piece);
            return;
        }
        cnt++;
        piece = strtok(NULL, symbol);
    }
}
/*
    Function: get_events_len
    Description: get events length
    Inputs:
        - file_name: string of file name in same folder 
    Output: 
        - (lines-2)/11: integer that computed events length
*/
int get_events_len(char* file_name){
    FILE* filePointer;
    filePointer = fopen(file_name, "r");
    int lines = 1;
    int ch;
    while(!feof(filePointer)){
       ch = fgetc(filePointer);
       if(ch == '\n'){
         lines++;
       }
    }
    fclose(filePointer);
    return (lines-2)/11;   
}
/*
    Function: filter_events
    Description: filter that not contains time between start and end time
    Inputs:
        - events[][MAX_LINE_LEN]: events that was modifed as 2d array of string
        - start: string is formmated as year/mon/days and standing for end date ex)2001/3/1
        - end: string is formmated as year/mon/days and standing for end date ex)2001/3/1 
        - arrLen: length of events in integer
    Output: 
        - int cnt: indicates number of events that is not filtered
*/
int filter_events(char events[][MAX_LINE_LEN],char* start,char* end,int arrLen){
    int startDay = get_input_time(start);
    int endDay = get_input_time(end);
    char temp[arrLen][MAX_LINE_LEN];
    int cnt = 0;
    int isEmpty = 1;
    for(int i = 0;i<arrLen;i++){
        int startt = get_event_time(events[i],0);
        if(startt>=startDay && startt<=endDay){
            strcpy(temp[cnt],events[i]);
            cnt++;
            isEmpty = 0;
        }else{
            strcpy(events[i],"");
        }
    }
    if(isEmpty==1){
        strcpy(events[0],"");
        return 0;
    }
    for(int j = 0;j<cnt;j++){
        strcpy(events[j],temp[j]);
    }
    return cnt;
}
/*
    Function: get_event_time
    Description: get event time and covert to number days or number of minuits
    Inputs:
        - event: string that contains a single event
        - option: 1 is for number of minuit, anything else is for number of days
    Output: 
        - result: integer that will be returned in minuits or days 
*/
int get_event_time(char* event,int option){
    int min, hour, day, month, year, result;
    char sMin[10],sHour[10],sDay[10], sMonth[10], sYear[10];
    get_content(sMin,event,"/:",8);
    get_content(sHour,event,"/:",7);
    get_content(sDay,event,"/",3);
    get_content(sMonth,event,"/",4);
    get_content(sYear,event,"/",5);
    min = atoi(sMin);
    hour = atoi(sHour);
    day = atoi(sDay);  
    month = atoi(sMonth);
    year = atoi(sYear);
    if(option == 1){
        result = min+hour*60+day*1440+month*30*1440+year*360*1440;
    }else{
        result = day+month*30+year*360;
    }
    return result;
}
/*
    Function: get_input_time
    Description: get time from argv[](input form teminal) and convert to integer
    Inputs:
        - event: string that contains a date from terminal
    Output: 
        - result: integer that will be returned in days 
*/
int get_input_time(char* event){
    int day, month, year, result;
    char sDay[10], sMonth[10], sYear[10];
    get_content(sDay,event,"/",2);
    get_content(sMonth,event,"/",1);
    get_content(sYear,event,"/",0);
    day = atoi(sDay);  
    month = atoi(sMonth);
    year = atoi(sYear);
    result = day+month*30+year*360;
    return result;
}
/*
    Function: process_ordering
    Description: bubble sort that is sorting low event time to high. Event's time must be in minuits
    Inputs:
        - event: array of string that contains events
        - lineLen: number of events. Counted from 1
*/
void process_ordering(char events[][MAX_LINE_LEN],int lineLen){
    char temp[lineLen][MAX_LINE_LEN];
    for(int i = 0;i<lineLen-1;i++){
        for(int j = 0;j<lineLen-i-1;j++){
            if(get_event_time(events[j],1)>get_event_time(events[j+1],1)){
                strcpy(temp[j],events[j]); 
                strcpy(events[j],events[j+1]);
                strcpy(events[j+1],temp[j]);    
            }
        }
    }
}
/*
    Function: print_events
    Description: print events in given format. And before use it, the events should be sorted and filtered first

    Inputs:
        - event: array of string that contains events
        - eventNum: number of events that will be printed
    Output: it will print in given format
                format example:
                 June 19, 2022 (Sunday)
                 ----------------------
                 01:30 PM to 03:30 PM: FORMULA 1 GRAND PRIX DU CANADA 2022 - Race {{Montreal, Canada}} | GMT-5

                 October 22, 2022 (Saturday)
                 ---------------------------
                 10:00 AM to 11:00 AM: FORMULA 1 ARAMCO UNITED STATES GRAND PRIX 2022 - Practice 3 {{Austin, USA}} | GMT-6
                 01:00 PM to 02:00 PM: FORMULA 1 ARAMCO UNITED STATES GRAND PRIX 2022 - Qualifying {{Austin, USA}} | GMT-6
*/
void print_events(char events[][MAX_LINE_LEN],int eventNum){
    if(eventNum==0){
        return;
    }
    if(eventNum==1){
        format_event_date(events[0]);
        printf("\n");
        format_event_detail(events[eventNum-1]);
        return;
    }
    format_event_date(events[0]);
    printf("\n");
    for(int i = 0;i<eventNum-1;i++){
        if(get_event_time(events[i],0)==get_event_time(events[i+1],0)){
            format_event_detail(events[i]);
            printf("\n");
        }else{
            format_event_detail(events[i]);
            printf("\n\n");
        }
        if(get_event_time(events[i],0)!=get_event_time(events[i+1],0)){
            format_event_date(events[i+1]);
            printf("\n");
        }
    }
    format_event_detail(events[eventNum-1]);
}
/*
    Function: format_event_detail
    Description: print event detail in given format
    Inputs:
        - myevent: a single string that contains event's detail     
        Outputs:  
        format example: 
        01:00 PM to 02:00 PM: FORMULA 1 ARAMCO UNITED STATES GRAND PRIX 2022 - Qualifying {{Austin, USA}} | GMT-6
*/
void format_event_detail(char* myevent){
    char name[100],timeZ[50],loc[50],start[20],end[20],cStart[20],cEnd[20];
    get_content(name,myevent,"/",0);
    get_content(timeZ,myevent,"/",1);
    get_content(loc,myevent,"/",2);
    get_content(start,myevent,"/",7);
    get_content(end,myevent,"/",8);
    convert_time(cStart,start);
    convert_time(cEnd,end);
    printf("%s to %s: %s {{%s}} | %s",cStart,cEnd,name,loc,timeZ);
}
/*
    Function: format_event_date
    Description: print event date in given format exept hour and min
    Inputs:
        - myevent: a single string that contains event's detail     
    Outputs: 
        format example: 
        October 22, 2022 (Saturday)
        ---------------------------
*/
void format_event_date(char* myevent){
    char day[10], month[10], year[10], dweek[10], cMonth[20];
    get_content(day,myevent,"/",3);
    get_content(month,myevent,"/",4);
    get_content(year,myevent,"/",5);
    get_content(dweek,myevent,"/",6);
    convert_month(cMonth,atoi(month));
    char result[200];
    sprintf(result, "%s %s, %s (%s)\n",cMonth,day,year,dweek);
    printf("%s",result);
    for(int i=0;i<strlen(result)-1;i++){
        printf("-");
    }

}
/*
    Function: convert_time
    Description: convert string 24 hour time to 12 AM/PM string time
    Inputs:
        - input: coverted string time will be stored in this parameter.
        - mytime: string of time in 24 hour format.
    Outputs: 
        format example: 
        10:00 AM
*/
void convert_time(char* input,char* mytime){
    char hour[10],min[10];
    
    get_content(hour,mytime,":",0);
    get_content(min,mytime,":",1);
    
    int intHour;
    char sHour[20];
    intHour = atoi(hour)%12;
    if(intHour==0){
        sprintf(sHour, "%s PM", mytime);

    }else if(atoi(hour)>=12&&intHour>9){
        sprintf(sHour, "%d:%s PM", intHour,min);
    }else if(atoi(hour)>=12&&intHour<10){
        sprintf(sHour, "0%d:%s PM", intHour,min);
    }else{
        sprintf(sHour, "%s AM", mytime);
    }
    strcpy(input,sHour);
}
/*
    Function: convert_month
    Description: convert integer of month to string of named month
    Inputs:
        - input: coverted month will be stored in this parameter.
        - mytime: integer of month
*/
void convert_month(char* input,int month){
    if(month == 1){
        strcpy(input,"January");
    }else if(month == 2){
        strcpy(input,"February");
    }else if(month == 3){
        strcpy(input,"March");
    }else if(month == 4){
        strcpy(input,"April");
    }else if(month == 5){
        strcpy(input,"May");
    }else if(month == 6){
        strcpy(input,"June");
    }else if(month == 7){
        strcpy(input,"July");
    }else if(month == 8){
        strcpy(input,"August");
    }else if(month == 9){
        strcpy(input,"September");
    }else if(month == 10){
        strcpy(input,"October");
    }else if(month == 11){
        strcpy(input,"November");
    }else if(month == 12){
        strcpy(input,"December");
    }else{
        printf("**invalid input**");
    }
    
}