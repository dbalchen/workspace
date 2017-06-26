// =====================================================================
// FM Piano
// =====================================================================

SynthDef(\FMPiano, {arg out = 0, freq = 440, gate = 1, duration = 2, da = 2, amp = 1.0;
	var op1,op2,op3,op4,op5,op6,env,env1,env2,env3,env4,env5,env6,sig;

	env1 = Env.adsr(0.0008,1.0,0,0);
	env2 = Env.adsr(0,duration,0,0);

	op2 = 0.58*SinOsc.ar(freq*12,0,
		EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

	op1 = SinOsc.ar(freq/(2**(7/1200)),op2,
		EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

	op4 = 0.89*SinOsc.ar(freq,0,
		EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

	op3 = SinOsc.ar(freq,op4,
		EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););


	op6 = 0.79*SinOscFB.ar(freq*(2**(4/1200)),0.40,
		EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

	op5 = SinOsc.ar(freq*(2**(7/1200)),op6,
		EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

	sig = ((0.10*op5) + (0.12*op3) + (0.10*op1)) * amp;

	sig = Splay.ar(sig);

	Out.ar(out,sig)}).store;
