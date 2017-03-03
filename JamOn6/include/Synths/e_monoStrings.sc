SynthDef("e_monoStrings",
	{arg out = 0,freq = 55.00, lagLev = 0, fin = 998, aocIn = 998, cutoff = 998, gain = 1, mul = 1, amp = 1, aoc = 1;

		var sig,env;

		freq = Lag.kr(freq, lagLev);

		freq = {freq * LFNoise2.kr(2.5,0.01,1)}!5;

		sig = (LFSaw.ar(freq,0,0.1));

		cutoff = (aoc*(In.ar(fin) - 1) + 1)*cutoff;
		sig = MoogFF.ar(sig, freq:cutoff, gain: gain,mul:mul);

		env = In.ar(aocIn);
		sig = sig * env;

		sig = Splay.ar(sig);

		OffsetOut.ar(out, sig*amp);


}).send(s);


~midiMonoStrings = {arg myevents,num, monoString, env1,env2;
	var flt, env,amp;
	amp = myevents.amp;
	flt = myevents.filter;
	env = myevents.envelope;

	if(num.isMemberOf(Integer),
		{
			flt.setaFilter(env1,monoString);
			env.setEnvelope(env2);
			monoString.set(\freq,num.midicps);
			monoString.set(\amp,amp);
			monoString.set(\out,myevents.out);

	}, {["rest"].post}); // false action

	env2;
};

/*
~celloStrings = Synth("e_monoStrings",addAction: \addToTail);
~envAsr = Bus.control(s,1);
~envAdsr = Bus.control(s,1);
~celloStrings.set(\fin,~envAsr);
~celloStrings.set(\aocIn,~envAdsr);

	~ret14 = Synth("myASRk",addAction: \addToHead);
	~ret14b = Synth("myADSRk",addAction: \addToHead);
	~ret14.set(\out,~envAsr);
	~ret14b.set(\out,~envAdsr);
			~ret14.set(\gate,1);
			~ret14b.set(\gate,1);
*/