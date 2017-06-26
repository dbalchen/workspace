// =====================================================================
// FM Bass
// =====================================================================

Help.gui
Quarks.gui

s = JStethoscope.defaultServer.boot;
JFreqScope.new( 400, 200, 0 );

(
 SynthDef(\FMbass, {arg out = 0, freq = 440, gate = 1, duration = 2, da = 2;
     var op1,op2,op3,op4,op5,op6,env,env1,env2,env3,env4,env5,env6,x;

     env1 = Env.adsr(0,duration- (0.65*duration),0,0);
     env2 = Env.adsr(0,0,0,0);
     env3 = Env.adsr(0.0021,duration - (0.65*duration),0,0);
     env4 = Env.adsr(0.0010,duration - (0.30*duration),0,0);
     env5 = Env.adsr(0,0,0,0);
     env6 = Env.adsr(0.0007,duration - (0.28*duration),0,0);

     op6 = 0.85*SinOscFB.ar(freq*9.0,0.7,
			    EnvGen.kr(env6, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););	 

     op4 = 0.93*SinOsc.ar(freq*5.0,0,
			  EnvGen.kr(env3, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

     op3 = 1*SinOsc.ar(freq*0.5,op4,
		       EnvGen.kr(env3, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

     op2 = 0.80*SinOsc.ar(freq*0.5,0,
			  EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da);); 

     op5 = 0.62*SinOsc.ar(freq*0.5,op6,
			  EnvGen.kr(env5, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

     x = 8*(op2 + op3  + op5);

     op1 = 1.0*SinOsc.ar(freq*0.50,x,
			 EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da);); 
	 
     Out.ar(out,op1.dup)}).store;
 )


(
 x = Synth("FMbass");
 a = [45].choose;
 x.set(\freq,a.midicps);
 x.set(\gate,1);
 //x.set(\gate,0);
 )



// Gui Test

(

 ~flip = 0.05;
 ~density = ~flip;
 ~win = JSCWindow.new;
 ~win.front;

 //////// adding a two-state button
 
 ~playButton = JSCButton( ~win, Rect( 4, 4, 40, 56 ));
 ~playButton.states = [[ "Play", Color.white, Color.green( 0.4 )],
		       [ "Stop", Color.white, Color.red ]];
 ~playButton.action = { arg view; "New value is %\n".postf( view.value )};


 ~playButton.action = { arg view;
   if( view.value == 1, {
       ~node = ~routine.value;
     }, {
       ~node.stop; ~node = nil;
     })
     };

 ~win.setInnerExtent( 360, 72 );  // more suitable dimensions for the window
 ~win.resizable = false;

 JSCStaticText( ~win, Rect( 56, 4, 50, 25 )).align_( \right ).string_( "Density:" );

 ~density = JSCSlider( ~win, Rect( 110, 4, 200, 25 ))
 .value_( ~density ) // initial slider position
 .action_({ arg view;
     ~density = view.value;
     ~flip = ~density;
   });

 z.free;

 /// End GUI

 ~routine = {z = Array.newClear(128);
   r = Task({
       inf.do({ arg count;
	   var midi, oct, density;
	   midi = ([62,65,69,72,76,74,77,81,84,88].choose - 24);
	   if(~flip.coin, 
	     { 
	       x = z.at(midi);
	       x.set(\gate,0);
			
	       x = Synth("FMbass");
	       x.(\da,1);	
	       x.set(\freq,midi.midicps);
	       z.put(midi,x);
	     }, {["rest"].post}); // false action
	   0.2.wait; 
	 }); 
     }).start}

 )

