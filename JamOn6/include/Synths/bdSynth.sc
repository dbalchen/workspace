

SynthDef(\bdSound, {arg out = 0, amp = 1, aoc = 1, oscIn = 0, aocIn = 0, spread = 0, center = 0,// VCA Controls
	clip = 1, overd = 1, cutoff = 5000, gain = 1, mgain = 0, mul = 1; // Clip and Low Pass Filter

	var sig;

	sig = In.ar(oscIn,1);
	gain = In.ar(gain) + mgain;
	cutoff = In.ar(cutoff);
	mul = In.ar(mul);
	sig = MoogFF.ar(sig, freq:cutoff, gain: gain,mul:mul);

	aoc = aoc*(In.ar(aocIn) - 1) + 1;
	sig = sig * aoc;

	sig = sig*overd;
	sig = sig.clip2(clip);
	sig = Splay.ar(sig,spread,center:center);

	OffsetOut.ar(out, sig*amp);
}).add;
