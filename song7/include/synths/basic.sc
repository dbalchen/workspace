SynthDef("BasicSynth" { arg freq = 55, out = 0, amp = 0.5, da = 2, gate = 0
	spread = 1, balance = 0, hpf = 128;


	var sig;

	sig = HPF.ar(sig,hpf);

	sig = LeakDC.ar(sig);

	sig = Splay.ar(sig,spread,center:balance);

	Out.ar(out,sig * amp);

}).send(s);


~channel0 = {arg num, vel = 1;
	var ret;
	num.postln;
	ret = Synth("BasicSynth");
	ret.set(\freq,num.midicps);
	ret.set(\gate,1);
	ret;
};
