SynthDef(\Noise, {arg out = 0, freq = 550, rq = 0.5, lagLev = 0.0;
	var sig;
	sig = WhiteNoise.ar(1);
	freq = Lag.kr(freq, lagLev);
	sig = BPF.ar(sig,freq,rq,mul:1/rq);
	Out.ar(out, sig);
}).add;


SynthDef(\Pulse, {arg out = 0, freq = 55, width = 0.5, lagLev = 0.0;
	var sig;
	freq = Lag.kr(freq, lagLev);
	sig = LFPulse.ar(freq, 0, 0.5, 1, -0.5);
	Out.ar(out, sig);
}).add;


SynthDef(\Sine, {arg out = 0, amp = 1;;
	var sig,env1,env1m,env0;
	
	env0 =  EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, 0.26], [-4, -2, -4]), doneAction:2);
        env1 = EnvGen.ar(Env.new([110, 59, 29], [0.005, 0.29], [-4, -5]));
	env1m = env1.midicps;
	sig = SinOsc.ar(env1m, 0.5, env0);
	Out.ar(out, sig*amp);
}).add;


