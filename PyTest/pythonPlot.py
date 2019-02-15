#! /usr/bin/python

#Need this to draw pictures
import matplotlib.pyplot as plt
import numpy as np

# Create a range from 0 to 2PI
t = np.arange(0.0, 2*np.pi, 0.01)

# Define a list for Radius
r = np.sin(36*t) + np.sin(3*np.sin(t))
r = 1 - np.sin(t)
# Convert polar coordinates to Cartesian
x = r*np.cos(t)
y = r*np.sin(t)

# Plot the Picture
plt.plot(x, y)

# Label the X Axis
plt.xlabel('Love')

# Label the Y Axis
plt.ylabel('Romance')

# Picture Title
plt.title('Happy Valentines day')

# Turn on Grids
plt.grid(True)

# Save the Picture
plt.savefig("test.png")

SystemExit(0);