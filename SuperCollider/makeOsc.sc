 ~makeOsc = ({arg name, multi = 1;

     SynthDef(name, {
	 arg ss, wiggler, freq = 110, out = 0, amp = 0.5, lagt = 0.0, pan = 0.5, range = 1, wrange = 1, wfreq = 0, da = 0, spread = 0.01, 		     namp =1;
	 var sig, cut, env = 0;

	 cut = 1/multi;

         freq = (freq*range) + Osc.kr(wiggler,wfreq,mul: wrange);

	 freq = {freq * LFNoise2.kr(namp,spread,1) } ! multi;

	 freq = Lag.kr(freq,lagt);

 	 sig = Osc.ar(ss,freq).dup;//*gate;

	 sig = cut*amp*Pan2.ar(sig,pan);

//	 EnvGen.kr(0, gate: gate, doneAction:da);
 
	 Out.ar(out,sig);
	 
       }).store;
   });
