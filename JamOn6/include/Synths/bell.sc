SynthDef(\tbell, { |out, gate = 0, freq = 2434, attack = 0, release = 0.1, fscale = 1, amp = 0.5, decayscale = 0.5, lag = 10|

	var sig, input, first, freqscale, env;


	env = EnvGen.kr(Env.linen(attack,decayscale,release),gate,doneAction:2);

	freqscale = freq / (2434/fscale);
	freqscale = Lag3.kr(freqscale, lag);

	decayscale = Lag3.kr(decayscale, lag);

	input = LPF.ar(Trig.ar(gate, SampleDur.ir)!2, 10000 * freqscale);

	sig = DynKlank.ar(`[

		[

			(first = LFNoise1.kr(0.5).range(2433, 2436)) + Line.kr(20, 0, 0.5),

			first + LFNoise1.kr(0.5).range(1,3),

			LFNoise1.kr(1.5).range(5437, 5438) - Line.kr(35, 0, 1),

			LFNoise1.kr(1.5).range(5482, 5483) - Line.kr(10, 0, 0.5),

			LFNoise1.kr(2).range(8438, 8443) + Line.kr(15, 0, 0.05)

		],

		[

			LFNoise1.kr(1).range(-10, -5).dbamp,

			LFNoise1.kr(1).range(-20, -10).dbamp,

			LFNoise1.kr(1).range(-12, -6).dbamp,

			LFNoise1.kr(1).range(-12, -6).dbamp,

			-20.dbamp

		],

		[

			20 * freqscale.pow(0.2),

			20 * freqscale.pow(0.2),

			5,

			5,

			0.6

		] * freqscale.reciprocal.pow(0.5)

	], input,freqscale, 0, decayscale);


	sig = sig*env;

	sig = Mix.new(sig);

	Out.ar(out, sig*amp);

}).add;