/***************************************
Tbell (Tibetian Prayer Bell)
****************************************/

(
SynthDef(\Tbell, {arg out = 0, gate = 0,freq = 2434, amp = 0.15,hpf = 120,
	attack=0, decay = 10, sustain = 0, release = 1,gain = 2,cutoff = 10000,
	lag = 10, da  = 2, scale = 2434,sing_switch = 1, spread = 0, balance = 0;

	var sig, input, freqscale, decayscale, sing, env;

	freqscale = freq / scale;
	decayscale = decay / 10;
	freqscale = Lag3.kr(freqscale, lag);
	decayscale = Lag3.kr(decayscale, lag);

	sig = LPF.ar(Trig.ar(gate, SampleDur.ir)!2, 10000 * freqscale);

	sing = LPF.ar(
		LPF.ar(
			{
				PinkNoise.ar * Integrator.kr(sing_switch * 0.001, 0.999).linexp(0, 1, 0.01, 1) * amp
			} ! 2,
			2434 * freqscale
		) + Dust.ar(0.1), 10000 * freqscale
	) * LFNoise1.kr(0.5).range(-45, -30).dbamp;

	sig = sig + (sing_switch.clip(0, 1) * sing);

	sig = DynKlank.ar(`[
		[
			(LFNoise1.kr(0.5).range(2424, 2444)) + Line.kr(20, 0, 0.5),
			(LFNoise1.kr(0.5).range(2424, 2444)) + Line.kr(20, 0, 0.5) + LFNoise1.kr(0.5).range(1,3),
			LFNoise1.kr(1.5).range(5435, 5440) - Line.kr(35, 0, 1),
			LFNoise1.kr(1.5).range(5480, 5485) - Line.kr(10, 0, 0.5),
			LFNoise1.kr(2).range(8435, 8445) + Line.kr(15, 0, 0.05),
			LFNoise1.kr(2).range(8665, 8670),
			LFNoise1.kr(2).range(8704, 8709),
			LFNoise1.kr(2).range(8807, 8817),
			LFNoise1.kr(2).range(9570, 9607),
			LFNoise1.kr(2).range(10567, 10572) - Line.kr(20, 0, 0.05),
			LFNoise1.kr(2).range(10627, 10636) + Line.kr(35, 0, 0.05),
			LFNoise1.kr(2).range(14689, 14697) - Line.kr(10, 0, 0.05)
		] ,
		[

			LFNoise1.kr(1).range(-10, -5).dbamp,
			LFNoise1.kr(1).range(-20, -10).dbamp,
			LFNoise1.kr(1).range(-12, -6).dbamp,
			LFNoise1.kr(1).range(-12, -6).dbamp,
			-20.dbamp,
			-20.dbamp,
			-20.dbamp,
			-25.dbamp,
			-10.dbamp,
			-20.dbamp,
			-20.dbamp,
			-25.dbamp

		] ,
		[
			20 * freqscale.pow(0.2),
			20 * freqscale.pow(0.2),
			5,
			5,
			0.6,
			0.5,
			0.3,
			0.25,
			0.4,
			0.5,
			0.4,
			0.6
		]
		* freqscale.reciprocal.pow(0.5)
	], sig, freqscale, 0, decayscale);

	env = Env.adsr(attack,decay,sustain,release);
	env = EnvGen.kr(env, gate, doneAction:da);

	sig =
	MoogFF.ar(
		sig,
		cutoff*env,
		gain
	);

	sig = HPF.ar(sig,hpf);
	sig = LeakDC.ar(sig);

	sig = Splay.ar(sig*env*amp,spread,center:balance);

	Out.ar(out, sig);
}).add;
)


//
// ~bells.set(\gate,0);
// ~bells = Synth(\bells);
// ~bells.set(\freq,440);
// ~bells.set(\lag,10);
// ~bells.set(\sing_switch,1);
// ~bells.set(\sustain,0.8);
// ~bells.set(\gate,1);



