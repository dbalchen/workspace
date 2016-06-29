~bassdrum = MyEvents.new;
~bassdrum.waits = [1.0,1.0,1.0,1.0];
~bassdrum.freqs = [35,35,35,35];
~bassdrum.probs = [1,1,1,1];
~bassdrum.durations = [1.0,1.0,1.0,1.0] * 1;
~bassdrum.amp = 2;
~bassdrum.init;

~midiBassDrum = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~bassdrum.freq.next}- 60),
	\amp, ~bassdrum.amp,
	\chan, 9,
	\sustain, Pfunc.new({~bassdrum.duration.next}),
	\dur, Pfunc.new({~bassdrum.wait.next})
).play};

~cantus_firmus = MyEvents.new;
~cantus_firmus.waits = [8.0,4.0,4.0,8.0,4.0,4.0];
~cantus_firmus.freqs = [65,63,67,65,63,60] + 12;
~cantus_firmus.probs = [1,1,1,1,1,1];
~cantus_firmus.durations = [8.0,4.0,4.0,8.0,4.0,4.0];
~cantus_firmus.amp =1;
~cantus_firmus.init;

~midiCantus_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~cantus_firmus.freq.next}- 60),
	\amp, ~cantus_firmus.amp,
	\chan, 8,
	\sustain, Pfunc.new({~cantus_firmus.duration.next}),
	\dur, Pfunc.new({~cantus_firmus.wait.next})
).play};



/*
~string1_firmus = MyEvents.new;
~string1_firmus.waits = [8.0,4.0,4.0,8.0,4.0,4.0];
~string1_firmus.freqs = [65,63,67,65,63,60] + 12;
~string1_firmus.probs = [1,1,1,1,1,1];
~string1_firmus.durations = [8.0,4.0,4.0,8.0,4.0,4.0];
~string1_firmus.amp =1;
~string1_firmus.init;
*/

~string1_firmus = ~cantus_firmus.deepCopy;
~string1_firmus.init;

~midistring1_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string1_firmus.freq.next}- 60),
	\amp, ~string1_firmus.amp,
	\chan, 6,
	\sustain, Pfunc.new({~string1_firmus.duration.next}),
	\dur, Pfunc.new({~string1_firmus.wait.next})
).play};

/*
~sinedrum = MyEvents.new;
~sinedrum.waits = [1.0,1.0,1.0,1.0];
~sinedrum.freqs = [35,35,35,35];
~sinedrum.probs = [1,1,1,1];
~sinedrum.durations = [1.0,1.0,1.0,1.0] * 1;
~sinedrum.amp = 2;
~sinedrum.init;
*/

~sinedrum = ~bassdrum.deepCopy;
~sinedrum.init;

~midiSineDrum = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~sinedrum.freq.next}- 60),
	\amp, ~sinedrum.amp,
	\chan, 7,
	\sustain, Pfunc.new({~sinedrum.duration.next}),
	\dur, Pfunc.new({~sinedrum.wait.next})
).play};


