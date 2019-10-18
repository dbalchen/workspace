#! /usr/bin/python3

# Libraries used for Statistical functions
import fileinput

import pandas as pd

import scipy.signal

from scipy import stats

import numpy as np

results = []

for line in fileinput.input():
    tmp = line.split("\t")
    try:
        results.append((str(tmp[0]), float(tmp[1])))
    except:pass

xAx = [x[0] for x in results]
yAx = [x[1] for x in results]

moving_avg = (((pd.DataFrame(yAx)).rolling(7, center=True).mean()).values).tolist()
moving_avg = [item for sublist  in moving_avg for item in sublist]

listLen = len(results)
if(listLen % 2) == 0:
    listLen = listLen - 1
         
yhat = (scipy.signal.savgol_filter(yAx, listLen, 4)).tolist()

xxAxx = np.asarray(xAx, dtype=np.float64)
slope, intercept, poop, poop, poop = stats.linregress(xxAxx, yAx)

mn = np.min(xxAxx)
mx = np.max(xxAxx)
x1 = np.linspace(mn, mx, len(xAx))
y1 = (slope * x1 + intercept).tolist()

desc = list(((pd.DataFrame(yAx)).describe())[0])

print("count\t" + str(desc[0]))
print("mean\t"+ str(desc[1]))
print("std\t"+ str(desc[2]))
print("min\t"+ str(desc[3]))
print("IQ0\t"+ str(desc[4]))
print("median\t"+ str(desc[5]))
print("IQ3\t"+ str(desc[6]))
print("max\t"+ str(desc[7]) + "\n")


stringOut = "X Value" + "\tY Value" + "\tLinear Regression" + "\tMoving Average" + "\tPolyFit"
print(stringOut)

for x in range(len(xAx)):
    stringOut = str(xAx[x]) + "\t" + str(yAx[x]) + "\t" + str(y1[x]) + "\t" + str(moving_avg[x]) + "\t" + str(yhat[x])
    print(stringOut)

SystemExit(0);