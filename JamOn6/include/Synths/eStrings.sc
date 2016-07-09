SynthDef("eStrings",
	{
		arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,
		attack = 4, decay = 4, sustain = 0, release = 0.5, fattack = 0.0, fsustain = 1,
		frelease = 0.05, aoc = 0, gain = 1, cutoff = 10000.00, bend = 0;

		var sig, env, fenv;

		env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');

		freq = {freq * bend.midiratio * LFNoise2.kr(2.5,0.01,1)}!16;

		fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
		fenv = EnvGen.kr(fenv, gate);

		sig = (LFSaw.ar(freq,0,0.1));

		sig = Splay.ar(sig);
		sig = sig*EnvGen.kr(env, gate: gate,doneAction:da);
		sig = MoogFF.ar
		(
			sig,
			cutoff*fenv,
			gain
		);


		Out.ar(out,amp*sig);

}).send(s);


~midiStrings = {arg myevents,num,chan;
	var flt, env,amp,tt;
	amp = myevents.amp;
	flt = myevents.filter;
	env = myevents.envelope;

	if(num.isMemberOf(Integer),
		{
			tt = Synth("eStrings");
			tt.set(\gate,0);
			flt.setFilter(tt);
			env.setEnvelope(tt);
			tt.set(\freq,num.midicps);
			tt.set(\da,2);
			tt.set(\amp,amp);
			tt.set(\gate,1);
			tt.set(\out,myevents.out);
			tt.set(\bend, ~bend[chan]);
	}, {["rest"].post}); // false action

	tt;
};