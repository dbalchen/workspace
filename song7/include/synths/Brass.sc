// =====================================================================
// Sad Saxaphone
// =====================================================================

(
SynthDef("brass",
	{
		arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,hpf = 220,
		attack = 0.5, decay = 2.0, sustain = 0.6, release = 0.6,
		fattack = 0.5,fdecay = 0.5, fsustain = 0.8,
		frelease = 0.6, aoc = 0.9, gain = 0.7, cutoff = 5200.00,
		bend = 0, spread = 1, balance = 0;

		var env, fenv, op1, op2, fb1, fb2,
		sig;

		env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');
		fenv = Env.adsr(fattack,fdecay,fsustain,frelease,1,'sine');
		fenv = EnvGen.kr(fenv, gate);
		fenv = aoc*(fenv - 1) + 1;

		env = EnvGen.kr(env, gate: gate,doneAction:da);


		fb2 = FbNode(1);
		op2 = 0.7*SinOsc.ar(freq*1.0,fb2, mul: env);
		fb2.write((0.47*Saw.ar(freq)) + op2);


		fb1 = FbNode(1);
		op1 = 0.95*SinOsc.ar(freq*1,(fb1) + (op2), mul: env);
		fb1.write((0.01*Saw.ar(freq)) + op1);

		sig = MoogFF.ar
		(
			op1,
			cutoff*fenv,
			gain
		);

		sig = HPF.ar(sig,hpf);

		sig = FreeVerb.ar(sig,0.33); // fan out...

		sig = Splay.ar(sig,spread,center:balance);

		Out.ar(out,amp*sig);

}).send(s);

)
/*
(

SynthDef("brass2",
{
arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,hpf = 120,
attack = 0.5, decay = 2.0, sustain = 0.6, release = 0.6,
fattack = 0.5,fdecay = 0.5, fsustain = 0.8,
frelease = 0.6, aoc = 0.5, gain = 0.7, cutoff = 1200.00, bend = 0, spread = 1, balance = 0;

var env, fenv, env2,
cent1, cent2,
op1,op2,fb1,fb2,
sig;

cent1 = 2**(4.2/1200);
cent2 = 2**((4.3*0.76543)/1200);

env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');

//		freq = {freq * bend.midiratio * LFNoise2.kr(2.5,0.01,1)}!2;

fenv = Env.adsr(fattack,fdecay,fsustain,frelease,1,'sine');
fenv = EnvGen.kr(fenv, gate);
fenv = aoc*(fenv - 1) + 1;


sig = (Saw.ar(freq));
sig = (Saw.ar(freq*cent1)) + sig;
sig = (Saw.ar(freq*cent2)) + sig;


sig = sig*EnvGen.kr(env, gate: gate,doneAction:da);

sig = MoogFF.ar
(
sig,
cutoff*fenv,
gain
);

sig = HPF.ar(sig,hpf);

sig = FreeVerb.ar(sig); // fan out...

sig = Splay.ar(sig,spread,center:balance);

Out.ar(out,amp*sig);

}).send(s);






)

*/