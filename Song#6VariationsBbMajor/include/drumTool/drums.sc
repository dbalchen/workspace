~drumSound.free;
~drumSound = ~loadSamples.value("/home/dbalchen/Music/Song#6VariationsBbMajor/samples/808");

~allTimes = [1.0,0.5,0.25,0.25,0.5,0.5,0.5,0.5,1.0,0.5,0.25,0.25,0.5,0.5,0.5,0.5,1.0,0.5,0.25,0.25,0.5,0.5,0.5,0.5,1.0,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.5]; 

~c7 = MyEvents.new;
~c7.waits = ~allTimes.deepCopy;
~c7.freqs = [59,59,59,0,59,59,59,59,59,59,59,0,59,59,59,59,59,59,59,0,59,59,59,59,59,59,59,0,59,0,59,0,59,59];
~c7.probs = [1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,0,1,0,1,1];
~c7.durations = [1.0,0.5,0.5,0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0,0.5,0,0.5,0,0.5,0.5] * 4;
~c7.init;
~c7.amp = 3.0;

~crash = MyEvents.new;
~crash.waits = [4.0]; 
~crash.freqs = [49];
~crash.probs = [1];
~crash.durations = [4.0];
~crash.init;
~crash.amp = 3.0;

~bassdrum = MyEvents.new;
~bassdrum.waits = ~allTimes.deepCopy;
~bassdrum.freqs = [35,0,0,35,0,35,0,0,35,0,0,35,0,35,0,35,35,0,0,35,0,35,0,35,35,0,0,35,0,35,0,0,35,0];
~bassdrum.probs = [1,0,0,1,0,1,0,0,1,0,0,1,0,1,0,1,1,0,0,1,0,1,0,1,1,0,0,1,0,1,0,0,1,0];
~bassdrum.durations = [1.75,0,0,0.75,0,1.5,0,0,1.75,0,0,0.75,0,1.0,0,0.5,1.75,0,0,0.75,0,1.0,0,0.5,1.75,0,0,0.5,0,0.75,0,0,1.0,0];
~bassdrum.init;
~bassdrum.amp = 2.0;




~snare = MyEvents.new;
~snare.waits = ~allTimes.deepCopy ;
~snare.freqs = [0,40,0,0,0,0,40,0,0,40,0,0,0,0,40,0,0,40,0,0,0,0,40,0,0,40,0,0,0,0,0,40,0,40];
~snare.probs = [0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,1];
~snare.durations = [0,2.0,0,0,0,0,2.0,0,0,2.0,0,0,0,0,2.0,0,0,2.0,0,0,0,0,2.0,0,0,1.75,0,0,0,0,0,0.75,0,0.5];
~snare.init;
~snare.amp = 3.0;

~rollprobs = 1;
~roll = MyEvents.new;
~roll.waits = [0.5,0.375,0.125,0.25,0.25,0.16666666666667,0.0833333333333299,0.25,0.5,0.75,0.25,0.16666666666667,0.0833333333333299,0.25];
//~roll.probs = [0,0,0,1,0,0,0,0,0,1,1,1,0,0] * 1;
~roll.probs =   [0,0,0,1,0,0,0,1,1,1,1,1,0,1] * 1;
//~roll.probs = [0,1,1,0,1,1,1,0,0,0,0,0,1,1] * 1;
//~roll.probs = [0,0.3333333333,0.3333333333,1,0.3333333333,0.3333333333,0.3333333333,0.6666666667,0.6666666667,1,1,1,0.3333333333,0.3333333333] * 2;
~roll.freqs = [0,50,50,48,47,50,47,50,45,45,47,50,47,45];
~roll.durations = [0,1,1,1,1,1,1,1,1,1,1,1,1,1];

/*
~roll.waits = [0.5,0.375,0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.25,0.25,0.25,0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.25];
~roll.probs = [ 0,0.5714285714,0.1428571429,0.8571428571,0.1428571429,0.1428571429,0.1428571429,0.5714285714,0.1428571429,0.4285714286,0.1428571429,1,0.4285714286,0.7142857143,0.4285714286,0.1428571429,0.8571428571,0.1428571429,0.4285714286,0.1428571429,0.8571428571,0.1428571429,0.2857142857] * Array.series(23, 0, ~rollprobs/23);
~roll.freqs = [0,50,45,50,445,48,45,48,50,45,48,50,45,50,48,45,50,47,48,50,47,45,45];
~roll.durations = [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
*/

