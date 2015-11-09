// =====================================================================
// eOboe
// =====================================================================

SynthDef("PulseLead", {
    arg freq = 110, out = 0, amp = 1.0, lagt = 0, da = 0, gate = 0,pw = 0.95,bassamt = 0.5,
      attack = 0.5, decay = 1.0, sustain = 1, release = 0.5,
      fattack = 1.5, fsustain = 1, frelease = 0.5, aoc = 1, gain = 2, cutoff = 5000.00, bend = 0;

    var sig, env, env2, fenv, freq2;

    env = Env.adsr(attack,decay,sustain,release);
    env = EnvGen.kr(env, gate: gate,doneAction:da);

    env2 = Env.adsr(attack,decay,sustain,release);
	//    env2 = Env.adsr(attack,0.5,0,0.09);
    
    env2 = EnvGen.kr(env2, gate:gate);

    fenv = Env.asr(fattack,fsustain,frelease, 1,curve: 'sine');
    fenv = EnvGen.kr(fenv, gate: gate,doneAction:da);
    fenv = aoc*(fenv - 1) + 1;

	freq = Lag.kr(freq,lagt) * bend.midiratio;
    freq = { freq * LFNoise2.kr(1,0.002,1) }!2; 

	sig  = Pulse.ar(freq, pw) + ((bassamt*Pulse.ar(freq/2, 0.97) *env2));
    sig = Splay.ar(sig*env);   
      
    sig = MoogFF.ar
      (
       sig,
       cutoff*fenv,
       gain
       );

    Out.ar(out,sig*amp);
	 
  }).add;



~midiPulseLead= {arg myevents,num,chan,vel=1;//,pulsewidth = 9.5;
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
		 tt.set(\amp,amp*vel);
		 tt.set(\gate,1);
		 tt.set(\out,myevents.out);
         tt.set(\bend, ~bend[chan]);

	       }, {["rest"].post}); // false action

             tt;
};


~monoPulseLead = {arg myevents;
	      var myTask,x,y,flt,env;

	      myTask = Task({
		  var num,dur,amp,lag,wt,tt, vel;
          flt = myevents.filter;
		  env = myevents.envelope;
		  tt = Synth("PulseLead");
		  tt.set(\da,0);
		  tt.set(\gate,0);
		  inf.do({ 
		      num = myevents.freq.next;
		      dur = myevents.duration.next;
              vel = myevents.vel.next;
		      amp = myevents.amp * vel;
		      lag = myevents.lag.next * myevents.lagt;
              wt = myevents.wait.next;
		      if(num.isMemberOf(Integer),
			{ 
				// {

			  tt.set(\gate,0);
			  env.setEnvelope(tt);
			  flt.setFilter(tt);
			  tt.set(\freq,num.midicps);
			  tt.set(\amp,amp);
			  tt.set(\lagt,lag);
              tt.set(\out,myevents.out);
			  tt.set(\gate,1);
              (dur- env.lrelease).wait;
              tt.set(\gate,0);
              env.lrelease.wait;
				  //}.fork;
			  }, {["rest"].post}); // false action
			  (wt - dur).wait;
		    });
		  }).start;};

