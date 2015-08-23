 ~makeEnv = {arg name;

   SynthDef(name, {arg envIn = 48, eOut = 0, attTime = 0.5, decTime = 1.0, relTime = 5, gate = 0, sustain = 1, da = 0;

       var env,sig;

       env = Env.adsr(attTime,decTime,sustain,relTime);
       env = EnvGen.kr(env, gate: gate, levelScale:0.75,doneAction:da);

       sig = In.ar([envIn,envIn + 1]) * env;
       Out.ar(eOut,sig);
     }).send(s);

 };

 ~envelopeWindow = {arg name = "Env",env;
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



