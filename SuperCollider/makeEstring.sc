 ~makeEstring = ({arg name, multi = 1;

     SynthDef(name, {
	 arg ss, wiggler, freq = 110, out = 0, amp = 0.5, lagt = 0.0, pan = 0.5, 
	     range = 1, wrange = 1, wfreq = 0, gate = 1, da = 0,
	     aoc = 1, fattack = 0.1, fsustain = 0.7, cutoff = 5000, 
	     gain = 2.0, eattack = 0.25, edecay = 0.25, release = 2.0, esustain = 0.6;

	 var sig, cut, eenv, fenv;

	 cut = 1/multi;

         freq = (freq*range) + Osc.kr(wiggler,wfreq,mul: wrange);

	 freq = {freq * LFNoise2.kr(1,0.01,1) } ! multi;

	 freq = Lag.kr(freq,lagt);

 	 sig = Osc.ar(ss,freq).dup;//*gate;

	 sig = cut*amp*Pan2.ar(sig,pan);

         fenv = Env.asr(fattack,fsustain,release, 1);
	 fenv = EnvGen.kr(fenv, gate,doneAction:da);
	 fenv = aoc*(fenv - 1) + 1;

	  sig = MoogFF.ar
	  (
	   sig,
	   cutoff*fenv,
	   gain
	   );

        eenv = Env.adsr(eattack,edecay,esustain,release);
        eenv = EnvGen.kr(eenv, gate: gate,doneAction:da);

       sig = sig * eenv;
 
	 Out.ar(out,sig);
	 
       }).store;
   });
