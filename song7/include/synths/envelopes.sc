SynthDef(\zeroRate,{arg out = 0;
	Out.ar(out, 0);}).add;


SynthDef(\iRate,{arg out = 0;
	Out.kr(out, 1);}).add;

SynthDef(\iRate0,{arg out = 0;
	Out.kr(out, 0);}).add;


SynthDef(\env0, {arg out=0,r1 = 0.5,r2 = 1, r3 = 0.5, r4 = 0, r5 = 0,gate = 0;
	var sig;
	sig = EnvGen.ar(
		Env.new([r1, r2, r3, r4, r5], [0.005, 0.06, 0.26, 0.1], [-4, -2, -4, -1],4)
		,gate,doneAction:2);

	Out.ar(out, sig);}).add;



SynthDef(\env0, {arg out=0,gate = 0;
	var sig;
	sig = EnvGen.ar(
		Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, 0.26], [-4, -2, -4])
		,gate,doneAction:2);

	Out.ar(out, sig);}).add;


SynthDef(\env1, {arg out=0,gate = 0;
	var sig;
	sig = EnvGen.ar(
		Env.new([110, 59, 29], [0.005, 0.1], [-4, -5])
		,gate,doneAction:2);

	//	sig = sig.midicps;
	Out.ar(out,sig);}).add;