
GUI.qt
Quarks.gui

(

 ~makeEnv = {arg name;

   SynthDef(name, {arg envIn = 48, eOut = 0, attTime = 0.5, decTime = 1.0, relTime = 5, gate = 0, sustain = 1, da = 0;

       var env,sig;

       env = Env.adsr(attTime,decTime,sustain,relTime);
       env = EnvGen.kr(env, gate: gate, levelScale:0.75,doneAction:da);

       sig = In.ar([envIn,envIn + 1]) * env;
       Out.ar(eOut,sig);
     }).send(s);

 };


 ~makeMod = ({arg name;

     SynthDef(name, {
	 arg freq = 0, out = 64, oscSel = 0, amp = 100;
	 var sig, oscArray;	 

	 oscArray = [
		     SinOsc.kr(freq),
		     Pulse.kr(freq,0.5),
		     LFNoise0.ar(freq),
		     LFNoise1.ar(freq),
		     LFNoise2.ar(freq)
		     ];

	 sig = Select.kr(oscSel,oscArray);

	 sig = amp*sig;

	 Out.kr(out,sig);
	 
       }).send(s);
   });


 ~makeOsc = ({arg name, disp = 1;

     SynthDef(name, {
	 arg pan = 0, busIn = 64, freq = 110, out = 16, oscSel = 1, amp = 0.5, lagLev = 0.0, range = 1;
	 var osc, sig, oscArray, phase = 0;

	 freq = (freq * range) + In.kr(busIn);
	 freq = {freq * LFNoise2.kr(1,0.01,1) } ! disp;
	 oscArray = [
		     LFTri.ar(Lag.kr(freq, lagLev),phase,mul: 1),
		     LFSaw.ar(Lag.kr(freq, lagLev),phase),
		     Pulse.ar(Lag.kr(freq, lagLev),0.1,mul: 1),
		     Pulse.ar(Lag.kr(freq, lagLev),0.5,mul: 1),
		     SinOsc.ar(Lag.kr(freq, lagLev),phase,mul: 1),
		     WhiteNoise.ar(1),
		     PinkNoise.ar(1),
		     BrownNoise.ar(1),
		     GrayNoise.ar(1)
		     ];

	 sig = Select.ar(oscSel,oscArray);

	 sig = Splay.ar(sig);

	 sig = amp*Pan2.ar(sig,pan);
	 
	 Out.ar(out,sig);
	 
       }).send(s);
   });

 ~makeFlt = ({arg name;
     SynthDef(name, {arg filterBus = 16,filterOut = 48, aoc = 1, fattack = 2.5,fsustain = 0.7, frelease = 2.0,gate = 0, fcutoff = 5000,fgain = 3.3,da = 0;
	 var sig,env;

	 env = Env.asr(fattack,fsustain,frelease, 1);
	 env = EnvGen.kr(env, gate,doneAction:da);
     env = aoc*(env - 1) + 1;

		 //env = (aoc*env) + (1 - aoc);

	 sig = MoogFF.ar(
			 In.ar([filterBus,filterBus+1]),
			 fcutoff*env,
			 fgain);
	 Out.ar(filterOut, sig)
	   }).send(s);
   });



 ~envWin = {arg name = "Env",env;
   var envWin, nb1, sl1, nb2, sl2, nb3, sl3, nb4, sl4, nb5, sl5, nb6, sl6, output;

   env.set(\attTime,0);
   env.set(\decTime,0.1);
   env.set(\sustain,1.0);
   env.set(\relTime, 0.1);

   envWin = Window.new(name,Rect(200,200,305,155)).front;
   StaticText( envWin, Rect(4, 4, 50, 25 )).align_( \left ).string_( "Atk:" );

   nb1 = NumberBox(envWin, Rect(240, 4, 53, 25)).value_(0);
   sl1 = Slider(envWin, Rect(35, 9, 200, 15))
     .value_(nb1.value/10)
     .action_({
	 nb1.value_(sl1.value * 10);
	 env.set(\attTime,nb1.value);
       });

   nb1.action_({
       sl1.value_(nb1.value/10);
       env.set(\attTime,sl1.value);
     });


   StaticText( envWin, Rect(4, 32, 50, 25 )).align_( \left ).string_( "Dcy:" );
   nb2 = NumberBox(envWin, Rect(240, 30, 53, 25)).value_(0.1);

   sl2 = Slider(envWin, Rect(35, 37, 200, 15))
     .value_(nb2.value/10)
     .action_({
	 nb2.value_(sl2.value * 10);
	 env.set(\decTime, nb2.value);
       });

   nb2.action_({
	   
       sl2.value_(nb2.value/10);
       env.set(\decTime,sl2.value);
     });


   StaticText( envWin, Rect(4, 58, 50, 25 )).align_( \left ).string_( "Sus:" );
   nb3 = NumberBox(envWin, Rect(240, 58, 53, 25)).value_(1);

   sl3 = Slider(envWin, Rect(35, 63, 200, 15))
     .value_(1)
     .action_({
	 nb3.value_(sl3.value);
	 env.set(\sustain, nb3.value);
       });

   nb3.action_({
       sl3.value_(nb3.value);
       env.set(\sustain, nb3.value);
     });

   StaticText( envWin, Rect(4, 84, 50, 25 )).align_( \left ).string_( "Rel:" );
   nb4 = NumberBox(envWin, Rect(240, 84, 53, 25)).value_(0.1);

   sl4 = Slider(envWin, Rect(35, 89, 200, 15))
     .value_(nb4.value/10)
     .action_({
	 nb4.value_(sl4.value * 10);
	 env.set(\relTime, nb4.value);
       });

   nb4.action_({
       sl4.value_(nb4.value/10);
       env.set(\relTime, nb4.value);
     });

   StaticText( envWin, Rect(4, 117, 70, 25 )).align_( \left ).string_( "Output:" );
   output = NumberBox(envWin, Rect(117, 117, 25, 25)).value_(0);

   output.action = {env.set(\eOut,output.value);};

 };



 ~modWin = {arg name = "Mod", modu;

   var modWin,  but1, but3, nb1, sl1, nb2, sl2, output, range;

   modu = Synth("Mod");
   modu.set(\freq,10);
   modu.set(\amp,1);
   modu.set(\oscSel,0);

   modWin = Window.new(name,Rect(200,200,372,295)).front;


   but1 = PopUpMenu(modWin, Rect(30, 30, 105, 30))
     .items_(["Sine","Square", "Noise1", "Noise2", "Noise3"]);


   but1.action = {
   modu.free;
   modu = Synth("Mod");
   modu.set(\freq,nb1.value);
   modu.set(\amp,nb2.value);
   modu.set(\oscSel,but1.value)
}; 
 

   StaticText( modWin, Rect(55, 4, 70, 25 )).align_( \left ).string_( "Waveform" );


   StaticText( modWin, Rect(170, 4, 70, 25 )).align_( \left ).string_( "Range" );
   but3 = PopUpMenu(modWin, Rect(165, 30, 100, 30))
     .value_(3)
     .items_(["Low","0","1","-1","2","-2","3"]);

   but3.action = { 
     if(but3.value == 0, {
	 range = 0;
       });

     if(but3.value == 1, {
	 range = 1;
       });

     if(but3.value == 2, {
	 range = 2;
       });

     if(but3.value == 3, {
	 range = 0.5;
       });

     if(but3.value == 4, {
	 range = 3;
       });

     if(but3.value == 5, {
	 range = 0.125;
       });

     if(but3.value == 6, {
	 range = 4;
       });
     modu.set(\mrange,range);  
   };

   StaticText( modWin, Rect(4, 95, 50, 25 )).align_( \left ).string_( "Frq:" );
   nb1 = NumberBox(modWin, Rect(240, 95, 30, 25)).value_(10);
   sl1 = Slider(modWin, Rect(34, 100, 200, 15))
     .value_(nb1.value/100)
     .action_({
	 nb1.value_(sl1.value * 100);
	 modu.set(\freq,nb1.value);
       });

   nb1.action_({
       sl1.value_(nb1.value/100);
       modu.set(\freq,nb1.value);
     });


   StaticText( modWin, Rect(4, 130, 50, 25 )).align_( \left ).string_( "Amp:" );
   nb2 = NumberBox(modWin, Rect(240, 130, 30, 25)).value_(1);
   sl2 = Slider(modWin, Rect(34, 135, 200, 15))
     .value_(nb2.value/200)
     .action_({
	 nb2.value_(sl2.value * 200);
	 modu.set(\amp,nb2.value);
       });

   nb2.action_({
       sl2.value_(nb2.value/200);
       modu.set(\amp,nb2.value);
     });

   StaticText( modWin, Rect(4, 175, 70, 25 )).align_( \left ).string_( "Output:" );
   output = NumberBox(modWin, Rect(117, 175, 25, 25)).value_(64);

   output.action = {modu.set(\out,output.value);};
 };




 ~fltrWin = {arg name = "Filter",fltr;
   var fltWin, nb1, sl1, nb2, sl2, nb3, sl3, nb4, sl4, nb5, sl5, nb6, sl6, output;

	 fltr.set(\fcutoff,5000);
	 fltr.set(\fgain, 2);
	 fltr.set(\fattack, 0);
	 fltr.set(\frelease, 0.1);
     fltr.set(\fsustain, 1);
     fltr.set(\aoc, 1);
   fltWin = Window.new(name,Rect(200,200,372,295)).front;
   StaticText( fltWin, Rect(4, 4, 50, 25 )).align_( \left ).string_( "Cut:" );

   nb1 = NumberBox(fltWin, Rect(240, 4, 53, 25)).value_(5000);
   sl1 = Slider(fltWin, Rect(35, 9, 200, 15))
     .value_(nb1.value/10000)
     .action_({
	 nb1.value_(sl1.value * 10000);
	 fltr.set(\fcutoff,nb1.value);
       });

   nb1.action_({
       sl1.value_(nb1.value/10000);
       fltr.set(\fcutoff,sl1.value);
     });


   StaticText( fltWin, Rect(4, 30, 50, 25 )).align_( \left ).string_( "Res:" );
   nb2 = NumberBox(fltWin, Rect(240, 30, 53, 25)).value_(2);

   sl2 = Slider(fltWin, Rect(35, 35, 200, 15))
     .value_(nb2.value/4)
     .action_({
	 nb2.value_(sl2.value * 4);
	 fltr.set(\fgain, nb2.value);
       });

   nb2.action_({
	   
       sl2.value_(nb2.value/4);
       fltr.set(\fgain,sl2.value);
     });


   StaticText( fltWin, Rect(4, 56, 50, 25 )).align_( \left ).string_( "Aoc:" );
   nb3 = NumberBox(fltWin, Rect(240, 56, 53, 25)).value_(10);

   sl3 = Slider(fltWin, Rect(35, 61, 200, 15))     
     .value_(nb3.value/10)
     .action_({
	 nb3.value_(sl3.value * 10);
      fltr.set(\aoc, nb3.value/10);
       });

   nb3.action_({
       sl3.value_(nb3.value/10);
      fltr.set(\aoc, nb3.value/10);
     });

   StaticText( fltWin, Rect(4, 90, 50, 25 )).align_( \left ).string_( "Atk:" );
   nb4 = NumberBox(fltWin, Rect(240, 90, 53, 25)).value_(0);

   sl4 = Slider(fltWin, Rect(35, 95, 200, 15))
     .value_(nb4.value/10)
     .action_({
	 nb4.value_(sl4.value * 10);
	 fltr.set(\fattack, nb4.value);
       });

   nb4.action_({
       sl4.value_(nb4.value/10);
       fltr.set(\fattack, nb4.value);
     });


   StaticText( fltWin, Rect(4, 116, 50, 25 )).align_( \left ).string_( "Dcy:" );
   nb5 = NumberBox(fltWin, Rect(240, 116, 53, 25)).value_(0.1);

   sl5 = Slider(fltWin, Rect(35, 121, 200, 15))
     .value_(nb5.value/10)
     .action_({
	 nb5.value_(sl5.value * 10);
	 fltr.set(\frelease, nb5.value);
       });

   nb5.action_({
       sl5.value_(nb5.value/10);
       fltr.set(\frelease, nb5.value);
     });


   StaticText( fltWin, Rect(4, 142, 50, 25 )).align_( \left ).string_( "Sus:" );
   nb6 = NumberBox(fltWin, Rect(240, 142, 53, 25)).value_(1);

   sl6 = Slider(fltWin, Rect(35, 147, 200, 15))
     .value_(nb6.value)
     .action_({
	 nb6.value_(sl6.value);
	 fltr.set(\fsustain, nb6.value);
       });

   nb6.action_({
       sl6.value_(nb6.value);
       fltr.set(\fsustain, nb6.value);
     });


   StaticText( fltWin, Rect(4, 175, 70, 25 )).align_( \left ).string_( "Output:" );
   output = NumberBox(fltWin, Rect(117, 175, 25, 25)).value_(0);

   output.action = {fltr.set(\filterOut,output.value);};

 };


 ~makeOscWin = {arg name,synth;
   var nb1,nb2,but1,but2,but3,sl1,sl2,output = 0,range=1,oscWin;
   //   ~makeOsc.value(name);
   oscWin = Window.new(name,Rect(200,200,272,195)).front;
   
   but1 = Button( oscWin, Rect( 4, 30, 35, 30 )).
     states = [[ "On"],
	       [ "Off", Color.white, Color.red]];

   but1.action = { 
	  
     if(   but1.value == 1, {
	 synth.set(\amp,1);
       }, {
	 synth.set(\amp,0);
	 but2.value = 0;
	 but3.value = 0;
       })
	  
       };

   StaticText( oscWin, Rect(55, 4, 70, 25 )).align_( \left ).string_( "Waveform" );

   but2 = PopUpMenu(oscWin, Rect(50, 30, 105, 30))
     .items_(["Triangle","Saw","Pulse","Square","Sine","White Noise", "Pink Noise", "Brown Noise", "Gray Noise"]);

   but2.action = { synth.set(\oscSel,but2.value)};

   StaticText( oscWin, Rect(170, 4, 70, 25 )).align_( \left ).string_( "Range" );
   but3 = PopUpMenu(oscWin, Rect(165, 30, 100, 30))
     .value_(3)
     .items_(["0","1","-1","2","-2","3","-3"]);

   but3.action = { 
     if(but3.value == 0, {
	 range = 1;
       });

     if(but3.value == 1, {
	 range = 2;
       });

     if(but3.value == 2, {
	 range = 0.5;
       });

     if(but3.value == 3, {
	 range = 3;
       });

     if(but3.value == 4, {
	 range = 0.25;
       });

     if(but3.value == 5, {
	 range = 4;
       });

     if(but3.value == 6, {
	 range = 0.125;
       });
     synth.set(\range,range);  
   };

   StaticText( oscWin, Rect(4, 95, 50, 25 )).align_( \left ).string_( "Vol:" );
   nb1 = NumberBox(oscWin, Rect(240, 95, 25, 25)).value_(5);
   sl1 = Slider(oscWin, Rect(30, 100, 200, 15))
     .value_(nb1.value/10)
     .action_({
	 nb1.value_(sl1.value * 10);
	 synth.set(\amp,sl1.value);
       });

   nb1.action_({
       sl1.value_(nb1.value/10);
       synth.set(\amp,sl1.value);
     });


   StaticText( oscWin, Rect(4, 125, 50, 25 )).align_( \left ).string_( "Frq:" );
   nb2 = NumberBox(oscWin, Rect(240, 125, 25, 25)).value_(0);

   sl2 = Slider(oscWin, Rect(30, 130, 200, 15))
     .value_(0.5)
     .action_({
	 nb2.value_((sl2.value * 100) - 50);
	 synth.set(\range,range * (2**(((sl2.value*100)-50)/1200)));
       });

   nb2.action_({
	   
       sl2.value_((nb2.value + 50)/100);
       synth.set(\range,range * (2**(((sl2.value*100)-50)/1200)));
     });

   StaticText( oscWin, Rect(4, 155, 70, 25 )).align_( \left ).string_( "Output:" );
   output = NumberBox(oscWin, Rect(117, 155, 25, 25)).value_(16);

   output.action = {synth.set(\out,output.value);};
 };
 )



