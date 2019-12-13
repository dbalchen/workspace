#! /usr/bin/python3

# Libraries used for Statistical functions
import fileinput

import pandas as pd

############## Main Program  ########################################
results = []

inp = "-"

# inp = "/home/dbalchen/workspace/usageUtlities/data/test.csv"

for line in fileinput.input(inp):
    try:
        line = line.rstrip()
        results.append(tuple(line.split("\t")))
    except:pass

xAx = [x[0] for x in results]
yAx = [float(x[1]) for x in results]

desc = list(((pd.DataFrame(yAx)).describe())[0])

iqr = desc[6] - desc[4]
uF = desc[6] + (iqr * 0.5)
lF = desc[4] - (iqr * 0.5)

print("count\t",desc[0])
print("mean\t",desc[1])
print("std\t",desc[2])

print("min\t",desc[3])
print("iq0\t",desc[4])
print("medium\t",desc[5])

print("iq3\t",desc[6])
print("max\t",desc[7])

print("iqr\t",iqr)
print("Upper Fence\t",uF)
print("Lower Fence\t",lF)

SystemExit(0);