// =====================================================================
// eStrings
// =====================================================================

SynthDef("eStrings",
	{
		arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,hpf = 120,
		attack = 0.5, decay = 2.0, sustain = 0.6, release = 0.6, fattack = 0.5, fsustain = 0.8,
		frelease = 0.6, aoc = 0.6, gain = 0.7, cutoff = 4200.00, bend = 0;

		var sig, env, fenv, env2;

		env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');


		//		env2  = Env.adsr(0.5,0.25,0.6,release,curve: 'welch');
		//		env2 = EnvGen.kr(env2, gate);
		freq = {freq * bend.midiratio * LFNoise2.kr(2.5,0.01,1)}!16;

		fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
		fenv = EnvGen.kr(fenv, gate);
		fenv = aoc*(fenv - 1) + 1;
		sig = (Saw.ar(freq,0.1));//*env2;

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
