// =====================================================================
// Bell (Wind Chimes)
// =====================================================================

Help.gui
QT.gui

s = JStethoscope.defaultServer.boot;
JFreqScope.new( 400, 200, 0 );

(
 SynthDef(\Bell, {arg out = 0, freq = 440, gate = 1, sustain = 4, amp = 0.35, da = 2;
 var op1,op2,op3,op4,op5,op6,env,env1,env2,env3,env4,env5,env6;

	 env1 = Env.adsr(0.0005,1.25,0,0);
	 env2 = Env.adsr(0,sustain,0,0);
	 env3 = Env.adsr(0,1.0,0,0);
	 env4 = Env.adsr(0,sustain,0,0);
	 env5 = Env.adsr(0.0025,0.75,0,0);
	 env6 = Env.adsr(0,0.01,0,0);

 op2 = 0.78*SinOsc.ar(freq*3.5*(2**(3/1200)),0,
	 EnvGen.kr(env2, gate: gate,  timeScale: sustain, levelScale:0.75,doneAction:da);); 

	 
 op1 = 0.95*SinOsc.ar(freq*(2**(2/1200)),op2,
	 EnvGen.kr(env1, gate: gate,  timeScale: sustain, levelScale: 0.75,doneAction:da););
	  

 op4 = 0.95*SinOsc.ar((freq*3.5)/(2**(2/1200)),0,
	 EnvGen.kr(env4, gate: gate,  timeScale: sustain, levelScale: 0.50,doneAction:da););

 op3 = SinOsc.ar(freq/(2**(5/1200)),op4,
	 EnvGen.kr(env3, gate: gate,  timeScale: sustain, levelScale: 0.50,doneAction:da););


 op6 = 0.85*SinOscFB.ar((freq*2)/(2**(7/1200)),0.70,
	 EnvGen.kr(env6, gate: gate,  timeScale: sustain, levelScale: 0.50,doneAction:da););





	 op5 = SinOsc.ar(323.6*4,op6,
	 EnvGen.kr(env5, gate: gate,  timeScale: sustain, levelScale: 0.50,doneAction:da););

	 x = amp*((0.12*op3) + (0.10*op1) + (0.10*op5));

 Out.ar(out,x.dup)}).store;
 )






// Quick Test
(
 x = Synth("Bell");
 x.set(\midi,[50,52,57,60,62,64].choose);
 x.set(\gate,1);
 //x.set(\gate,0);
 )



(

 ~flip = 0.05;
 ~density = ~flip;
 ~win = Window.new;
 ~win.front;

 //////// adding a two-state button
 
  ~playButton = Button( ~win, Rect( 4, 4, 40, 56 ));
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

  StaticText( ~win, Rect( 56, 4, 50, 25 )).align_( \right ).string_( "Density:" );

  ~density = Slider( ~win, Rect( 110, 4, 200, 25 ))
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
		   //	   midi = [38,40,45,48,50,52,57,60,62,64,69,72,74,76].choose;
       midi = ([50,52,57,60,62,65,69,72,76] + 36).choose;

	   if(~flip.coin, 
	     { 
	       x = z.at(midi);
	       x.set(\gate,0);
			
	       x = Synth("Bell");
	       x.(\da,1);	
	       x.set(\freq,midi.midicps);
	       z.put(midi,x);
	     }, {["rest"].post}); // false action
	   0.2.wait; 
	 }); 
     }).start}
 )