~roll.init;
~roll.amp = 1.5;

~recrash = {

~crash.waits = [4.0]; 
~crash.freqs = [49];
~crash.probs = [1];
~crash.durations = [4.0];
~crash.amp = 1.40;

};


~reroll = {
~roll.waits = [0.5,0.375,0.125,0.25,0.25,0.16666666666667,0.0833333333333299,0.25,0.5,0.75,0.25,0.16666666666667,0.0833333333333299,0.25];
~roll.probs =   [0,0,0,1,0,0,0,1,1,1,1,1,0,1] * 1;
~roll.freqs = [0,50,50,48,47,50,47,50,45,45,47,50,47,45];
~roll.durations = [0,1,1,1,1,1,1,1,1,1,1,1,1,1];
~roll.amp = 1.5;
};

~main = {

~bassdrum.waits = ~allTimes.deepCopy;
~bassdrum.freqs = [35,0,0,35,0,35,0,0,35,0,0,35,0,35,0,35,35,0,0,35,0,35,0,35,35,0,0,35,0,35,0,0,35,0];
~bassdrum.probs = [1,0,0,1,0,1,0,0,1,0,0,1,0,1,0,1,1,0,0,1,0,1,0,1,1,0,0,1,0,1,0,0,1,0];
~bassdrum.durations = [1.75,0,0,0.75,0,1.5,0,0,1.75,0,0,0.75,0,1.0,0,0.5,1.75,0,0,0.75,0,1.0,0,0.5,1.75,0,0,0.5,0,0.75,0,0,1.0,0];
~bassdrum.amp = 2.0;

~c7.amp = 8.0;
~c7.waits = ~allTimes.deepCopy;
~c7.freqs = [59,59,59,0,59,59,59,59,59,59,59,0,59,59,59,59,59,59,59,0,59,59,59,59,59,59,59,0,59,0,59,0,59,59];
~c7.probs = [1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,0,1,0,1,1];
~c7.durations = [1.0,0.5,0.5,0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0,0.5,0,0.5,0,0.5,0.5] * 4;

~snare.waits = ~allTimes.deepCopy ;
~snare.freqs = [0,40,0,0,0,0,40,0,0,40,0,0,0,0,40,0,0,40,0,0,0,0,40,0,0,40,0,0,0,0,0,40,0,40];
~snare.probs = [0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,1];
~snare.durations = [0,2.0,0,0,0,0,2.0,0,0,2.0,0,0,0,0,2.0,0,0,2.0,0,0,0,0,2.0,0,0,1.75,0,0,0,0,0,0.75,0,0.5];
~snare.amp = 3.0;

};


~tr8 = {
~bassdrum.waits = [1.75,0.5,0.75,1.0]; 
~bassdrum.freqs = [35,35,35,35];
~bassdrum.probs = [1,1,1,1];
~bassdrum.durations = [1.75,0.5,0.75,1.0];
~snare.waits = [1.0,1.75,0.75,0.5]; 
~snare.freqs = [0,38,38,38];
~snare.probs = [0,1,1,1];
~snare.durations = [0,1.75,0.75,0.5];
~c7.waits = [1.0,0.5,0.5,0.5,0.5,0.5,0.5]; 
~c7.freqs = [51,51,51,51,51,51,51];
~c7.probs = [1,1,1,1,1,1,1];
~c7.durations = [1.0,0.5,0.5,0.5,0.5,0.5,0.5] * 4;

};

~m8d = {

~c7.waits = [1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5]; 
~c7.freqs = [51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51];
~c7.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~c7.durations = [1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5] * 4;

~snare.waits = [1.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,1.75,0.75,0.5]; 
~snare.freqs = [0,38,38,38,38,38,38,38,38,38,38,38];
~snare.probs = [0,1,1,1,1,1,1,1,1,1,1,1];
~snare.durations = [0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,1.75,0.75,0.5];

~bassdrum.waits = [1.75,0.75,1.5,1.75,0.75,1.0,0.5,1.75,0.75,1.0,0.5,1.75,0.75,1.5,1.75,0.5,0.75,1.0,4.0]; 
~bassdrum.freqs = [35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35];
~bassdrum.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~bassdrum.durations = [1.75,0.75,1.5,1.75,0.75,1.0,0.5,1.75,0.75,1.0,0.5,1.75,0.75,1.5,1.75,0.5,0.75,1.0,4.0];

};

