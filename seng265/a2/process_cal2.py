#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 08:35:33 2022
@author: Yeil Park

This is a text processor that allows to translate XML-based events to YAML-based events.
CAREFUL: You ARE NOT allowed using (i.e., import) modules/libraries/packages to parse XML or YAML
(e.g., yaml or xml modules). You will need to rely on Python collections to achieve the reading of XML files and the
generation of YAML files.
"""
from posixpath import split
import sys
import re
import datetime
from datetime import date
from time import strftime

def parse_xml(fileName):
    """Read file and parse line by line

    Parameters
    ----------
    fileName : str, required
        The file path of the file to read.

    Returns
    -------
    parsed_lines: list of string
        list of parsed string from xml file
    """
    parsed_lines = []
    with open(fileName) as file:
        for line in file:
            line = re.findall(r'<(.*?)>(.*?)</\1>', line)
            if len(line) > 0:
                parsed_lines.append(line[0])
    return parsed_lines

def get_dicts(parsed_lines,content_num):
    """Get dictionary from parsed lines with key name and details

    Parameters
    ----------
    parsed_lines : list of string, required
        list of Parsed line. 
    content_num : int, required
        number of line that contains name and details

    Returns
    -------
    xml_list: list of dictionaries
        each dictionary contains keys(name of detail) and values(detail)
    """
    xml_list = []
    xml_dict = {}
    for i in range(len(parsed_lines)):
        tup = parsed_lines[i]
        xml_dict[tup[0]] = tup[1]
        if (i+1)%content_num == 0 and i>0:
            xml_list.append(xml_dict)
            xml_dict = {}
    return xml_list

def append_time_class(event_list):
    """from the list of dictionaries, get time information and add 
       time class to the dictionaries

    Parameters
    ----------
    event_list : list of dictionaries, required
        each dictionary contains given information of xml file 

    Returns
    -------
    void

    """
    for dict in event_list:
        year = int(dict.get('year'))
        mon = int(dict.get('month'))
        day = int(dict.get('day'))
        start_hour = int(dict.get('start')[:2])
        start_min = int(dict.get('start')[3:])
        end_hour = int(dict.get('end')[:2])
        end_min = int(dict.get('end')[3:])
        start_time = datetime.datetime(year,mon,day,start_hour,start_min)
        end_time = datetime.datetime(year,mon,day,end_hour,end_min)
        dict['start_time_class']=start_time
        dict['end_time_class'] = end_time
def format_time(events):
    """format datetime class to given format and pass to return value

    Parameters
    ----------
    events : dictionary, required
        it should contain datetime class as value

    Returns
    -------
    str: str
        formatted string
    """
    start_t = events.get('start_time_class')
    end_t = events.get('end_time_class')
    str = start_t.strftime("%I:%M %p")+" - "+end_t.strftime("%I:%M %p %A, %B %d, %Y")
    return str

def match_circuit(circuits_list,events):
    """ find circuits information that matches events location

    Parameters
    ----------
    circuits_list : list of dictionaries, required
        the list of dictionaries must be from circuits.xml file. 
    events : dictionary, required
        specific dictionary from main xml file

    Returns
    -------
    circuit: dictionaries
        dictionary that is matched with given location 
    """
    for circuit in circuits_list:
        if events.get('location') == circuit.get('id'):
            return circuit

def match_broad(broad_list,name):
    """ find broadcasters information that matches events location

    Parameters
    ----------
    broad_list : list of dictionaries, required
        the list of dictionaries must be from broadcasters.xml file. 
    name : dictionary, required
        specific dictionary from main xml file

    Returns
    -------
    circuit: dictionaries
        dictionary that is matched with given broadcaster of main xml file 
    """
    for broad in broad_list:
        if broad.get('id') == name:
            return broad

    #events_list must be sorted by start time
def get_output_dict(event_list,broad_list,circuits_list):
    """ create dictionary that has key as date and value as 
        dictionary that contains specific details

    Parameters
    ----------
    event_list : list of dictionaries, required
        the list of dictionaries must be from main xml file. 
    broad_list : list of dictionaries, required
        the list of dictionaries must be from broadcasters.xml file. 
    circuits_list : list of dictionaries, required
        the list of dictionaries must be from circuits.xml file. 

    Returns
    -------
    output_dict: dictionary
        dictionary that contains year as key and information as dictionary
        ex) 
        {'23-02-2022': {keys:values},'23-02-2022':{keys:values}....} 
    """
    output_dict ={}
    inner_dict ={}
    for events in event_list:
        time_str = format_time(events)
        circuit = match_circuit(circuits_list,events)
        broadcasters = events.get('broadcaster').split(",")
        inner_dict['id'] = events.get('id')
        inner_dict['description'] = events.get('description')
        inner_dict['circuit'] = circuit.get('name')+" ("+circuit.get('direction')+")"
        inner_dict['location'] = circuit.get('location')
        inner_dict['when'] = time_str + " ("+circuit.get('timezone')+")"
        inner_dict['broadcasters'] =[]
        #sync events of xml files
        for info in broadcasters:
            broad = match_broad(broad_list,info)
            inner_dict['broadcasters'].append(broad.get('name'))
        mykey = events.get('start_time_class').strftime("%d-%m-%Y")
        #if events have same date as key append to value as list
        if not mykey in output_dict:
            output_dict[mykey] = [inner_dict]
        #else create new key for new date
        else:
            output_dict[mykey].append(inner_dict)
        inner_dict = {}
    return output_dict

def filter_dict(event_list,start_t,end_t):
    """ filter events by given start and end date

    Parameters
    ----------
    event_list : list of dictionaries, required
        the list of dictionaries must be from main xml file. 
    start_t : str, required
        given time format in string. ex)2022/2/1
    start_t : str, required
        given time format in string. ex)2022/2/1

    Returns
    -------
    void
    """
    start_t = start_t.split("/")
    end_t = end_t.split("/")
    start_t = list(map(int, start_t))
    end_t =  list(map(int, end_t))
    start_dt = datetime.datetime(start_t[0],start_t[1],start_t[2])
    end_dt = datetime.datetime(end_t[0],end_t[1],end_t[2])
    temp = event_list.copy()
    for event in temp:
        event_t = event.get('start_time_class')
        if event_t < start_dt or event_t > end_dt:
            event_list.remove(event)
    
    
        
def gen_output_yaml(output):
    """ read formatted dictionary and generate output.yaml file in given format

    Parameters
    ----------
    output: dictionary, required
        dictionary that contains year as key and information as dictionary
        ex) 
        {'23-02-2022': {keys:values},'23-02-2022':{keys:values}....} 

    Returns
    -------
    void
    """

    original_stdout = sys.stdout  
    with open("output.yaml", "w") as f:
        sys.stdout = f 
        if len(output) == 0:
            print("events:",end="")
        else:
            print("events:")
        for dates in output:
            print("  - "+dates+":")
            for detail in output.get(dates):
                print('    - id: '+detail.get('id'))
                print('      description: '+detail.get('description'))
                print('      circuit: '+detail.get('circuit'))
                print('      location: '+detail.get('location'))
                print('      when: '+detail.get('when'))
                print('      broadcasters:')
                #while for loop, if line is last line then do not proceed next line
                for casters in detail.get('broadcasters'):
                    is_last_broad = casters == detail.get('broadcasters')[-1]
                    is_last_event = detail == output.get(dates)[-1]
                    is_last_year = dates == list(output)[-1]
                    if is_last_broad and is_last_year and is_last_event:
                        print('        - '+ casters,end="")
                    else:
                        print('        - '+ casters)

        # Reset the standard output
        sys.stdout = original_stdout 

def print_hello_message(message):
    """Prints a welcome message.

    Parameters
    ----------
    message : str, required
        The file path of the file to read.

    Returns
    -------
    void
        This function is not expected to return anything
    """
    print(message)



def main():
    """The main entry point for the program.
    """
    # if cmd input is not valid exit the program
    try:
        openDate = sys.argv[1][8:]
        endDate = sys.argv[2][6:]
        eventFile = sys.argv[3][9:]
        circuitsFile = sys.argv[4][11:]
        broadFile =  sys.argv[5][15:]
    except:
        print("No Argument Found")
        sys.exit()
    #parse and create list of dictionaries from input files
    circuits_dicts = get_dicts(parse_xml(circuitsFile),5)
    broad_dicts = get_dicts(parse_xml(broadFile),3)
    event_dicts = get_dicts(parse_xml(eventFile),9)
    #to simplify add datetime class to dictionaries
    append_time_class(event_dicts)
    #sort by start time ascending order
    event_dicts = sorted(event_dicts, key = lambda i: (i['start_time_class']))
    #filter in given date range
    filter_dict(event_dicts,openDate,endDate)
    #get final formatted dictionary
    output_dict = get_output_dict(event_dicts,broad_dicts,circuits_dicts)
    #generate output.yaml file
    gen_output_yaml(output_dict)
    
if __name__ == '__main__':
    main()
