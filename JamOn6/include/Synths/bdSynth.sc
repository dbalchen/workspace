

    SynthDef(\bdSound, {arg out = 0, amp = 1, oscIn = 0, aocIn = 0, aenv = 0, spread = 0, center = 0, // VCA Controls
	  clip = 1, overd = 1, cutoff = 0, gain = 0, mul = 1; // Clip and Low Pass Filter

	var sig, aoc;

	sig = In.ar(oscIn);

	cutoff = In.ar(cutoff) * 1.5;
	gain = In.ar(gain);
	mul = In.ar(mul);
	sig = MoogFF.ar(sig, freq:cutoff, gain: gain,mul:mul);

	aoc =  In.ar(aocIn) * (In.ar(aenv) - 1) + 1;
		sig = sig * aoc;

	sig = sig*overd;
	sig = sig.clip2(clip);
	sig = Splay.ar(sig,spread,center:center);

	OffsetOut.ar(out, (sig * amp));
      }).add;	
