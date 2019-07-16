~string4_firmus = nil;
~string4_firmus = nil;
~midistring4_firmus = nil;

~string4_firmus = ~cf_clock.deepCopy;
~string4_firmus.filter = 1;
~string4_firmus.envelope = 1;
~string4_firmus.init;
~string4_firmus.envelope.init;
~string4_firmus.amp = 2.0;
~string4_firmus.filter.cutoff = 9800.00;
~string4_firmus.filter.aoc = 0.0;


~midistring4_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string4_firmus.freq.next}- 60),
	\amp, ~string4_firmus.amp,
	\chan, 0,
	\sustain, Pfunc.new({~string4_firmus.duration.next}),
	\dur, Pfunc.new({~string4_firmus.wait.next})
).play};