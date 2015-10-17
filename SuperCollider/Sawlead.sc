// =====================================================================
// SawLead
// =====================================================================


(
 SynthDef("Sawlead", { arg out, freq = 440, gate = 0, da = 2, amp = 1, attack = 0.25, sustain = 1, rq = 0.2;
     var x,env, fenv, cent1, cent2;
	 env = Env.adsr(attack,0.5,0.7,sustain);
	 // env = Env.adsr(attack,sustain,0,0);
     fenv = LFNoise1.kr(2, 24, 110).midicps;
     cent1 = 2**((10*0.3333)/1200);
     cent2 = 2**((10*0.25)/1200);
     env =  EnvGen.kr( env, gate:gate,levelScale: 0.3, doneAction: da ,timeScale: sustain);
     x = RLPF.ar(LFSaw.ar( [freq,freq*cent1,freq/cent2], mul: env ),fenv,rq);
     x = 0.33*0.5*x.dup;
     Out.ar(out, amp*x);
   }).store;

)


(
~makeSawLead = ({arg name,freqenvelope = 0;// LFNoise1.kr(2, 24, 110).midicps;

     SynthDef(name, { arg out, freq = 440, gate = 1, da = 2, amp = 1, attack = 0.25, sustain = 1, rq = 0.2;
	 var x, env, fenv, cent1, cent2;
         env = Env.adsr(attack,0.5,0.7,sustain);
	 fenv = LFNoise1.kr(2, 24, 110).midicps; 
	 cent1 = 2**((10*0.3333)/1200);
	 cent2 = 2**((10*0.25)/1200);
	 env =  EnvGen.kr( env, gate:gate,levelScale: 0.3, doneAction: da );
	 x = RLPF.ar(LFSaw.ar( [freq,freq*cent1,freq/cent2], mul: env ),fenv,rq);
	 x = 0.33*0.5*x.dup;
	 Out.ar(out, amp*x);
       });

   });

 )
