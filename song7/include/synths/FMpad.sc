// =====================================================================
// FM Dark Pad
// =====================================================================

SynthDef("FMdarkpad", {arg freq = 58.6, gate = 0, cutoff = 5000, gain = 0.35,spread = 1, balance = 0,amp = 0.25;

	var op1,op2,op3,op4,op5,op6,
	env1,env2,env3,env4,env5,env6,
	sig;

	freq = {freq * LFNoise2.kr(1,0.01,1) }!4;

	op1 = (freq *  4.0) ;
	op2 = (freq *  8.0) ;
	op3 = (freq *  2) ;
	op4 = (freq);
	op5 = (freq *  1.00) ;
	op6 = (freq *  2) ;

	env1 = Env.new([0,1,1,0], [2.0,2,2],-1,loopNode: 1);
	env2 = Env.adsr(8,0,1,2,curve: 3);
	env3 = Env.adsr(4.5,0,1,2,curve: 1);
	env4 = Env.new([0,1,1,0], [0.5,1, 3.5],0);
	env5 = Env.adsr(1.0,0.2,0.99,2,curve: 1);
	env6 = Env.new([0,1,1,0], [0.4,0.6, 3.5],0);


	env1 = EnvGen.kr(env1, gate: gate ,doneAction:0);
	env2 = EnvGen.kr(env2, gate: gate ,doneAction:2);
	env3 = EnvGen.kr(env3, gate: gate ,doneAction:2);
	env4 = EnvGen.kr(env4, gate: gate ,doneAction:0);
	env6 = EnvGen.kr(env6, gate: gate ,doneAction:0);
	env5 = EnvGen.kr(env5, gate: gate ,doneAction:2);


	op6 = 0.7*SinOsc.ar(op6,0,env6);
	op5 = 0.6*SinOsc.ar(op5,0.12 *op6,env5);
	op4 = 0.6*SinOsc.ar(op4,0.07 *op5,env4);
	op3 = 0.4*SinOsc.ar(op3,0.04 *op4,env3);
	op2 = 0.4*SinOsc.ar(op2,0.13 *op3,env2);
	op1 = SinOsc.ar(op1,0.08 *op3,env1);


	op2 = MoogFF.ar
	(
		op2,
		3500,
		0.5
	);

	sig = (0.79*op5) + (0.78*op3) + (0.56*op1);

	sig = MoogFF.ar
	(
		sig,
		cutoff,
		gain
	);

	sig = op6 + op5 + op4 + op3 + op2 + op1 + (0.69 *sig);

	sig = Splay.ar(amp*0.075*sig,spread,center:balance);

	Out.ar(0,sig)
}).store;
