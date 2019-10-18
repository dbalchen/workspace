#! /usr/bin/python3

#Need this to draw pictures
import matplotlib.pyplot as plt

import fileinput

results = []
for line in fileinput.input():
    try:
        line = line.rstrip()
        results.append(tuple(line.split("\t")))
    except:pass

colCount = len(results[0])

fig = plt.figure()    
ax = plt.axes()

    

# # Plot the Picture
# ax.plot(x, y)
# 
# # Label the X Axis
# plt.xlabel('X - Axis')
# 
# # Label the Y Axis
# plt.ylabel('Y - Axis')
# 
# # Picture Title
# plt.title('Python Plot Example')
# 
# # Turn on Grids
# plt.grid(True)
# 
# # Save the Picture
# plt.savefig("test.png")

SystemExit(0);