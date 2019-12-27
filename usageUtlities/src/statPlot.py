#! /usr/bin/python3

# Need this to draw pictures
import matplotlib.pyplot as plt

import sys

import copy

import argparse

colors = ['b', 'r', 'g', 'y', 'k']
styles = [':','-','-','-','-','-','-','-','-']
marks = ['p','','','','','','','','','']

# initiate the parser
parser = argparse.ArgumentParser()

# add long and short argument
parser.add_argument("--output", "-o", help="set output filename")

parser.add_argument("--title", "-t", help="set picture title",default=False)

parser.add_argument("--iqr0", "-i0", help="low IQR Value",default=False)

parser.add_argument("--iqr1", "-i1", help="High IQR Value",default=False)

parser.add_argument("--scale", "-sc", help="Scale Factor",default=False)

parser.add_argument("--upperfence", "-uf", help="Upper Fence",default=False)

parser.add_argument("--lowerfence", "-lf", help="Lower Fence",default=False)

parser.add_argument("--medium", "-md", help="Medium",default=False)

# read arguments from the command line
args = parser.parse_args()

results = []

file = '-'

for line in sys.stdin:
    try:
        line = line.rstrip()
        results.append(tuple(line.split("\t")))
    except:pass

colCount = len(results[0])

scale = 1

if float(args.scale) > 0 :
    scale = float(args.scale)

fig = plt.figure()    
ax = plt.axes()

header = copy.copy(results[0])

# Set Title
title = args.title

# # Label the X Axis
plt.xlabel(header[0])
# 
# # Label the Y Axis
plt.ylabel(header[1])  

results.pop(0)  

# # Plot the Picture

xA = [x[0] for x in results]

for i in range(1, colCount) :
    
    yA = [(float(x[i]) / float(scale)) for x in results]

    # ax.plot(xA, yA)
    ax.plot(xA, yA, linestyle=styles[i -1], marker=marks[i-1], color=colors[i - 1], label=header[i])

#create grey bar
if float(args.iqr0) > 0 :
    ax.axhspan((float(args.iqr0)/float(scale)), (float(args.iqr1)/float(scale)), facecolor='0.5', alpha=0.4)

# Print Medium
if float(args.medium) > 0 :
    ax.axhline(y = (float(args.medium)/float(scale)),linestyle=styles[0],color='black' ) 

# Print Upper Fence
if float(args.upperfence) > 0 :
    ax.axhline(y = (float(args.upperfence)/float(scale)),linestyle=styles[0],color='black')


# Print Lower Fence
if float(args.lowerfence) > 0 :
    ax.axhline(y = (float(args.lowerfence)/float(scale)),linestyle=styles[0],color='black') 
 

# Print the Title
ax.set_title(title)

# Print the Legend
ax.legend(loc='best')

# # Turn on Grids
plt.grid(True)

# Rotate Axis 90 degrees
ax.tick_params(axis='x', rotation=90)

# Expand size of
fig.set_size_inches(18.5, 11.5)    

# # Save the Picture    
plt.savefig(args.output)

SystemExit(0);
