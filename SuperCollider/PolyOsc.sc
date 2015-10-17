 ~makePolyOsc = ({arg name, multi = 1;

     SynthDef(name, {
	 arg ss, freq, out = 0, amp = 0.5, pan = 0.5, range = 1, gate = 1, da = 2, dur = 1,att=0,dec=0;
	 var sig, cut, env = 1;

	 cut = 1/multi;

	 freq = {freq * LFNoise2.kr(1,0.01,1) } ! multi;
         sig = LFSaw.ar(freq); 
 //	 sig = Osc.ar(ss,freq).dup;//*gate;

	 sig = cut*amp*Pan2.ar(sig,pan);
 	 sig = Splay.ar(sig);
         env = Env.linen(att,dur-att,dec,1);

	 env = EnvGen.kr(env, gate,doneAction:da);
 
	 Out.ar(out,env*sig);
	 
       }).store;
   });
