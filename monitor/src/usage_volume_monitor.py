#! /usr/bin/python

# Oracle Libraries
import cx_Oracle

# Libraries used for Statistical functions
import pandas as pd

from scipy import stats

import numpy as np

import matplotlib.pyplot as plt

from __builtin__ import int, str

from cx_Oracle import Date


def dbConnect ():
    
    CONN_INFO = {
        'host': '10.176.199.19',  # info from tnsnames.ora
        'port': 1530,  # info from tnsnames.ora
        'user': 'md1dbal1',
        'psw': 'Potat000#',
        'service': 'bodsprd_adhoc'  # info from tnsnames.ora
    }
    CONN_STR = '{user}/{psw}@{host}:{port}/{service}'.format(**CONN_INFO)
  
    tconn = cx_Oracle.connect(CONN_STR)

#    tconn = cx_Oracle.connect(user='', password='', dsn="BODS_SVC_BILLINGOPS")
    
    return tconn;


def returnSums (results, ipDate, payType, eveType):
 
    try:
        
        hrecsum = sum([x[4] for x in results if x[3] == ip_date and x[2] == payType and x[6] == eveType and x[1] == 'N'])
        hvolsum = sum([x[5] for x in results if x[3] == ip_date and x[2] == payType and x[6] == eveType and x[1] == 'N'])
    
        rrecsum = sum([x[4] for x in results if x[3] == ip_date and x[2] == payType and x[6] == eveType and x[1] == 'Y'])
        rvolsum = sum([x[5] for x in results if x[3] == ip_date and x[2] == payType and x[6] == eveType and x[1] == 'Y'])
        
    except: pass
    
    return (ipDate, hrecsum + rrecsum, hvolsum + rvolsum, hrecsum, hvolsum, rrecsum, rvolsum)


def plotIt (usage, usageType, title, ylabel, filename):
    
    filenameL = filename + "L.png"
    filenameS = filename + "S.png"
    
    xAx = [x[0] for x in usage]
    yAx = [x[usageType] for x in usage]
    
    fig = None
    fig = plt.figure()    
    ax = plt.axes()
    
    # Plot the Picture
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
    mavg = pd.DataFrame(yAx)     
    mavg = mavg.rolling(7, center=True).mean()
    # Plot
    ax.plot(xAx, mavg, color='g', label='7 Day Moving Average')

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
    
    fig.savefig(filenameL)

    # Save a smaller version
    ax.xaxis.set_major_locator(plt.MaxNLocator(5))
    
    ax.tick_params(axis='x', rotation=0)
    
    fig.set_size_inches(6, 4)
    
    fig.savefig(filenameS)
    
    return

def perDif (dval, iq0, iq3):
    
    pdl = []
    
    for x in dval:

        if x > iq3:
            pdl.append(((x - iq3) / iq3) * 100)
        elif x < iq0:
            pdl.append(((x - iq0) / iq0) * 100)
        else:
            pdl.append(0.00)

    return pdl;

def analyse (aip, ahome, aroam, aipDate):
    
    row = []
    
    try:
        bl = [''] * 7
    
        home_desc = list(((pd.DataFrame(ahome)).describe())[0])
        roam_desc = list(((pd.DataFrame(aroam)).describe())[0])
    
        home_last_min = min(ahome[-5:])
        home_last_max = max(ahome[-5:])
    
        aroam_last_min = min(aroam[-5:])
        aroam_last_max = max(aroam[-5:])
    
        if (home_desc[7] > 1000 or roam_desc[7] > 1000) and ((home_last_min < home_desc[4] 
            or roam_last_min < roam_desc[4]) or (home_last_max > home_desc[6] or roam_last_max > roam_desc[6])) :
        
            row.append((aip, float(home_desc[5]), float(home_desc[4]), float(home_desc[6]), float(home_desc[1]), float(home_desc[2]), float(home_desc[7]), float(home_desc[3]),
                float(roam_desc[5]), float(roam_desc[4]), float(roam_desc[6]), float(roam_desc[1]), float(roam_desc[2]), float(roam_desc[7]), float(roam_desc[3])))
            
            homeDif = perDif(ahome[-5:], home_desc[4], home_desc[6])
            roamDif = perDif(aroam[-5:], roam_desc[4], roam_desc[6])
            
            row = row + list(zip(aipDate[-5:], ahome[-5:], homeDif, bl, bl, bl, bl, bl, aroam[-5:], roamDif, bl, bl, bl, bl))
                 
    except:pass
    
    return row;

   
