"/home/dbalchen/workspace/SuperCollider/eStrings.sc".loadPath;



~strings1 = MyEvents.new;
~strings1.amp = 1.0;
~strings1.waits = [16.06,15.94,16.06,48.0,7.94,8.0,4.0,4.0,4.0,4.06,7.94,4.0,4.0,4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.01,4.0,4.0,4.0,3.99,4.01,4.0,4.0,4.0,16.0,16.06,15.94,16.06,324.00];
 
~strings1.freqs = [70,63,70,63,65,67,63,65,63,62,65,67,63,67,63,65,60,58,65,69,67,63,65,69,63,62,60,63,60,63,67,63,67,65,65,69,67,63,65,69,63,62,70,63,70,63,65];

~strings1.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

~strings1.durations = [16.0,15.94,16.0,15.94,7.94,8.0,4.0,4.0,4.0,4.0,7.94,4.0,4.0,4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.01,4.0,4.0,4.0,3.99,4.01,4.0,4.0,4.0,16.0,16.0,15.94,16.0,23.44];


~strings1.init;

~strings1.envelope.attacks =  [16.0,15.94,16.0,15.94,7.94,8.0,4.0,4.0,4.0,4.0,7.94,4.0,4.0,4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.01,4.0,4.0,4.0,3.99,4.01,4.0,4.0,4.0,16.0,16.0,15.94,16.0,23.44] * 0.5; 

~strings1.envelope.decays =  [16.0,15.94,16.0,15.94,7.94,8.0,4.0,4.0,4.0,4.0,7.94,4.0,4.0,4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.01,4.0,4.0,4.0,3.99,4.01,4.0,4.0,4.0,16.0,16.0,15.94,16.0,23.44] * 0.5; 
~strings1.envelope.init;
~strings1.filter.attack = 0.0;
~strings1.filter.release = 1.5;
~strings1.filter.cutoff = 8000;
~strings1.filter.gain = 1.0;
~strings1.filter.sustain = 1.0;
~strings1.filter.aoc = 1;
~strings1.envelope.attack = 0.55;
~strings1.envelope.release = 0.37;
~strings1.envelope.decay = 0.750;
~strings1.envelope.sustain = 0.0;



~strings2 = MyEvents.new;
~strings2.amp = 1.0;
~strings2.waits = [16.06,15.94,16.06,48.0,7.94,8.0,4.0,4.0,4.0,4.06,7.94,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,3.99,4.01,4.0,4.0,4.0,16.0,16.06,15.94,16.06,324.00]; 
~strings2.freqs = [65,60,65,60,58,60,55,57,55,53,58,60,57,58,57,55,53,58,62,60,58,60,53,55,53,57,53,57,60,58,55,58,53,55,58,62,60,53,60,57,60,58,65,60,65,60,58];
~strings2.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~strings2.durations = [16.0,15.94,16.0,15.94,7.94,8.0,4.0,4.0,4.0,4.0,7.94,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,3.99,4.01,4.0,4.0,4.0,16.0,16.0,15.94,16.0,23.44];

~strings2.init;

~strings2.envelope.attacks =  [16.0,15.94,16.0,15.94,7.94,8.0,4.0,4.0,4.0,4.0,7.94,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,3.99,4.01,4.0,4.0,4.0,16.0,16.0,15.94,16.0,23.44] * 0.5;

~strings2.envelope.decays =  [16.0,15.94,16.0,15.94,7.94,8.0,4.0,4.0,4.0,4.0,7.94,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,3.99,4.01,4.0,4.0,4.0,16.0,16.0,15.94,16.0,23.44] * 0.5;

~strings2.envelope.init;
~strings2.filter.attack = 0.0;
~strings2.filter.release = 1.5;
~strings2.filter.cutoff = 8000;
~strings2.filter.gain = 1.0;
~strings2.filter.sustain = 1.0;
~strings2.filter.aoc = 1;
~strings2.envelope.attack = 0.550;
~strings2.envelope.release = 0.35;
~strings2.envelope.decay = 0.750;
~strings2.envelope.sustain = 0.0;



~midiString1 = {Pbind(\type, \midi,
		      \midiout, ~synth1,
		      \midicmd, \noteOn,
		      \note,  Pfunc.new({~strings1.freq.next}- 60),
	//		      \amp, ~strings1.amp,
		      \chan, 2,
		      \sustain, Pfunc.new({~strings1.duration.next}),
		      \dur, Pfunc.new({~strings1.wait.next})
		      ).play};

~midiString2 = {Pbind(\type, \midi,
		      \midiout, ~synth1,
		      \midicmd, \noteOn,
		      \note,  Pfunc.new({~strings2.freq.next}- 60),
	//		      \amp, ~string2.amp,
		      \chan, 3,
		      \sustain, Pfunc.new({~strings2.duration.next}),
		      \dur, Pfunc.new({~strings2.wait.next})
		      ).play};





~channel2 = {arg num, vel = 1;
	     var ret;
	     vel.postln;
	     //   ~strings1.amp = ~strings1.amp * vel;
	     ret = ~midiStrings.value(~strings1,num,2);
	     ret;
};


~channel3 = {arg num, vel = 1;
	     var ret;
	     //num.postln;
	     //~strings2.amp = ~strings2.amp * vel;
	     ret = ~midiStrings.value(~strings2,num,3);
	     ret;
};

