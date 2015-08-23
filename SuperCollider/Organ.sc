// =====================================================================
// Organ
// =====================================================================

Help.gui

s = JStethoscope.defaultServer.boot;
JFreqScope.new( 400, 200, 0 );

(
 SynthDef(\Organ, {arg out = 0, freq = 440, gate = 1, da = 2;
 var op1,op2,op3,op4,op5,op6,env,env1,env2,env3,env4,env5,env6;

	 env1 = Env.adsr(0,0.8,0.2,0.9);
	 env2 = Env.adsr(0,0.2,0.2,0.9);
	 env3 = Env.adsr(0,0.8,0.54,0.83);
	 env4 = Env.adsr(0,0.8,0.2,0.9);
	 env5 = Env.adsr(0,0.8,0.2,0.9);
	 env6 = Env.adsr(0,0.5,0.2,0.9);

 op2 = SinOsc.ar((freq*1.01)/(2**(6/1200)),0,
	 EnvGen.kr(env2, gate: gate, doneAction:da);); 

	 
 op1 = SinOsc.ar((freq*0.5)/(2**(2/1200)),0,
	 EnvGen.kr(env1, gate: gate, doneAction:da););
	  

 op4 = SinOsc.ar((freq*0.5)*(2**(5/1200)),0,
	 EnvGen.kr(env4, gate: gate, doneAction:da););

 op3 = SinOsc.ar((freq*1.5)*(2**(6/1200)),0,
	 EnvGen.kr(env3, gate: gate, doneAction:da););


 op6 = SinOscFB.ar((freq*3),0,
	 EnvGen.kr(env6, gate: gate,  doneAction:da););

 op5 = SinOsc.ar(freq*(2**(2/1200)),0,
	 EnvGen.kr(env5, gate: gate,  doneAction:da););

	 x = gate*((0.06*op3) + (0.06*op1) + (0.06*op2) + (0.06*op4) + (0.06*op5) + (0.06*op6));

 Out.ar(out,x.dup)}).store;
 )





(

 var inPorts = 1;
 var outPorts = 1;
//MIDIClient.disposeClient;
 MIDIClient.init(inPorts,outPorts); // explicitly intialize the client
 inPorts.do({ arg i; 
       MIDIIn.connect(i, MIDIClient.sources.at(i));
   });
 )



(
 var zz;
 zz=Array.newClear(128);

 MIDIIn.noteOn = {arg src, chan, num, vel;
	 var x;

   if((chan == 0), {
       x = Synth("Organ");
       num.postln;
       x.set(\da,2);
       x.set(\freq,num.midicps);

     });

   zz.put(num,x);


 };


 MIDIIn.bend = { arg src,chan,val;


 };


 MIDIIn.noteOff = { arg src,chan,num,vel;
   var a;
   a = zz.at(num);
   a.set(\gate, 0);
 };


 MIDIIn.polytouch = { arg src, chan, num, vel;


 };

 MIDIIn.control = { arg src, chan, num, val; 


 };

 MIDIIn.program = { arg src, chan, prog;


 };

 )
