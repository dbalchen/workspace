// =====================================================================
// Marimba
// =====================================================================

Help.gui
Quarks.gui

s = JStethoscope.defaultServer.boot;
JFreqScope.new( 400, 200, 0 );

(
 SynthDef(\Marimba, {arg out = 0, freq = 440, gate = 1, duration = 1.0, da = 2;
 var op1,op2,op3,op4,op5,op6,env,env1,env2,env3,env4,env5,env6;

 env1 = Env.adsr(0.004,1.0,0,0);
 env2 = Env.adsr(0.0,0.2,0,0);
 env3 = Env.adsr(0,0.30,0,0);
 env4 = Env.adsr(0,0.25,0,0);
 env5 = Env.adsr(0,0.50,0,0);
 op2 = 0.97*SinOsc.ar(freq*3,0,
	 EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da);); 

 op1 = 0.96*SinOsc.ar(freq*0.5,op2,
	 EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da);); 

 op6 = 1.00*SinOscFB.ar(freq*4.52,0,
	 EnvGen.kr(env3, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

 op5 = 0.9*SinOsc.ar(freq*0.75,op6,
	 EnvGen.kr(env4, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););


 op4 = 0.86*SinOsc.ar(freq*4,0,
	 EnvGen.kr(env4, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

 op3 = 1.00*SinOsc.ar(freq*0.5,op4 + op5,
	 EnvGen.kr(env5, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

	 x = (0.15*op3) + (0.18*op1);
	 //x =  (0.15*op5);
 Out.ar(out,x.dup)}).store;
 )



(
 x = Synth("Marimba");
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
	   midi = [60,62,64,69,72,74,76,81].choose;
	   if(~flip.coin, 
	     { 
	       x = z.at(midi);
	       x.set(\gate,0);
			
	       x = Synth("Marimba");
	       x.(\da,1);	
	       x.set(\freq,midi.midicps);
	       z.put(midi,x);
	     }, {["rest"].post}); // false action
	   0.1.wait; 
	 }); 
     }).start}


 )