(
 
 ~makeEnv.value("Env");
 q = Synth("Env");
 ~envWin.value("Env",q);

 ~makeFlt.value("Filter");
 y = Synth("Filter"); //filter
 ~fltrWin.value("Filter",y);

 ~makeOsc.value("Osc1",24);
 x = Synth("Osc1");
 ~makeOscWin.value("Osc1",x);

 ~makeMod.value("Mod");
// z = Synth("Mod");
 ~modWin.value("Mod",z);


 )


(
 ~makeOsc.value("Osc1");
 ~makeFlt.value("Filter");
 ~makeMod.value("Mod");
 ~makeEnv.value("Env");
 )

(
 q = Synth("Env");
 y = Synth("Filter"); //filter
 x = Synth("Osc1",3); 
 z = Synth("Mod");
 )

(
~myTask = Task.new({
	//z.set(\freq,10);
 x.set(\freq,110);
z.set(\freq,110);
 y.set(\filterOut,48);
 x.set(\out,16);
	//z.set(\amp,1);
	// z.set(\oscSel,2);

{ 

 y.set(\gate,0);
	// 1.wait;
 z.set(\gate,0);
 q.set(\gate,0);
 0.125.wait;
 
 z.set(\gate,1);
 y.set(\gate,1);
 q.set(\gate,1);

 0.5.wait;
 
}.loop;

  });

~myTask.play;
)


(

y.set(\gate,0);
 z.set(\gate,0);
 q.set(\gate,0);
)