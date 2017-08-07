SynthDef(\Esampler, {arg bufnum = 0, out = 0, amp = 0.5, da = 2, gate = 0, rate = 1.0, midi = 60, basef = 60,
	attack = 0, decay = 0, sustain = 1, release = 0.5, fattack = 0.0, fsustain = 1, frelease = 0.5, aoc = 0, gain = 2, cutoff = 7500.00, balance = 0, spread = 1;

	var sig, env, fenv,i;

	i = midi.midicps/basef.midicps;

	env  = Env.adsr(attack,decay,sustain,release);
	env = EnvGen.kr(env, gate: gate, doneAction:da);
	fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
	fenv = EnvGen.kr(fenv, gate,doneAction:da);
	fenv = aoc*(fenv - 1) + 1;
	sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate*i,gate,0,0, doneAction:da)*2;

	sig = MoogFF.ar
	(
		sig,
		cutoff*fenv,
		gain
	);

	sig = sig * amp;
	sig = sig * env;

	sig = Splay.ar(sig,spread,center:balance);
	Out.ar(out,sig);

}).store;
