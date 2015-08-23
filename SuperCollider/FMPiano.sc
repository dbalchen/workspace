// =====================================================================
// FM Piano
// =====================================================================

Help.gui
Quarks.gui

s = JStethoscope.defaultServer.boot;
JFreqScope.new( 400, 200, 0 );

(
 SynthDef(\FMPiano, {arg out = 0, freq = 440, gate = 1, duration = 2, da = 2;
 var op1,op2,op3,op4,op5,op6,env,env1,env2,env3,env4,env5,env6;

     env1 = Env.adsr(0.0008,1.0,0,0);
     env2 = Env.adsr(0,duration,0,0);

 op2 = 0.58*SinOsc.ar(freq*12,0,
	 EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da);); 

 op1 = SinOsc.ar(freq/(2**(7/1200)),op2,
	 EnvGen.kr(env1, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da);); 

 op4 = 0.89*SinOsc.ar(freq,0,
	 EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

 op3 = SinOsc.ar(freq,op4,
	 EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););


 op6 = 0.79*SinOscFB.ar(freq*(2**(4/1200)),0.40,
	 EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););

 op5 = SinOsc.ar(freq*(2**(7/1200)),op6,
	 EnvGen.kr(env2, gate: gate,  timeScale: duration, levelScale: 0.50,doneAction:da););
	 x = (0.10*op5) + (0.12*op3) + (0.10*op1);

 Out.ar(out,x.dup)}).store;
 )



(
 x = Synth("FMPiano");
 )




// Gui Test

(
 ~flip = 0.30;
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
//  ~tempo = JSCSlider( ~win, Rect( 110, 4, 200, 25 )) 
  .value_( ~density ) // initial slider position
//  .value_( ~tempo ) // initial slider position
  .action_({ arg view;
	        ~density = view.value;
	        ~flip = ~density;

	  //      ~tempo = view.value;
	  //      Tempo.bpm = ~tempo;
    });




z.free;

/// End GUI


 ~routine = {z = Array.newClear(128);
   r = Task({
       inf.do({ arg count;
	   var midi, oct, density;
	   midi = [38,40,45,48,50,52,57,60,62,64,69,72,74,76].choose;
	   if(~flip.coin, 
	     { 
	       x = z.at(midi);
		    x.set(\gate,0);
			
	       x = Synth("FMPiano");
			 //	       x.(\da,1);	
	       x.set(\freq,midi.midicps);
		z.put(midi,x);
	     }, {["rest"].post}); // false action
	   0.2.wait; 
       
	 }); 
     }).start}



 )

