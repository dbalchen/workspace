SynthDef("cStrings",
	{
		arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,hpf = 240,
		attack = 4, decay = 4, sustain = 0, release = 0.5, fattack = 0.0, fsustain = 1,
		frelease = 0.05, aoc = 0, gain = 1, cutoff = 10000.00, bend = 0;

		var sig, env, fenv, env2;

		env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');


		env2  = Env.adsr(0.5,0.25,0.6,release,curve: 'welch');
		env2 = EnvGen.kr(env2, gate);
		freq = {freq * bend.midiratio * LFNoise2.kr(2.5,0.01,1)}!5;

		fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
		fenv = EnvGen.kr(fenv, gate);
        fenv = aoc*(fenv - 1) + 1;
		sig = (LFSaw.ar(freq,0,0.1))*env2;

		sig = sig*EnvGen.kr(env, gate: gate,doneAction:da);
		sig = MoogFF.ar
		(
			sig,
			cutoff*fenv,
			gain
		);

		sig = HPF.ar(sig,hpf);
		sig = Splay.ar(sig);

		Out.ar(out,amp*sig);

}).send(s);


~midicStrings = {arg myevents,num,chan;
	var flt, env,amp,tt;
	amp = myevents.amp;
	flt = myevents.filter;
	env = myevents.envelope;

	if(num.isMemberOf(Integer),
		{
			tt = Synth("cStrings");
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



SynthDef("eStrings",
	{
		arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,hpf = 120,
		attack = 1, decay = 1, sustain = 0, release = 0.5, fattack = 0.0, fsustain = 0,
		frelease = 0.05, aoc = 0, gain = 1, cutoff = 10000.00, bend = 0;

		var sig, env, fenv, env2;

		env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');


		env2  = Env.adsr(0.5,0.25,0.6,release,curve: 'welch');
		env2 = EnvGen.kr(env2, gate);
		freq = {freq * bend.midiratio * LFNoise2.kr(2.5,0.01,1)}!16;

		fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
		fenv = EnvGen.kr(fenv, gate);
        fenv = aoc*(fenv - 1) + 1;
		sig = (Saw.ar(freq,0.1))*env2;

		sig = sig*EnvGen.kr(env, gate: gate,doneAction:da);
		sig = MoogFF.ar
		(
			sig,
			cutoff*fenv,
			gain
		);

		sig = HPF.ar(sig,hpf);
		sig = Splay.ar(sig);

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



SynthDef("dStrings",
	{
		arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,hpf = 120,
		attack = 1, decay = 0, sustain = 0, release = 0.5, fattack = 0.0, fsustain = 0.5,
		frelease = 0.05, aoc = 0, gain = 1, cutoff = 10000.00, bend = 0;

		var sig, env, fenv, env2;

		env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');


		//	env2  = Env.adsr(0.5,0.25,0.6,release,curve: 'welch');
		//	env2 = EnvGen.kr(env2, gate);
		freq = {freq * bend.midiratio * LFNoise2.kr(2.5,0.01,1)}!16;

		fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
		fenv = EnvGen.kr(fenv, gate);
        fenv = aoc*(fenv - 1) + 1;
		sig = (LFSaw.ar(freq,0,0.1));//*env2;
		//sig = (Saw.ar(freq,0.1));
		sig = sig*EnvGen.kr(env, gate: gate,doneAction:da);
		sig = MoogFF.ar
		(
			sig,
			cutoff*fenv,
			gain
		);

		sig = HPF.ar(sig,hpf);
		sig = Splay.ar(sig);

		Out.ar(out,amp*sig);

}).send(s);


~mididStrings = {arg myevents,num,chan;
	var flt, env,amp,tt;
	amp = myevents.amp;
	flt = myevents.filter;
	env = myevents.envelope;

	if(num.isMemberOf(Integer),
	{
			tt = Synth("dStrings");
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