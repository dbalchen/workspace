#! /usr/bin/python3

# Libraries used for Statistical functions
import sys

import pandas as pd

import scipy.signal

from scipy import stats

import numpy as np

import matplotlib.pyplot as plt

def analysis(data):
    
    row = []
    
    try:
        row = list(((pd.DataFrame(data)).describe())[0]) 
                 
    except:pass

    return row;


def plotIt (usage, title, ylabel, filename):

    xAx = [x[0] for x in usage]
    yAx = [x[1] for x in usage]
    
    st = analysis(yAx)
    
    fig = None
    fig = plt.figure()    
    ax = plt.axes()
    
    # Plot the Picture#    
    
    ax.plot(xAx, yAx, linestyle=':', marker='p', color='b', label=ylabel)

    # Calculate Least Squares for linear regression
    xxAxx = np.asarray(xAx, dtype=np.float64)
    slope, intercept, poop, poop, poop = stats.linregress(xxAxx, yAx)
     
    mn = np.min(xxAxx)
    mx = np.max(xxAxx)
    x1 = np.linspace(mn, mx, len(xAx))
    y1 = slope * x1 + intercept
    
    # Plot
    ax.plot(xAx, y1, color='r', label='Linear Regression')

    # Calculate moving average
    df = pd.DataFrame(yAx)  
       
    mavg = df.rolling(7, center=True).mean()
       
    # Plot
#    ax.xaxis.set_major_locator(plt.MaxNLocator(12))
    
    ax.plot(xAx, mavg, color='g', label='7 Day Moving Average')
    
    listLen = len(usage)
    
    if(listLen % 2) == 0:
        listLen =  listLen -1
       
    yhat = scipy.signal.savgol_filter(yAx, listLen, 4) # window size 51, polynomial order 3
    
    ax.plot(xAx,yhat,color='y',label='Polyfit')

    # Print the Legend
    ax.legend(loc='best')
    
    # Label the X Axis
    ax.set_xlabel('Date')

    # Turn on Grids
    ax.grid(True)

    ax.set_ylabel(ylabel)
    
    # Rotate Axis 90 degrees
    ax.tick_params(axis='x', rotation=90)
    
    # Expand size of
    fig.set_size_inches(18.5, 11.5)    

    # Picture Title
    ax.set_title(title)
    
    ax.axhspan(st[4], st[6], facecolor='0.5', alpha=0.4)
    
    fig.savefig(filename)
    
    return

results = []

with open("/home/dbalchen/Desktop/test1", "r") as fp:
    for i in fp.readlines():
        tmp = i.split("\t")
        try:
            results.append((str(tmp[0]),float(tmp[1])))
        except:pass
         
# for line in sys.stdin:
#     tmp = line.rstrip().split("\t")
#     try:
#         results.append((float(tmp[0]),float(tmp[1])))
#     except:pass

title = sys.argv[1]
yaxis = sys.argv[2]
fileOut = sys.argv[3]

plotIt(results,title,yaxis,fileOut)
