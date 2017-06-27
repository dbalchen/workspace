// =====================================================================
// FM Lead
// =====================================================================

 SynthDef(\FMlead, {arg out = 0, freq = 440, gate = 0, amp = 1, da = 2,attack = 0, decay = 4, sustain = 0.2, release = 1;
     var op1,op2,op3,op4,op5,op6,env,env1,env2,env3,env4,env5,env6,menv,x,sig;

     env1 = Env.new([0,1,   0.95,0.95,0],[0,1,0.88,0.3], 1, 3);
     env2 = Env.new([0,1,   0.96,0.89,0],[0,0.05,1,1], 1, 3);
     env3 = Env.new([0,0.93,0.90,0   ,0],[0,0.13,1,1], 1, 3);
     env4 = Env.new([0,1,   0.90,0   ,0],[0,0.08,0.72,0.40  ], 1, 3);
     env5 = Env.new([0,1,   0.65,0.6 ,0],[0,0,0.03,1], 1, 3);
     env6 = Env.new([0,1,   1   ,0.97,0],[0,0.30,0.4 ,1 ], 1, 3);


     menv = Env.adsr(attack,decay,sustain,release);
     menv = EnvGen.kr(menv, gate: gate);
     op6 = 0.47*SinOsc.ar(freq*17,0,
			  EnvGen.kr(env5, gate: gate););	 

     op5 = 0.43*SinOsc.ar((freq*3)/(2**(2/1200)),op6,
			  EnvGen.kr(env5, gate: gate););

     op4 = 0.71*SinOsc.ar((freq*2)*(2**(2/1200)),op5,
			  EnvGen.kr(env3, gate: gate););

     op3 = 0.82*SinOscFB.ar(freq,0.02,
			    EnvGen.kr(env6, gate: gate););

     op2 = 0.71*SinOsc.ar(freq/(2**(1/1200)),0,
			  EnvGen.kr(env2, gate: gate);); 

     x = (op4) + (op3) + (op2);

     op1 = 1.0*SinOsc.ar(freq*(2**(1/1200)),x,
			 EnvGen.kr(env1, gate: gate, doneAction:da);); 

     sig = menv*op1 * 0.333333;

	 //     sig = Splay.ar(sig);
	 Out.ar(out,amp*sig.dup);

	 }).send(s);


~midiFMlead = {arg myevents,num;
	     var flt, env,amp,tt;
	     amp = myevents.amp;
	     flt = myevents.filter;
	     env = myevents.envelope;

	     if(num.isMemberOf(Integer),
	       { 
		 tt = Synth("FMlead");
		 tt.set(\gate,0);
		 flt.setFilter(tt);
		 env.setEnvelope(tt);
		 tt.set(\freq,num.midicps);
		 tt.set(\da,2);
		 tt.set(\amp,amp);
		 tt.set(\gate,1);
		 tt.set(\out,myevents.out);

	       }, {["rest"].post}); // false action

             tt;
};