~endDrums = {

~bassdrum.waits = [1.75,0.75,1.5,1.75,0.5,0.75,1.0]; 
~bassdrum.freqs = [35,35,35,35,35,35,35];
~bassdrum.probs = [1,1,1,1,1,1,1];
~bassdrum.durations = [1.75,0.75,1.5,1.75,0.5,0.75,1.0];
~snare.waits = [1.0,2.0,2.0,1.75,0.75,0.5]; 
~snare.freqs = [0,38,38,38,38,38];
~snare.probs = [0,1,1,1,1,1];
~snare.durations = [0,2.0,2.0,1.75,0.75,0.5];
~c7.waits = [1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5]; 
~c7.freqs = [51,51,51,51,51,51,51,51,51,51,51,51,51,51];
~c7.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~c7.durations = [1.0,0.5,0.5,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5] *4;


};

~haunting = {

~bassdrum.filter.attack = 0.6;
~bassdrum.filter.release = 10.0;
~bassdrum.filter.cutoff = 1120;
~bassdrum.filter.sustain = 1.0;
~bassdrum.filter.gain = 0.0;
~bassdrum.filter.aoc = 1.00;
~bassdrum.envelope.attack = 0.3;
~bassdrum.envelope.decay= 10.0;
~bassdrum.envelope.sustain = 1.0;
~bassdrum.envelope.release = 10.0;


};

~normal = {

~snare.filter.attack = 0.0;
~snare.filter.release = 0.0;
~snare.filter.cutoff = 9000;
~snare.filter.sustain = 1.0;
~snare.filter.gain = 3.5;
~snare.filter.aoc = 1.00;
~snare.envelope.attack = 0.0;
~snare.envelope.decay= 0.0;
~snare.envelope.sustain = 1.0;
~snare.envelope.release = 0.0;

~bassdrum.filter.attack = 0.0;
~bassdrum.filter.release = 0.0;
~bassdrum.filter.cutoff = 2700;
~bassdrum.filter.sustain = 0.6;
~bassdrum.filter.gain = 0.3;
~bassdrum.filter.aoc = 1.00;
~bassdrum.envelope.attack = 0.0;
~bassdrum.envelope.decay= 0.3;
~bassdrum.envelope.sustain = 0.35;
~bassdrum.envelope.release = 0.0;

~c7.filter.attack = 10.0;
~c7.filter.release = 4.0;
~c7.filter.cutoff = 5000;
~c7.filter.sustain = 2.0;
~c7.filter.gain = 1.0;
~c7.filter.aoc = 1.00;
~c7.envelope.attack = 10.0;
~c7.envelope.decay= 10.0;
~c7.envelope.sustain = 1.0;
~c7.envelope.release = 10.0;
~c7.amp = 8.0;

~crash.filter.attack = 0.0;
~crash.filter.release = 4.0;
~crash.filter.cutoff = 15000;
~crash.filter.sustain = 2.0;
~crash.filter.gain = 2.0;
~crash.filter.aoc = 0;
~crash.envelope.attack = 2.0;
~crash.envelope.decay= 10.0;
~crash.envelope.sustain = 1.0;
~crash.envelope.release = 10.0;
~crash.amp = 2.0;

~roll.filter.attack = 0.0;
~roll.filter.release = 4.0;
~roll.filter.cutoff = 10000;
~roll.filter.sustain = 2.0;
~roll.filter.gain = 1.0;
~roll.filter.aoc = 0;
~roll.envelope.attack = 0.0;
~roll.envelope.decay= 10.0;
~roll.envelope.sustain = 1.0;
~roll.envelope.release = 10.0;
~roll.amp = 1.0;
};



~normal.value;

~tr808Template = {
  arg x,num,sounds;
   if(num == 35,{x.set(\bufnum, sounds.at(0));}); 
   if(num == 40,{x.set(\bufnum, sounds.at(1));}); 
   if(num == 59,{x.set(\bufnum, sounds.at(2));}); 
   if(num == 45,{x.set(\bufnum, sounds.at(6));}); 
   if(num == 47,{x.set(\bufnum, sounds.at(5));}); 
   if(num == 48,{x.set(\bufnum, sounds.at(4));}); 
   if(num == 50,{x.set(\bufnum, sounds.at(3));}); 
   if(num == 49,{x.set(\bufnum, sounds.at(7));}); 
};