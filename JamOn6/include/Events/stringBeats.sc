"/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;

~string1_firmus = ~cf_clock.deepCopy;
~string1_firmus.filter = 1;
~string1_firmus.envelope = 1;
~string1_firmus.freqs = ~string1_firmus.freqs - 12;
~string1_firmus.init;
~string1_firmus.envelope.attack = 1.5;
~string1_firmus.envelope.decay = 3.8;
~string1_firmus.envelope.sustain = 0.1;
~string1_firmus.envelope.release = 0.5;
~string1_firmus.envelope.init;
~string1_firmus.filter.init;
~string1_firmus.filter.cutoff = 2800.00;
~string1_firmus.filter.gain = 1.5;
~string1_firmus.filter.attack = 0.25;
~string1_firmus.filter.release = 1.0;

~midistring1_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string1_firmus.freq.next}- 60),
	\amp, ~string1_firmus.amp,
	\chan, 1,
	\sustain, Pfunc.new({~string1_firmus.duration.next}),
	\dur, Pfunc.new({~string1_firmus.wait.next})
).play};


~string2_firmus = ~cf_clock.deepCopy;
~string2_firmus.filter = 1;
~string2_firmus.envelope = 1;
~p0 = Prand(([5,2,0,10] + 60),inf).asStream.next;
~p1 = Prand(([3,0,10,8] + 60),inf).asStream.next;
~p2 = Prand(([7,4,2.0] + 60),inf).asStream.next;
~p3 = Prand(([5,2,0,10] + 60),inf).asStream.next;
~p4 = Prand(([3,0,10,8] + 60),inf).asStream.next;
~p5 = Prand(([0,9,7,5] + 60),inf).asStream.next;

~string2_firmus.freqs = [~p0,~p1,~p2,~p3,~p4,~p5];

~string2_firmus.freqs = [65,68,72,65,68,63];

~string2_firmus.freqs = [53,51,55,53,51,48];
~string2_firmus.freqs = [62,60,64,62,60,57];
~string2_firmus.freqs = [72,70,74,72,70,67];
~string2_firmus.freqs = [82,80,84,82,80,77] -12;
/*
~string2_firmus.freqs =  [ 70, 63, 62, 65, 60, 65 ];
~string2_firmus.freqs =  [ 62, 63, 67, 70, 68, 65 ];
~string2_firmus.freqs = [ 65, 63, 64, 65, 63, 60 ];

~string2_firmus.freqs =  [ 65, 70, 67, 65, 63, 67];
~string2_firmus.freqs = [ 65, 63, 67, 65, 63, 60 ];
~string2_firmus.freqs = [ 65, 66, 70, 60, 63, 60 ];
~string2_firmus.freqs = [ 68, 66, 70, 68, 66, 67 ];
~string2_firmus.freqs = [ 68, 70, 67, 68, 66, 67 ];
~string2_firmus.freqs = [ 70, 68, 67, 68, 68, 67 ];
~string2_firmus.freqs = [ 60, 63, 67, 60, 63, 60 ];
*/

~string2_firmus.init;
~string2_firmus.envelope.attack = 2.0;
~string2_firmus.envelope.decay = 2.0;
~string2_firmus.envelope.sustain = 0.0;
~string2_firmus.envelope.release = 0.3;
~string2_firmus.envelope.init;
~string2_firmus.filter.init;
~string2_firmus.filter.cutoff = 3800.00;
~string2_firmus.filter.gain = 1.5;
~string2_firmus.filter.attack = 0.45;
~string2_firmus.filter.release = 1.2;

~midistring2_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string2_firmus.freq.next}- 60),
	\amp, ~string2_firmus.amp,
	\chan, 2,
	\sustain, Pfunc.new({~string2_firmus.duration.next}),
	\dur, Pfunc.new({~string2_firmus.wait.next})
).play};



~pad_firmus = ~cf_clock.deepCopy;
~pad_firmus.freqs = ~pad_firmus.freqs + 12;
~pad_firmus.init;

~midipad_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~pad_firmus.freq.next}- 60),
	\amp, ~pad_firmus.amp,
	\chan, 0,
	\sustain, Pfunc.new({~pad_firmus.duration.next}),
	\dur, Pfunc.new({~pad_firmus.wait.next})
).play};