SynthDef(\myASR,{arg out = 0, attack = 0.5, sustain = 0.8, release = 0.5, gate = 0, da = 2;
	var sig;

	sig = Env.asr(attack,sustain,release);
	sig = EnvGen.kr(sig,gate,doneAction:da);
	Out.kr(out,sig)}).add;


SynthDef(\myADSR,{arg out = 0, attack = 0.5, decay = 2.0, sustain = 0.6, release = 0.5, gate = 0,da = 2;
	var sig;
	sig = Env.adsr(attack,decay,sustain,release,curve: -4);
	sig = EnvGen.kr(sig,gate,doneAction:da);
	Out.kr(out,sig)}).add;



