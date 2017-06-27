// =====================================================================
// eOboe
// =====================================================================

//"/home/dbalchen/workspace/SuperCollider/makeWaveTable.sc".loadPath;

//~oboesound = ~makeWav.value("/home/dbalchen/Music/Samples/wavetables/AKWF_oboe/AKWF_oboe_0006.wav");


SynthDef("Oboe", {
    arg ss, freq = 110, out = 0, amp = 0.5, lagt = 0, da = 2, gate = 1,
      attack = 0, decay = 0, sustain = 1, release = 0.5,
      fattack = 0.5, fsustain = 1, frelease = 0.5, aoc = 1, gain = 2, cutoff = 5000.00;

    var sig, env, fenv;

    env = Env.adsr(attack,decay,sustain,release);

    fenv = Env.asr(fattack,fsustain,frelease, 1,curve: 'sine');
    fenv = EnvGen.kr(fenv, gate,doneAction:da);
    fenv = aoc*(fenv - 1) + 1;

    freq = Lag.kr(freq,lagt);
    freq = { freq * LFNoise2.kr(1,0.002,1) }!2; 

	//  sig = Osc.ar(ss,freq,[0,0.1,0.2],mul: EnvGen.kr(env, gate: gate, doneAction:da)) * amp;

	// freq = SinOsc.ar(0.5*freq)*2 + freq;

       sig  = Pulse.ar(freq, 0.97, mul: EnvGen.kr(env, gate: gate, doneAction:da))  * amp;
    // sig  = Pulse.ar(freq, MouseX.kr(0.5,0.99), mul: EnvGen.kr(env, gate: gate, doneAction:da))  * amp;
       
    sig = MoogFF.ar
      (
       sig,
       cutoff*fenv,
       gain
       );

    sig = Splay.ar(sig);
 
    Out.ar(out,sig);
	 
  }).store;

~midiOboe= {arg myevents,num;
	     var flt, env,amp,tt;
	     amp = myevents.amp;
	     flt = myevents.filter;
	     env = myevents.envelope;

	     if(num.isMemberOf(Integer),
	       { 
         tt = Synth("Oboe");
         tt.set(\da,2);
         tt.set(\ss,~oboesound);
		 flt.setFilter(tt);
		 env.setEnvelope(tt);
		 tt.set(\gate,0);
		 tt.set(\freq,num.midicps);
		 tt.set(\amp,amp);
		 tt.set(\gate,1);
		 tt.set(\out,myevents.out);

	       }, {["rest"].post}); // false action

             tt;
};