##############  Main Program  ###################

conn = dbConnect()
cursor = conn.cursor() 

sql = """
  SELECT /*+ parallel (t1,16) */
        t1.l9_ip_address,
         t1.L9_NT_ROAMING_IND,
         t1.l3_payment_category,
         TO_CHAR (TRUNC (t1.sys_creation_date), 'YYYYMMDD'),
         (COUNT (*)/10000) AS RECORDS,
         ROUND (SUM (t1.l3_volume / 1024 / 1024 / 1024 / 1024), 8),
         t1.l9_volume_type,
         t1.event_type_id
    FROM ape1_rated_event t1
   WHERE     t1.event_type_id IN (51, 69)
         AND t1.l3_payment_category IN ('PRE', 'POST')
         AND t1.l9_volume_type IN ('2G', '3G', '4G')
         AND TRUNC (t1.sys_creation_date) BETWEEN TRUNC (SYSDATE - 90)
                                              AND TRUNC (SYSDATE - 1)
GROUP BY t1.l9_ip_address,
         t1.L9_NT_ROAMING_IND,
         t1.l3_payment_category,
         TO_CHAR (TRUNC (t1.sys_creation_date), 'YYYYMMDD'),
         t1.l9_volume_type,
         t1.event_type_id
ORDER BY 2 ASC
"""

results = []
 
# with open("/home/dbalchen/Desktop/Test.csv", "rb") as fp:
#     for i in fp.readlines():
#         tmp = i.split("\t")
#         try:
#             results.append((str(tmp[0]), str(tmp[1]), str(tmp[2]), str(tmp[3]), float(tmp[4]), float(tmp[5]), str(tmp[6]), int(tmp[7])))
#         except:
#             print("ouch")

cursor.execute(sql)
# 
results = cursor.fetchall()

pre3G = []
pre4G = []
post3G = []
post4G = []

for ip_date in sorted(set(map(lambda x:x[3], results))):
    pre3G.append(returnSums(results, ip_date, 'PRE', '3G'))
    pre4G.append(returnSums(results, ip_date, 'PRE', '4G'))
    post3G.append(returnSums(results, ip_date, 'POST', '3G'))
    post4G.append(returnSums(results, ip_date, 'POST', '4G'))

plotIt(pre3G, 1, "Pre-Paid 3G Data - Records", "Records / 10000", "pp3G_Records")
plotIt(pre4G, 1, "Pre-Paid 4G Data - Records", "Records / 10000", "pp4G_Records")
plotIt(post3G, 1, "Post-Paid 3G Data - Records", "Records / 10000", "postp3G_Records")
plotIt(post4G, 1, "Post-Paid 4G Data - Records", "Records / 10000", "postp4G_Records")

plotIt(pre3G, 2, "Pre-Paid 3G Data - Volume", "Volume TB", "pp3G_Volume")
plotIt(pre4G, 2, "Pre-Paid 4G Data - Volume", "Volume TB", "pp4G_Volume",)
plotIt(post3G, 2, "Post-Paid 3G Data - Volume", "Volume TB", "postp3G_Volume")
plotIt(post4G, 2, "Post-Paid 4G Data - Volume", "Volume TB", "postp4G_Volume")

cursor.close

conn.close()

SystemExit(0);

