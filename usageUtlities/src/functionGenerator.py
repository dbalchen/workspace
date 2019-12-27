#! /usr/bin/python3
import pandas as pd

import scipy.signal

from scipy import stats

import numpy as np

import fileinput

import argparse

def movingAvg(yaxis):
    
    moving_avg = (((pd.DataFrame(yaxis)).rolling(7, center=True).mean()).values).tolist()
    moving_avg = [item for sublist  in moving_avg for item in sublist]
    
    return moving_avg

def polyFit(yaxis,pn):
    
    listLen = len(yaxis)
    
    if(listLen % 2) == 0:
        listLen = listLen - 1
                  
    yhat = (scipy.signal.savgol_filter(yaxis, listLen, pn)).tolist()
    
    return yhat
 
def linearRegression(xaxis, yaxis):
    xxAxx = np.asarray(xaxis, dtype=np.float64)
    yyAxx = np.asarray(yaxis, dtype=np.float64)
    
    slope, intercept, poop, poop, poop = stats.linregress(xxAxx, yyAxx)
 
    mn = np.min(xxAxx)
    mx = np.max(xxAxx)
    
    x1 = np.linspace(mn, mx, len(xaxis))
    y1 = (slope * x1 + intercept).tolist()
    
    return y1

############## Main Program  ########################################

# initiate the parser
parser = argparse.ArgumentParser()

parser.add_argument("--avg", "-a", help="moving average",action="store_true")

parser.add_argument("--polyfit", "-p", help="polynomial fit",default="3")

parser.add_argument("--linear", "-lr", help="linear Regression",action="store_true")

args = parser.parse_args()

results = []

inp = "-"
#inp = "/home/dbalchen/workspace/usageUtlities/data/test.csv"

for line in fileinput.input(inp):
    try:
        line = line.rstrip()
        results.append(tuple(line.split("\t")))
    except:pass

output = []

xf = [float(x[0]) for x in results]
output.append(xf)

yf = [float(x[1]) for x in results]
output.append(yf)

if args.avg :
    fx = movingAvg(yf)
    output.append(fx)

if args.linear :
    fx = linearRegression(xf, yf)  
    output.append(fx)

if float(args.polyfit) >= 1 :
    fx = polyFit(yf,int(args.polyfit))  
    output.append(fx)

for i in range(0,len(xf)):
    for j in range(0,len(output)-1):
        pout = output[j][i]
        print(pout,end ="\t")
    print(output[len(output)-1][i])
    
exit(0)