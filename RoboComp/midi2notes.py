#! /usr/bin/python3

import fileinput

import argparse
import string

parser = argparse.ArgumentParser()

parser.add_argument("--input", "-i", help="Input CSV Files")

parser.add_argument("--output", "-o", help="Output File Name")

args = parser.parse_args()

file_contents = []

lineCount = 0

if args.input:
    inp = args.input
else:
    inp = '-'

# inp = '/home/dbalchen/workspace/RoboComp/test.csv'

for line in fileinput.input(inp):
    try:
        line = line.rstrip()
        file_contents.append(tuple(line.split(",")))
        lineCount = lineCount + 1
    except:pass

if lineCount <= 1:
    exit(0);

numberOfTracks = int(file_contents[0][4]) 
print('//  numberOfTracks =',numberOfTracks)

clockPulsesPerQ = int(file_contents[0][5])
print('//  clockPulsesPerQ =',clockPulsesPerQ)

tempo = int([x for x in file_contents if x[2] == ' Tempo'][0][3])

bpm = int(60000000 / float(tempo))
print('//  bpm =',bpm)

print('// t = TempoClock.default.tempo = ',bpm,'/60;\n')

for i in range(2, numberOfTracks + 1):
    track = [x for x in file_contents if int(x[0]) == i]
    
    endtime = int([x for x in track if (x[2] == ' End_track')][0][1])
    
    title = str([x for x in track if (x[2] == ' Title_t')][0][3])
    
    title = title.strip()
    title = title.replace(" ", "_")
    title = title.replace('"','')
    title = title[0].lower() + title[1:]

    print('//      ' + title)
    noteon = list ([x for x in track if (x[2] == ' Note_on_c')])
    noteon.sort(key=lambda a: int(a[1]))
    
    noteoff = list([x for x in track if (x[2] == ' Note_off_c')])
    noteoff.sort(key=lambda a: int(a[1]))
    
    if len(noteon) == 0 or len(noteoff) == 0:
        break
    
    waits = []
    for item in noteon :
        waits.append(int(item[1]))
    
    waits = sorted(set(waits))
    
    freqs = []
    durations = []
    vels = []
    
    for st in waits :
    
        start_notes = list ([x for x in noteon if int(x[1]) == st])
    
        fre = []
        durs = []
        vel = []
        
        for note in start_notes :
            
            for index, noff in enumerate(noteoff):
                if int(noff[4]) == int(note[4]) :
#                    print(index,note,noff)
                   
                    fre.append(int(note[4]))
                    vel.append(int(note[5]))
 
                    cdurs = (float(noff[1]) - float(note[1])) / float(clockPulsesPerQ)
                    cdurs = round(cdurs,5)
                    
                    durs.append(cdurs)
                    
                    del(noteoff[index])
                    
                    break
                
        if len(fre) > 1 :
            freqs.append(fre)
            durations.append(durs)
            vels.append(vel)
        else :
            freqs.append(int(fre[0]))
            durations.append(float(durs[0]))
            vels.append(int(vel[0]))
 
    if waits[0] != 0 :   
             
        freqs.insert(0,0) 
        vels.insert(0,127) 
        
        cdur = float(waits[0]) / float(clockPulsesPerQ)   
        cdurs = round(cdurs,5)
        durations.insert(0,cdurs)
        
        waits.insert(0,0)
        
        
    waits.append(endtime)
    
    for i in range( 0,len(waits) - 1) :
#        print (i,waits[i])
        
        twai = waits[i+1] - waits[i]
        twai = float(twai) / float(clockPulsesPerQ)
        twai = round(twai,5) 
        
        waits[i] = twai

    del waits[-1]
    
    print ("~"+title+' = Notes.new',";\n")
    
    print ("~"+title+'.freqs =',freqs,";")
    print ("~"+title+'.durations =',durations,";")
    print ("~"+title+'.vels =',vels,";")
    print ("~"+title+'.waits =',waits,";\n")
    print ("~" + title + ' = (' + "~" + title + '.init).remove0waits;' + "\n\n")
   
print('// end')







