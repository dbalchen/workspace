// =====================================================================
// Cavern
// =====================================================================

SynthDef(\Cavern, {arg out = 0, freq =13.75, gate = 1,amp = 0.10, da = 2, attack = 1.0, decay = 1,sustain = 1.0, release = 0.5;
	var sig,env, partials,base;

	partials = 4;
	env = Env.adsr(attack,decay,sustain, release);
	env = EnvGen.kr(env,gate: gate, doneAction:da);

	sig = Mix.ar(  {

		base = exprand(freq, freq*3);
		Klank.ar(
			`[ {rrand(1, 24) * base * rrand(1.0, 1.1)}.dup(partials), Array.rand(10, 1.0, 5.0).normalizeSum],

			GrayNoise.ar( [rrand(0.03, 0.1),
				rrand(0.03, 0.1)]) )*max(0.25, LFNoise1.kr(5/20)
		)
	}.dup(5));

	sig = (sig * env * amp);

	sig = Splay.ar(sig);

	Out.ar(out,sig)}).store;

// ~xx.set(\gate,0);
// ~xx = Synth(\Cavern);
// ~xx.set(\freq,27.5);
//
// ~xx.set(\gate,1);
// ~xx.set(\gate,0);







