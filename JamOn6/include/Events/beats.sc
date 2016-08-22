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


~adsr = ~bassdrum.deepCopy;
~adsr.init;

~midiAdsr = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~adsr.freq.next}- 60),
	\amp, ~adsr.amp,
	\chan, 4,
	\sustain, Pfunc.new({~adsr.duration.next}),
	\dur, Pfunc.new({~adsr.wait.next})
).play};



~env0 = ~bassdrum.deepCopy;
~env0.init;

~env1 = ~bassdrum.deepCopy;
~env1.init;

~pad_firmus = MyEvents.new;
~pad_firmus.init;

