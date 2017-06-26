SynthDef(\Sine, {arg out = 0, amp = 1;
	var sig,env1,env1m,env0;

	env0 =  EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, 0.26], [-4, -2, -4]), doneAction:2);
	env1 = EnvGen.ar(Env.new([110, 59, 29], [0.005, 0.29], [-4, -5]));
	env1m = env1.midicps;
	sig = SinOsc.ar(env1m, 0.5, env0);
	Out.ar(out, sig*amp);
}).add;

SynthDef(\vca, {arg out = 0, in = 0, amp = 1, bamp = 998, spread = 0, center = 0,
	clip = 1, overd = 1, aoc = 0, aocIn = 0;
	var sig;
	sig = In.ar(in,1);
	aoc = aoc*(In.ar(aocIn) - 1) + 1;
	sig = sig * aoc;
	sig = sig*overd;
	sig = sig.clip2(clip);
	amp = amp + In.kr(bamp);
	sig = Splay.ar(sig,spread,center:center);
	OffsetOut.ar(out, sig*amp);
}).add;

~sine1Out = Bus.audio(s,1);
~vca1 =  Synth("vca",addAction: \addToTail);
~vca1.set(\in,~sine1Out);
~vca1.set(\amp,0.5);