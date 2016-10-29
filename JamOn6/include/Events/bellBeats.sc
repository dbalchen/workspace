~sinedrum = ~clock.deepCopy;
~sinedrum.amp = 0.0;
~sinedrum.init;

~midiSineDrum = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~sinedrum.freq.next}- 60),
	\amp, ~sinedrum.amp,
	\chan, 5,
	\sustain, Pfunc.new({~sinedrum.duration.next}),
	\dur, Pfunc.new({~sinedrum.wait.next})
).play};



~belldrum = MyEvents.new;

~belldrum.waits = [16.0,16.0];
~belldrum.freqs = [53,53] - 0;
~belldrum.probs = [1,1];
~belldrum.durations = [16.0,16.0];
~belldrum.init;

~pitch = 87.3070578583;

~midiBellDrum = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~belldrum.freq.next}- 60),
	\amp, ~belldrum.amp,
	\chan, 3,
	\sustain, Pfunc.new({~belldrum.duration.next}),
	\dur, Pfunc.new({~belldrum.wait.next})
).play};
