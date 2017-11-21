// =====================================================================
// Sad Saxaphone
// =====================================================================

(
SynthDef("sadSax",
	{
		arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,hpf = 20,
		attack = 0.5, decay = 2.0, sustain = 0.0, release = 0.6,
		fattack = 0.5,fdecay = 0.5, fsustain = 0.8,
		frelease = 0.6, aoc = 0.9, gain = 0.7, cutoff = 5200.00,
		bend = 0, spread = 1, balance = 0;

		var env, fenv, op1, op2, op3, op4, op5, op6,
		fb1, fb2, fb3, fb4, fb5, fb6, freq2, tmp,
		sig;

		env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');
		env = EnvGen.kr(env, gate: gate,doneAction:da);

		fenv = Env.adsr(fattack,fdecay,fsustain,frelease,1,'sine');
		fenv = EnvGen.kr(fenv, gate);

		fenv = aoc*(fenv - 1) + 1;

		//		freq = {freq * LFNoise2.kr(2.5,0.01,1)}!2;
		/*
		tmp = MouseX.kr(0,10);
		fb4 = FbNode(1);
		op4 = 0.7*(SinOsc.ar((freq+tmp)*1.0,fb4, mul: env));
		fb4.write((0.47*Saw.ar(freq+tmp)) + op4);

		fb3 = FbNode(1);
		op3 = 0.95*SinOsc.ar((freq+tmp)*1,(fb3) + (op4), mul: env);
		fb3.write((0.01*Saw.ar(freq+tmp)) + op3);
		*/
		fb2 = FbNode(1);
		op2 = 0.7*(SinOsc.ar(freq*1.0,fb2, mul: env));
		fb2.write((0.47*Saw.ar(freq)) + op2);

		fb1 = FbNode(1);
		op1 = 0.95*SinOsc.ar(freq*1,(fb1) + (op2), mul: env);
		fb1.write((0.01*Saw.ar(freq)) + op1);

		sig = (op1);// + (0.5*op3);

		sig = RLPF.ar
		(
			sig,
			cutoff*fenv,
			gain
		);

		//		sig = DelayL.ar(sig, 0.2, 0.3,1,sig);
		sig = HPF.ar(sig,hpf);

		sig = FreeVerb.ar(sig,0.33,0.7); // fan out...

		sig = LeakDC.ar(sig);

		sig = Splay.ar(sig,spread,center:balance);

		Out.ar(out,amp*sig);

}).send(s);

)