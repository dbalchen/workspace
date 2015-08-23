// =====================================================================
// eOboe
// =====================================================================

SynthDef("PulseLead", {
    arg freq = 110, out = 0, amp = 0.5, lagt = 0, da = 0, gate = 0,pw = 0.97,
      attack = 0, decay = 0, sustain = 1, release = 0.5,
      fattack = 1.5, fsustain = 1, frelease = 0.5, aoc = 1, gain = 2, cutoff = 5000.00;

    var sig, env, fenv;

    env = Env.adsr(attack,decay,sustain,release);

    fenv = Env.asr(fattack,fsustain,frelease, 1,curve: 'sine');
    fenv = EnvGen.kr(fenv, gate: gate);
    fenv = aoc*(fenv - 1) + 1;

    freq = Lag.kr(freq,lagt);
    freq = { freq * LFNoise2.kr(1,0.002,1) }!3; 

       sig  = Pulse.ar(freq, pw, mul: EnvGen.kr(env,gate: gate, doneAction:da))  * amp;
     
    sig = MoogFF.ar
      (
       sig,
       cutoff*fenv,
       gain
       );

    sig = Splay.ar(sig);
 
    Out.ar(out,sig);
	 
  }).store;

~midiPulseLead= {arg myevents,num;
	     var flt, env,amp,tt;
	     amp = myevents.amp;
	     flt = myevents.filter;
	     env = myevents.envelope;

	     if(num.isMemberOf(Integer),
	       { 
         tt = Synth("PulseLead");
         tt.set(\pw,0.95);
         tt.set(\da,2);
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

/*
~midiPulseLeadMono= {arg myevents,num,mysynth;
	     var flt, env,amp,tt;
	     flt = myevents.filter;
	     env = myevents.envelope;
	     amp = myevents.amp;
             tt = mysynth;
	     if(num.isMemberOf(Integer),
	       { 
                 tt.set(\gate,-1.0);
                 Routine.run({0.2.wait;});
                 tt.set(\pw,0.95);
                 tt.set(\da,0);
		 flt.setFilter(tt);
		 env.setEnvelope(tt);
		 tt.set(\freq,num.midicps);
		 tt.set(\amp,amp);
		 tt.set(\gate,1);
		 tt.set(\out,myevents.out);

	       }, {["rest"].post}); // false action
	     tt;
};

*/