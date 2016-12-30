"/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;

~string1_firmus = ~cf_clock.deepCopy;
~string1_firmus.filter = 1;
~string1_firmus.envelope = 1;
~string1_firmus.waits = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
~string1_firmus.freqs = [53,54,53,48,53,51,46,48,51,53,54,53,48,53,51,48,53,48,51];
~string1_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~string1_firmus.durations = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
~string1_firmus.init;
~string1_firmus.amp = 9.5;
~string1_firmus.envelope.attack = 1.0;
~string1_firmus.envelope.attacks = [6.0,0.5,6.0,0.5,4.0,0.5,0.5,6.0,0.5,6.0,0.5,4.0,0.5,0.5,4.0,4.0,4.0,0.5,0.5]* 0.5;
~string1_firmus.envelope.decay = 1.0;
~string1_firmus.envelope.sustain = 0.250;
~string1_firmus.envelope.release = 0.6;
~string1_firmus.envelope.init;
~string1_firmus.filter.cutoff = 980.00;
~string1_firmus.filter.gain = 0.70;
~string1_firmus.filter.attack = 1.25;
~string1_firmus.filter.aoc = 0.7;
~string1_firmus.filter.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~string1_firmus.filter.release = 0.9;
~string1_firmus.filter.init;
~midistring1_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string1_firmus.freq.next}- 60),
	\amp, ~string1_firmus.amp,
	\chan, 1,
	\sustain, Pfunc.new({~string1_firmus.duration.next}),
	\dur, Pfunc.new({~string1_firmus.wait.next})
).play};

~string1_firmusB = ~string1_firmus.deepCopy;
~string1_firmusB.filter.cutoff = 8800.00;
~string1_firmusB.filter.aoc = 0;
~string1_firmusB.amp = 0.0;

~string1_firmusB.envelope.sustain = 1.0;

~string2_firmus = ~cf_clock.deepCopy;
~string2_firmus.filter = 1;
~string2_firmus.envelope = 1;
~string2_firmus.waits = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
~string2_firmus.freqs = [65,63,58,60,63,62,60,63,56,58,62,60,65,63,58,60,63,65,67,63,60,63,65,63];
~string2_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~string2_firmus.durations = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
~string2_firmus.amp = 1.70;
~string2_firmus.init;
~string2_firmus.envelope.attack = 0.95;
~string2_firmus.envelope.attacks = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0] * 0.50;
~string2_firmus.envelope.decay = 0.95;
~string2_firmus.envelope.decays = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0] * 0.50;
~string2_firmus.envelope.sustain = 0.6;
~string2_firmus.envelope.release = 0.6;
~string2_firmus.envelope.init;
~string2_firmus.filter.init;
~string2_firmus.filter.cutoff = 3000.00;
~string2_firmus.filter.gain = 0.5;
~string2_firmus.filter.attack = 0.25;
~string2_firmus.filter.release = 0.65;

~midistring2_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string2_firmus.freq.next}- 60),
	\amp, ~string2_firmus.amp,
	\chan, 2,
	\sustain, Pfunc.new({~string2_firmus.duration.next}),
	\dur, Pfunc.new({~string2_firmus.wait.next})
).play};

~string2_firmusB = ~string2_firmus.deepCopy;
~string2_firmusB.filter.cutoff = 10800.00;
~string2_firmusB.amp = 0.3;
~string2_firmusB.envelope.sustain = 1.0;


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
