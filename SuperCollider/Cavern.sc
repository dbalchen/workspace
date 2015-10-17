// =====================================================================
// Cavern
// =====================================================================

 SynthDef(\Cavern, {arg out = 2, freq =13.75, gate = 1,amp = 1.0, da = 2, attack = 1.0, sus = 2,sustain = 4.0, release = 0.5;
     var z,env, partials,base;

     partials = 12;
     env = Env.adsr(attack,sustain,sus, release);
     env = EnvGen.kr(env,gate: gate, doneAction:da);


     z = Mix.ar(  {                                    

	 base = exprand(freq, freq*3);
	 Klank.ar(
		  `[ {rrand(1, 24) * base * rrand(1.0, 1.1)}.dup(partials), Array.rand(10, 1.0, 5.0).normalizeSum],
     
		  GrayNoise.ar( [rrand(0.03, 0.1),
				 rrand(0.03, 0.1)]) )*max(0.25, LFNoise1.kr(5/20)
							  )
	   }.dup(5));

	 
     z = 0.25*(z * env);
     Out.ar(out,z*amp)}).store;



  

  



