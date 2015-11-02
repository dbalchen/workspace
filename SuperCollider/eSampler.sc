SynthDef(\Esampler, {arg bufnum = 0, out = 0, amp = 0.5, da = 0, gate = 0, rate = 1.0, midi = 60, basef = 60,
      attack = 0, decay = 0, sustain = 1, release = 0.5, fattack = 0.0, fsustain = 1, frelease = 0.0, aoc = 0, gain = 2, cutoff = 10000.00;
  
    var sig, env, fenv,i;

    i = midi.midicps/basef.midicps;

    env  = Env.adsr(attack,decay,sustain,release);
    env = EnvGen.kr(env, gate: gate, doneAction:da);
    fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
    fenv = EnvGen.kr(fenv, gate,doneAction:da);
    fenv = aoc*(fenv - 1) + 1;
    sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate*i,gate,0,0, doneAction:da)*amp;
    sig = sig * env;
	
    sig = MoogFF.ar
      (
       sig,
       cutoff*fenv,
       gain
       );
    sig = Splay.ar(sig);
	
    Out.ar(out,sig);
	 
  }).store;


~runEsampler = {arg myevents,sounds,template,rate = 1.0, poly = 4;
		var myTask,x,y, flt, env;

		myTask = Task({
		    var num,dur,amp,synths,si = 0;
			
		    synths = Array.newClear(poly);
		    for(0, synths.size - 1,
		      { arg i; 
			var tt;
			tt = Synth("Esampler");
			tt.set(\gate,0);
			tt.set(\da,0);
			synths.put(i,tt); 
		      }
		      );
			
		    inf.do({ 
			num = myevents.freq.next;
			dur = myevents.duration.next;
			amp = myevents.amp;
			flt = myevents.filter;
			env = myevents.envelope;

			if(num.isMemberOf(Integer),
			  { 
			    {
			      var tt = synths[si % poly];
			      si = si + 1;
			      tt.set(\gate,0);
			      flt.setFilter(tt);
			      env.setEnvelope(tt);
			      template.value(tt,num,sounds);
			      tt.set(\da,0);
			      tt.set(\amp,amp);
			      tt.set(\gate,1);
                              tt.set(\rate,rate);
			      tt.set(\out,myevents.out);
			      dur.wait;
			      tt.set(\gate,0);
			    }.fork;

			  }, {["rest"].post}); // false action
			myevents.wait.next.wait;
		      }); 
		  }).start};


~eSampler = {arg myevents,sounds,template, num, rate = 1.0;
	     var myTask,x,y, flt, env,amp,tt;
	     amp = myevents.amp;
	     flt = myevents.filter;
	     env = myevents.envelope;

	     if(num.isMemberOf(Integer),
	       { 
		 tt = Synth("Esampler");
		 tt.set(\gate,0);
		 flt.setFilter(tt);
		 env.setEnvelope(tt);
		 template.value(tt,num,sounds);
		 tt.set(\midi,num);
         tt.set(\rate,rate);
		 tt.set(\da,2);
		 tt.set(\amp,amp);
		 tt.set(\gate,1);
		 tt.set(\out,myevents.out);

	       }, {["rest"].post}); // false action

             tt;
};


