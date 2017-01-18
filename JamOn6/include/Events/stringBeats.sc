"/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;



~string3_firmus = ~cf_clock.deepCopy;
~string3_firmus.amp = 1.4;
~string3_firmus.filter = 1;
~string3_firmus.envelope = 1;
~string3_firmus.waits = [24.0,4.0,2.0,2.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,4.0,2.0,1.0,1.0];
~string3_firmus.freqs = [0,70,74,72,69,70,72,75,77,79,75,72,75,72,72,70,72];
~string3_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~string3_firmus.durations = [1.0,4.0,2.0,2.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,4.0,2.0,1.0,1.0];
~string3_firmus.init;
~string3_firmus.envelope.attack = 1.0;
~string3_firmus.envelope.decay = 0.75;
~string3_firmus.envelope.release = 0.3;
~string3_firmus.envelope.init;
~string3_firmus.filter.init;
~string1_firmus.filter.aoc = 0.5;
~string3_firmus.filter.cutoff = 6200.00;
~string3_firmus.filter.gain = 0.5;
~string3_firmus.filter.attack = 0.025;
//~string3_firmus.filter.sustain = 1.00;
~string3_firmus.filter.release = 0.9;

~midistring3_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string3_firmus.freq.next}- 60),
	\amp, ~string3_firmus.amp,
	\chan, 3,
	\sustain, Pfunc.new({~string3_firmus.duration.next}),
	\dur, Pfunc.new({~string3_firmus.wait.next})
).play};

~string3_firmusB = ~string3_firmus.deepCopy;
~string3_firmusB.filter.cutoff = 8800.00;
~string3_firmusB.amp = 0.15;
~string3_firmusB.envelope.sustain = 1.0;
~string3_firmusB.envelope.release = 0.6;
