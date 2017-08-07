/***************************************
Tbell (Tibetian Prayer Bell)
****************************************/

(
SynthDef(\tbell, {arg out = 0, gate = 0,freq = 2434, amp = 0.25,
	attack=0, decay = 10, sustain = 0, release = 1,
	lag = 10, da  = 2, scale = 2434,sing_switch = 1, hit = 10000;

	var sig, input, freqscale, decayscale, sing, env;

	freqscale = freq / scale;
	decayscale = decay / 10;
	freqscale = Lag3.kr(freqscale, lag);
	decayscale = Lag3.kr(decayscale, lag);

	sig = LPF.ar(Trig.ar(gate, SampleDur.ir)!2, hit * freqscale);

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

	sig = Splay.ar(sig*env*amp);
	Out.ar(out, sig);
}).add;
)


//
~bell.set(\gate,0);
~bell = Synth(\tbell);
~bell.set(\freq,880);
~bell.set(\lag,32);
~bell.set(\sing_switch,1);
~bell.set(\sustain,0.8);
~bell.set(\attack,8);
~bell.set(\hit,10000);
~bell.set(\decay,8);
~bell.set(\gate,1);
~bell = Synth(\tbell);
~bell.set(\freq,440);
~bell.set(\lag,32);
~bell.set(\sing_switch,1);
~bell.set(\sustain,0.2);
~bell.set(\attack,0);
~bell.set(\hit,10000);
~bell.set(\decay,8);
~bell.set(\gate,1);

//~bell.set(\gate,0);
~bell = Synth(\tbell);
~bell.set(\freq,110);
~bell.set(\lag,32);
~bell.set(\sing_switch,1);
~bell.set(\sustain,0.1);
~bell.set(\attack,8);
~bell.set(\hit,1000);
~bell.set(\decay,8);
~bell.set(\gate,1);
