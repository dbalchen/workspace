#! /usr/bin/python3

# Libraries used for Statistical functions
import sys,fileinput

import pandas as pd

import scipy.signal

from scipy import stats

import numpy as np

import copy

def movingAvg(yaxis):
    
    moving_avg = (((pd.DataFrame(yaxis)).rolling(7, center=True).mean()).values).tolist()
    moving_avg = [item for sublist  in moving_avg for item in sublist]
    
    return moving_avg

def polyFit(yaxis):
    
    listLen = len(yaxis)
    
    if(listLen % 2) == 0:
        listLen = listLen - 1
                  
    yhat = (scipy.signal.savgol_filter(yaxis, listLen, 4)).tolist()
    
    return yhat
 
def linearRegression(xaxis,yaxis):
    xxAxx = np.asarray(xaxis, dtype=np.float64)
    slope, intercept, poop, poop, poop = stats.linregress(xxAxx, yaxis)
 
    mn = np.min(xxAxx)
    mx = np.max(xxAxx)
    
    x1 = np.linspace(mn, mx, len(xaxis))
    y1 = (slope * x1 + intercept).tolist()
    
    return y1

############## Main Program  ########################################
results = []
with open("/home/dbalchen/workspace/usageUtlities/src/allData", "rb") as fp:
    for line in fp.readlines(): 
        try:
            line = line.rstrip()
            results.append(tuple(line.split("\t")))
        except:pass

header = copy.copy(results[0])

results.pop(0)  

xAx = [x[0] for x in results]
yAx = [float(x[1]) for x in results]

desc = list(((pd.DataFrame(yAx)).describe())[0])

iqr = desc[6] - desc[4]
uF = desc[6] + (iqr*0.5)
lF = desc[4] - (iqr*0.5)

print("count\tmean\tstd\tmin\tIQ0\tmedian\tIQ3\tmax\tiqr\tuF\tlF")

stringOut = str(desc[0]) + "\t" + str(desc[1]) + "\t" + str(desc[2]) + "\t" +str(desc[3]) + "\t" +str(desc[4]) + "\t" +str(desc[5]) + "\t" +str(desc[6]) + "\t" +str(desc[7]) + "\t"+ str(iqr) + "\t"+ str(uF) +"\t"+ str(lF)

print(stringOut)

mavg = movingAvg(yAx)

pfit = polyFit(yAx)

lr = linearRegression(xAx,yAx) 

stringOut = str(header[0]) + "\t" + str(header[1]) + "\tLinear Regression" + "\tMoving Average" + "\tPolyFit"
print(stringOut)

for x in range(len(xAx)):
    stringOut = str(xAx[x]) + "\t" + str(yAx[x]) + "\t" + str(lr[x]) + "\t" + str(mavg[x]) + "\t" + str(pfit[x])
    print(stringOut)

SystemExit(0);
