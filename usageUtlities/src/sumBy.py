#! /usr/bin/python3

import fileinput

def returnSums (results, ipDate):
 
    try:
        theSum = sum([x[1] for x in results if x[0] == ipDate])
    except: pass
        
    return (ipDate, theSum)

# Read standard In and fill list
results = []

for line in fileinput.input():
    tmp = line.split("\t")

    try:
        results.append((str(tmp[0]), float(tmp[1])))
    except:pass

for ip_date in sorted(set(map(lambda x:x[0], results))):
    retVal = returnSums(results, ip_date)
    retVal = str(retVal[0]) + "\t" + str(retVal[1])
    print(retVal)
    
