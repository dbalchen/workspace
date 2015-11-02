

~makeFilter = ({arg name, busin = 16, busout= 0;
    SynthDef(name, {
	arg filterBus = busin,filterOut = busout, aoc = 1, attack = 0.1,sustain = 0.7, 
	  release = 0.0, gate = 0, cutoff = 5000, gain = 3.3, da = 0;
	var sig,env;

	env = Env.asr(attack,sustain,release, 1);
	env = EnvGen.kr(env, gate,doneAction:da);
	env = aoc*(env - 1) + 1;

	sig = MoogFF.ar
	  (
	   In.ar([filterBus,filterBus+1]),
	   cutoff*env,
	   gain 
	   );
	Out.ar(filterOut, sig)
	  }).send(s);
  });


///  FILTER GUI WINDOW /////

~filterWindow = 
  {arg name = "Filter",fltr, cutoff = 5000, gain = 2, attack = 0, release = 0.1, sustain = 1, aoc = 1, filterOut = 0;
   var fltWin, nb1, sl1, nb2, sl2, nb3, sl3, nb4, sl4, nb5, sl5, nb6, sl6, output;

   fltr.set(\cutoff,cutoff);
   fltr.set(\gain, gain);
   fltr.set(\attack, attack);
   fltr.set(\release, release);
   fltr.set(\sustain, sustain);
   fltr.set(\aoc, aoc);

   fltWin = Window.new(name,Rect(200,200,372,295)).front;
   StaticText( fltWin, Rect(4, 4, 50, 25 )).align_( \left ).string_( "Cut:" );

   nb1 = NumberBox(fltWin, Rect(240, 4, 53, 25)).value_(cutoff);

   sl1 = Slider(fltWin, Rect(35, 9, 200, 15))
   .value_(nb1.value/10000)
   .action_({
       nb1.value_(sl1.value * 10000);
       fltr.set(\cutoff,nb1.value);
     });

   nb1.action_({
       sl1.value_(nb1.value/10000);
       fltr.set(\cutoff,sl1.value);
     });


   StaticText( fltWin, Rect(4, 30, 50, 25 )).align_( \left ).string_( "Res:" );

   nb2 = NumberBox(fltWin, Rect(240, 30, 53, 25)).value_(gain);

   sl2 = Slider(fltWin, Rect(35, 35, 200, 15))
   .value_(nb2.value/4)
   .action_({
       nb2.value_(sl2.value * 4);
       fltr.set(\gain, nb2.value);
     });

   nb2.action_({
	   
       sl2.value_(nb2.value/4);
       fltr.set(\gain,sl2.value);
     });


   StaticText( fltWin, Rect(4, 56, 50, 25 )).align_( \left ).string_( "Aoc:" );

   nb3 = NumberBox(fltWin, Rect(240, 56, 53, 25)).value_(10*aoc);

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

   nb4 = NumberBox(fltWin, Rect(240, 90, 53, 25)).value_(attack);

   sl4 = Slider(fltWin, Rect(35, 95, 200, 15))
   .value_(nb4.value/10)
   .action_({
       nb4.value_(sl4.value * 10);
       fltr.set(\attack, nb4.value);
     });

   nb4.action_({
       sl4.value_(nb4.value/10);
       fltr.set(\attack, nb4.value);
     });


   StaticText( fltWin, Rect(4, 116, 50, 25 )).align_( \left ).string_( "Dcy:" );
   nb5 = NumberBox(fltWin, Rect(240, 116, 53, 25)).value_(release);

   sl5 = Slider(fltWin, Rect(35, 121, 200, 15))
   .value_(nb5.value/10)
   .action_({
       nb5.value_(sl5.value * 10);
       fltr.set(\release, nb5.value);
     });

   nb5.action_({
       sl5.value_(nb5.value/10);
       fltr.set(\release, nb5.value);
     });


   StaticText( fltWin, Rect(4, 142, 50, 25 )).align_( \left ).string_( "Sus:" );

   nb6 = NumberBox(fltWin, Rect(240, 142, 53, 25)).value_(sustain);

   sl6 = Slider(fltWin, Rect(35, 147, 200, 15))
   .value_(nb6.value)
   .action_({
       nb6.value_(sl6.value);
       fltr.set(\sustain, nb6.value);
     });

   nb6.action_({
       sl6.value_(nb6.value);
       fltr.set(\sustain, nb6.value);
     });


   StaticText( fltWin, Rect(4, 175, 70, 25 )).align_( \left ).string_( "Output:" );
   output = NumberBox(fltWin, Rect(117, 175, 25, 25)).value_(filterOut);

   output.action = {fltr.set(\filterOut,output.value);};

  };

