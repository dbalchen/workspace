// =====================================================================
// eStrings
// =====================================================================

SynthDef("eStrings",
	{
		arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,hpf = 120,
		attack = 0.5, decay = 2.0, sustain = 0.6, release = 0.6, fattack = 0.5, fsustain = 0.8,
		frelease = 0.6, aoc = 0.6, cutoff = 5200.00, bend = 0, spread = 1, balance = 0;

		var sig, env, fenv, env2;

		env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');

		freq = {freq * bend.midiratio * LFNoise2.kr(2.5,0.01,1)}!16;

		fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
		fenv = EnvGen.kr(fenv, gate);
		fenv = aoc*(fenv - 1) + 1;
		sig = (Saw.ar(freq));

		sig = sig*EnvGen.kr(env, gate: gate,doneAction:da);

		sig = LPF.ar
		(
			sig,
			cutoff*fenv,
		);

		sig = HPF.ar(sig,hpf);

		sig = LeakDC.ar(sig);

		sig = Splay.ar(sig,spread,center:balance);

		Out.ar(out,amp*sig);

}).send(s);


SynthDef(\mono_eStrings, {arg freq = 110, out = 0, amp = 0.5, aoc = 1.0,fenvIn = 999, vcaIn = 999,cutoff = 7200, gain = 0.7, bend =0,hpf = 120, mul = 1,lagtime =0, spread = 1, balance = 0;

	var sig,fenv;

	freq = {freq * bend.midiratio * LFNoise2.kr(2.5,0.01,1)}!16;
	sig = (Saw.ar(Lag.kr(freq,lagtime)));

	fenv = In.kr(fenvIn);
	fenv = aoc*((fenv - 1) + 1);

	sig = LPF.ar
	(
		sig,
		cutoff*fenv,
	);

	sig = HPF.ar(sig,hpf);
	sig = sig*((In.kr(vcaIn) - 1) + 1);

	sig = LeakDC.ar(sig);
	sig = Splay.ar(sig,spread,center:balance);
	Out.ar(out,amp*sig);

}
).add;

/*

// Run eStrings;

~sy = Synth("eStrings",addAction: \addToTail);
~sy.set(\gate,1);
~sy.set(\gate,0);

// Run mono_eStrings

~kc = Bus.control(s, 1);
~kd = Bus.control(s, 1);

~sy = Synth("mono_eStrings",addAction: \addToTail);
~sy.set(\fenvIn,~kd);
~sy.set(\vcaIn,~kc);

~env  = Synth("myADSR",addAction: \addToHead);
~env.set(\out,~kc);

~fenv = Synth("myASR",addAction: \addToHead);
~fenv.set(\out,~kd);



~env.set(\gate,1);
~fenv.set(\gate,1);

~env.set(\gate,0);
~fenv.set(\gate,0);



*/