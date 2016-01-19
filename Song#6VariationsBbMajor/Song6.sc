Help.gui
Quarks.gui
GUI.qt

(
 o = Server.local.options;
 o.numOutputBusChannels = 24; // The next time it boots, this will take effect
// o.memSize = 2097152;
 )

 "/home/dbalchen/Music/Song#6VariationsBbMajor/setup.sc".loadPath;



(

~allTimes= [0.5,0.25,0.25,0.5,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.5,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25]; 
~c12 = MyEvents.new;
~c12.waits = ~allTimes.deepCopy;
~c12.freqs = [54,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
~c12.probs = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
~c12.durations = [8.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
~c12.init;
~c12.amp = 1;

~c8 = MyEvents.new;
~c8.waits = ~allTimes.deepCopy;
~c8.freqs = [39,0,0,0,0,0,0,0,0,0,0,0,0,39,0,0,0,0,0,39,0,0,0,0,0,0];
~c8.probs = [1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0];
~c8.durations = [4.0,0,0,0,0,0,0,0,0,0,0,0,0,2.0,0,0,0,0,0,2.0,0,0,0,0,0,0];
~c8.init;
~c8.amp = 0.45;

~c5 = MyEvents.new;
~c5.waits = ~allTimes.deepCopy;
~c5.freqs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] *75;
~c5.probs = [1,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0];
~c5.durations = [2.0,0,0,0,0,0,1.0,0,0,1.0,0,0,0,2.0,0,0,0,0,0,1.0,0,0,1.0,0,0,0];
~c5.init;
~c5.amp = 0.45;

~c2 = MyEvents.new;
~c2.waits = ~allTimes.deepCopy;
~c2.freqs = [70,0,0,70,70,0,70,0,0,70,0,70,0,70,0,0,70,70,0,70,0,0,70,0,70,0] -30;
~c2.probs = [1,0,0,1,1,0,1,0,0,1,0,1,0,1,0,0,1,1,0,1,0,0,1,0,1,0] - ~c5.probs;
~c2.durations = [1.0,0,0,0.5,0.5,0,1.0,0,0,0.5,0,0.5,0,1.0,0,0,0.5,0.5,0,1.0,0,0,0.5,0,0.5,0];
~c2.init;
~c2.amp = 0.45;

~c1 = MyEvents.new;
~c1.waits = ~allTimes.deepCopy;
~c1.freqs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] *44;
~c1.probs = [1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] ;//- ~c5.probs - ~c3.probs - ~c7.probs; 
~c1.durations = [0.5,0.25,0.25,0.5,0.25,0.25,0.5,0.25,0.25,0.5,0,0.25,0.25,0.5,0.25,0.25,0.5,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25];
~c1.init;
~c1.amp = 0.45;

~c3 = MyEvents.new;
~c3.waits = ~allTimes.deepCopy;
~c3.freqs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] *61;
~c3.probs = [1,0,0,1,1,0,1,0,0,1,0,1,0,1,0,0,1,1,0,1,1,0,1,0,1,0] ;
~c3.durations = [1.0,0,0,0.5,0.5,0,1.0,0,0,0.5,0,0.5,0,1.0,0,0,0.5,0.5,0,0.5,0.5,0,0.5,0,0.5,0];
~c3.init;
~c3.amp = 0.45;

~c6 = MyEvents.new;
~c6.waits = ~allTimes.deepCopy;
~c6.freqs = [54,0,0,0,0,0,54,0,0,54,0,0,0,54,0,0,54,0,0,54,0,0,54,0,0,0];
~c6.probs = [1,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0];
~c6.durations = [2.0,0,0,0,0,0,1.0,0,0,1.0,0,0,0,1.0,0,0,1.0,0,0,1.0,0,0,1.0,0,0,0];
~c6.init;
~c6.amp = 0.45;

~c13 = MyEvents.new;
~c13.waits = ~allTimes.deepCopy;
~c13.freqs = [58,0,0,0,0,0,0,0,0,0,0,0,0,58,0,0,0,0,0,0,0,0,0,0,0,0];
~c13.probs = [1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0];
~c13.durations = [4.0,0,0,0,0,0,0,0,0,0,0,0,0,4.0,0,0,0,0,0,0,0,0,0,0,0,0];
~c13.init;
~c13.amp = 0.45;

