// =====================================================================
// Vibes
// =====================================================================

Help.gui
Quarks.gui

s = JStethoscope.defaultServer.boot;
JFreqScope.new( 400, 200, 0 );






(
 SynthDef(\Vibes, {arg out = 0, freq = 440, gate = 1, duration = 2, da = 2;
     var op1,op2,op3,op4,op5,op6,env,env1,env2,env3,env4,env5,env6;

     env1 = Env.adsr(0.0008,1.0,0,0);
     env2 = Env.adsr(0,duration,0,0);


     op3 = 0.72*SinOsc.ar(freq*3.0,0,
		     EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););


     op2 = 0.90*SinOsc.ar(freq*1.00,op3,
			  EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da);); 

	

     op1 = 0.50*SinOsc.ar(freq*4.00,0,
		     EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da);); 


     op6 = 0.57*SinOscFB.ar(freq*14.0*(2**(7/1200)),0.40,
			    EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););	 

     op4 = 1.0*SinOsc.ar(freq*1/(2**(7/1200)),op6,
			  EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););


     op5 = 1.0*SinOsc.ar(freq*1.00*(2**(7/1200)),op6,
		     EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

     x = 0.5*((0.08*op2) + (0.09*op1)  + (0.08*op4) + (0.08*op5));

     Out.ar(out,x.dup)}).store;
 )











(
 x = Synth("Vibes");
 a = [60].choose;
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
	   midi = [62,65,69,72,76,74,77,81,84,88].choose;
	   if(~flip.coin, 
	     { 
	       x = z.at(midi);
	       x.set(\gate,0);
			
	       x = Synth("Vibes");
	       x.(\da,1);	
	       x.set(\freq,midi.midicps);
	       z.put(midi,x);
	     }, {["rest"].post}); // false action
	   0.2.wait; 
	 }); 
     }).start}



 )
