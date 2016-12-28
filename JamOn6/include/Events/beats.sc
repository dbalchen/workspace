~clock = MyEvents.new;
~clock.waits = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0];
~clock.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~clock.amp = 2;
~clock.init;

~midiClock = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~clock.freq.next}- 60),
	\amp, ~clock.amp,
	\chan, 9,
	\sustain, Pfunc.new({~clock.duration.next}),
	\dur, Pfunc.new({~clock.wait.next})
).play};

~cf_clock = MyEvents.new;
~cf_clock.waits = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
~cf_clock.freqs = [53,54,53,48,53,51,46,48,51,53,54,53,48,53,51,48,53,48,51] + 12;
~cf_clock.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cf_clock.amp = 1;
~cf_clock.init;

~midicf_clock = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~cf_clock.freq.next}- 60),
	\amp, ~cf_clock.amp,
	\chan, 10,
	\sustain, Pfunc.new({~cf_clock.duration.next}),
	\dur, Pfunc.new({~cf_clock.wait.next})
).play};

~cf_clock2 = ~cf_clock.deepCopy;
~cf_clock2.waits = (~cf_clock.waits ++ ~cf_clock.waits) * 0.5;
~cf_clock2.freqs = ~cf_clock.freqs ++ ~cf_clock.freqs;
~cf_clock2.probs = ~cf_clock.probs ++ ~cf_clock.probs;
~cf_clock2.durations = nil;
~cf_clock2.amp = 1;
~cf_clock2.init;

~midicf2_clock = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~cf2_clock.freq.next}- 60),
	\amp, ~cf2_clock.amp,
	\chan, 11,
	\sustain, Pfunc.new({~cf2_clock.duration.next}),
	\dur, Pfunc.new({~cf2_clock.wait.next})
).play};

~cf_clock3 = ~cf_clock2.deepCopy;
~cf_clock3.waits = (~cf_clock2.waits ++ ~cf_clock2.waits)  * 0.5;
~cf_clock3.freqs = ~cf_clock2.freqs ++ ~cf_clock2.freqs;
~cf_clock3.probs = ~cf_clock2.probs ++ ~cf_clock2.probs;
~cf_clock3.amp = 1;
~cf_clock3.init;

~cf_clock4 = ~cf_clock3.deepCopy;
~cf_clock4.waits = (~cf_clock3.waits ++ ~cf_clock3.waits) * 0.5;
~cf_clock4.freqs = ~cf_clock3.freqs ++ ~cf_clock3.freqs;
~cf_clock2.durations = nil;
~cf_clock2.probs = nil;
~cf_clock4.amp = 1;
~cf_clock4.init;

~cf_clock8 = ~cf_clock4.deepCopy;
~cf_clock8.waits = (~cf_clock4.waits ++ ~cf_clock4.waits) * 0.5;
~cf_clock8.freqs = ~cf_clock4.freqs ++ ~cf_clock4.freqs;
~cf_clock2.durations = nil;
~cf_clock2.probs = nil;
~cf_clock8.amp = 1;
~cf_clock8.init;

~midicf8_clock = {Pbind(\type, \midi,
	\midiout, ~synth1,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~cf8_clock.freq.next}- 60),
	\amp, ~cf8_clock.amp,
	\chan, 10,
	\sustain, Pfunc.new({~cf8_clock.duration.next}),
	\dur, Pfunc.new({~cf8_clock.wait.next})
).play};