~c4 = MyEvents.new;
~c4.waits = ~allTimes.deepCopy *2;
~c4.freqs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] * 61; 
~c4probs1 = [1,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0];
~c4probs2 = [0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,1,0];
~c4probs3 = [0,1,1,0,0,1,0,1,1,0,1,0,1,0,1,1,0,0,1,0,1,1,0,1,0,1];
~c4probs4 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];// - ~c6.probs;
~c4.probs = ~c4probs2 + ~c4probs3;
//~c4.probs = ~c4probs4;
~c4.durations = [0.5,0.25,0.25,0.5,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.5,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25];
~c4.init;
~c4.amp = 0.45;

~c7 = MyEvents.new;
~c7.waits = ~allTimes.deepCopy;
~c7.freqs = [59,0,0,59,59,0,59,59,0,59,0,59,0,59,0,0,59,59,0,59,59,0,59,0,59,0];
~c7.probs = [1,0,0,1,1,0,1,1,0,1,0,1,0,1,0,0,1,1,0,1,1,0,1,0,1,0];
~c7.durations = [1.0,0,0,0.5,0.5,0,0.5,0.5,0,0.5,0,0.5,0,1.0,0,0,0.5,0.5,0,0.5,0.5,0,0.5,0,0.5,0];
~c7.init;
~c7.amp = 0.45;

~c9 = MyEvents.new;
~c9.waits = ~allTimes.deepCopy;
~c9.freqs = [37,0,0,0,0,0,37,0,0,37,0,0,0,37,0,0,0,0,0,37,0,0,37,0,0,0];
~c9.probs = [1,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0];
~c9.durations = [2.0,0,0,0,0,0,1.0,0,0,1.0,0,0,0,2.0,0,0,0,0,0,1.0,0,0,1.0,0,0,0];
~c9.init;
~c9.amp = 0.45;

~c11 = MyEvents.new;
~c11.waits = ~allTimes.deepCopy;
~c11.freqs = [35,0,0,35,0,0,35,0,0,35,0,0,0,35,0,0,35,0,0,35,0,0,35,0,0,0];
~c11.probs = [1,0,0,1,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0];
~c11.durations = [1.0,0,0,1.0,0,0,1.0,0,0,1.0,0,0,0,1.0,0,0,1.0,0,0,1.0,0,0,1.0,0,0,0];
~c11.init;
~c11.amp = 0.45;


~clickPat = {Pbind(\type, \midi,
	       \midiout, ~synth1,
	       \midicmd, \noteOn,
	       \chan, 9,
	       \note,  Pfunc.new({~cc.freq.next}) - 60,   
	       \amp, Pfunc.new({~cc.amp}),
           \sustain, Pfunc.new({~cc.duration.next}),
	       \dur, Pfunc.new({~cc.wait.next})
	       ).play};


~clickPat2 = {Pbind(\type, \midi,
	       \midiout, ~synth1,
	       \midicmd, \noteOn,
	       \chan, 9,
	       \note,  Pfunc.new({~ccc.freq.next}) - 60,   
	       \amp, Pfunc.new({~ccc.amp}),
           \sustain, Pfunc.new({~ccc.duration.next}),
	       \dur, Pfunc.new({~ccc.wait.next})
	       ).play};
	
~clickPat3 = {Pbind(\type, \midi,
	       \midiout, ~synth1,
	       \midicmd, \noteOn,
	       \chan, 9,
	       \note,  Pfunc.new({~ccc4.freq.next}) - 60,   
	       \amp, Pfunc.new({~ccc4.amp}),
           \sustain, Pfunc.new({~ccc4.duration.next}),
	       \dur, Pfunc.new({~ccc4.wait.next})
	       ).play};	

~clickPat4 = {Pbind(\type, \midi,
	       \midiout, ~synth1,
	       \midicmd, \noteOn,
	       \chan, 9,
	       \note,  Pfunc.new({~ccc5.freq.next}) - 60,   
	       \amp, Pfunc.new({~ccc5.amp}),
           \sustain, Pfunc.new({~ccc5.duration.next}),
	       \dur, Pfunc.new({~ccc5.wait.next})
	       ).play};	


/*
~clickPat = {Pbind(
	       \note,  Pfunc.new({~click.freq.next}) - 60,   
	       \amp, Pfunc.new({~click.amp}),
           \sustain, Pfunc.new({~click.duration.next}),
		   \instrument, \Sawlead,
	       \dur, Pfunc.new({~click.wait.next})
	       ).play};
*/
)


~startTimer.value(160);

~cc = ~c11;
~ccc = ~c9;
~ccc4 = ~c4;
~ccc5 = ~c8;
~rp = {~clickPat.value;~clickPat2.value;~clickPat3.value;};
~rp = {~clickPat.value;};
~rp = {~clickPat2.value;};
~rp = {~clickPat3.value;};
~rp = {~clickPat4.value;};

