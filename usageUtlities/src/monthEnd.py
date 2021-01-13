#! /usr/bin/python3

'''
Created on Jul 16, 2020

@author: David Balchen

'''

import fileinput
import os
import time
import pandas as pd

def find(name, path):
    for root, dirs, files in os.walk(path):
        if name in files:
            return os.path.join(root, name)
        


def wait_and_find(name,path):
    inp = find(name,path)
    
    while inp == None:
        inp = find(name,path)
        time.sleep(2.4)
    
    return inp

input_file = wait_and_find('snarftestdata.csv','/home/dbalchen/Desktop/')

inputData = []
for line in fileinput.input(input_file):
    try:
        line = line.rstrip()
        inputData.append(tuple(line.split("\t")))
    except:pass

## inputData = inputData[1:0]  # Remove first and last line --- May not need in the future

for line in inputData:
    
    pline = "\t".join(map(str, line))  
        
    try:
        line = (list(line))
        del line[0]
        
        line = [float(x) for x in line]
        desc = list(((pd.DataFrame(line)).describe())[0])
        
        iqr = desc[6] - desc[4]
        uF = desc[6] + (iqr * 0.5)
        lF = desc[4] - (iqr * 0.5)
        
        current = float((line[-1]))
        previous = float((line[-2]))
        
        percent_change = (((current) - previous) / abs(previous)) * 100   
        
        print('{0} \t Mean {1:12.2f} \t STD {2:12.2f} \t Percent Change {3:12.2f}% \t Upper Fence {4:12.2f} \t Lower Fence {5:12.2f}'.format(pline,desc[1],desc[2],percent_change,uF,lF))
        
    except: 
        print("**** Error Occurred **** ", pline)
        pass

SystemExit(0);
