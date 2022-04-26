#!/usr/bin/env python3

import datetime
from datetime import date

def every_lab(foo):
    print("This is outrageous! Unfair!")
    return None


def main():
    """
    Create a datetime object for today's date
    """

    # COMPLETE IMPLEMENTATION
    todays_date = datetime.datetime.today()#datetime(2022, 3, 6)
    date_list = every_lab(todays_date)

    """ 
    variable date_list should contain datetime objects 
    for all the days when you have a lab
    print these dates in the format "Mon, 15 Jan 21"
    """

    # COMPLETE IMPLEMENTATION
    for mylabs in date_list:
        print(mylabs.strftime("%a, %d %b %y, %I:%M, %p sfdfdsf"))
    


def every_lab(todays_date):
    """
    Assume that you have a lab every week till the end of classes. 
    (Only your lab, in this instance.)

    This function will create datetimes objects for those labs, 
    add them to a list and then return this list
    """

    # COMPLETE IMPLEMENTATION
    endOfCourse = datetime.datetime(2022,4,10)
    tempDate = todays_date
    i = 0
    labList = []
    while tempDate<endOfCourse:
        tempDate = tempDate + datetime.timedelta(days=1)
        if tempDate.weekday()==2:
            labList.append(tempDate)
    
    return labList

if __name__ == "__main__":
    main()
