~sinedrum = ~bassdrum.deepCopy;
~sinedrum.amp = 0.6;
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


~pSineDrum = {Pbind(
	\note,  Pfunc.new({~sinedrum.freq.next}- 60),
	\sustain, Pfunc.new({~sinedrum.duration.next}),
	\instrument, "Sine",
	\addAction, 0,
	\amp, ~sinedrum.amp,
	\out, ~sine1Out,
	\dur, Pfunc.new({~sinedrum.wait.next})
).play};



~belldrum = ~bassdrum.deepCopy;
~belldrum.waits = ~bassdrum.waits * 1;
~belldrum.durations = ~bassdrum.durations * 1;
~belldrum.waits = ~bassdrum.waits * 16;
~belldrum.durations = ~bassdrum.durations * 16;
~belldrum.init;


~pitch = 87.3070578583;

~midiBellDrum = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~belldrum.freq.next}- 60),
	\amp, ~belldrum.amp,
	\chan, 7,
	\sustain, Pfunc.new({~belldrum.duration.next}),
	\dur, Pfunc.new({~belldrum.wait.next})
).play};

~pBell = {Pbind(
	\amp, ~belldrum.amp,
	\sustain, Pfunc.new({~belldrum.duration.next}),
	\instrument, "tbell",
	\addAction, 0,
	\freq,220,//~pitch,
	\decayscale,~dcs,
	\fscale,~fscale,
	\release,~release,
	\attack,~attack,
	\out,0,//~bellOut,
	\dur, Pfunc.new({~belldrum.wait.next})
).play};

~tBell = {
	var myTask;
	s.sync;
	myTask = Task({
		var ret;
		inf.do({
			{
				ret = Synth("tbell",addAction: \addToHead);
				ret.set(\freq,~pitch);
				ret.set(\decayscale,~dcs);
				ret.set(\fscale,~fscale);
				ret.set(\release,~release);
				ret.set(\attack,~attack);
				ret.set(\amp,~amp);
				ret.set(\out,~bellOut);
				ret.set(\gate,1);
				~belldrum.duration.next.wait;
				ret.set(\gate,0);
			}.fork;
			~belldrum.wait.next.wait;

		});
}).start};