#! /usr/bin/python3

import fileinput

import argparse

import string

parser = argparse.ArgumentParser()

parser.add_argument("--input", "-i", help="Input CSV Files")

parser.add_argument("--output", "-o", help="Output File Name")

parser.add_argument('--t0',"-t0", nargs="+", help="starting pitch class")

parser.add_argument('--t1',"-t1", nargs="+", help="ending pitch class")

args = parser.parse_args()

if args.input:
    inp = args.input
else:
    inp = '-'

# inp = '/home/dbalchen/workspace/RoboComp/test.csv'

t0 = [0,2,4,5,7,9,11]
t1 = [0,2,4,5,7,9,11]

if args.t0:
    t0 = list(args.t0[0].split(","))
    t0 = list(map(int, t0))

if args.t1 :
    t1 = list(args.t1[0].split(","))
    t1 = list(map(int, t1))
   
center = 60
low = 0
high = 120


for line in fileinput.input(inp):
    try:
        line = line.rstrip()
         
        if 'Note_o' in line :
            
            note = list(line.split(","))
                        
            pitch = int(note[4])%12
            
            try :
                pidx = t0.index(pitch)
                pitch = t1[pidx]
            except: pass
            
            pitch = center + pitch
            
            if pitch > high :
                pitch = pitch - 12
                
            if pitch < low :
                pitch = pitch + 12
                
            note[4] = str(pitch)
            
            line = ",".join(note)
            
        print(line)   
        
    except:pass

exit(0)




