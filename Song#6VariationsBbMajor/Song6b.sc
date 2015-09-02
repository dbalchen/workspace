Help.gui
Quarks.gui
GUI.qt

(
 o = Server.local.options;
 o.numOutputBusChannels = 24; // The next time it boots, this will take effect
 o.memSize = 2097152;
 )

"/home/dbalchen/Music/setup.sc".loadPath;

(
"/home/dbalchen/workspace/SuperCollider/loadSamples.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/eSampler.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/Rain.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/Thunder.sc".loadPath;
"/home/dbalchen/Music/Song#6VariationsBbMajor/include/drumTool/eStrings.sc".loadPath;
"/home/dbalchen/Music/Song#6VariationsBbMajor/include/drumTool/drums.sc".loadPath;
"/home/dbalchen/Music/Song#6VariationsBbMajor/include/drumTool/strings.sc".loadPath;
"/home/dbalchen/Music/Song#6VariationsBbMajor/include/drumTool/soundEffects.sc".loadPath;
~thunderout = 0;
~rainout = 0;

~bassdrum.out=0;
~snare.out = 2;
~c7.out = 4;
~roll.out = 6;
~crash.out = 8;
~cello.out = 10;
~viola.out = 12;
~violin.out = 14;
~thunderout = 16;
~rainout = 18;
~crowOut = 22;
~gcrashOut = 20;

)  

~c7.envelope.envGui;
~c7.filter.makeGui;

~crash.envelope.envGui;
~crash.filter.makeGui;

~startTimer.value(60);



~rp = {~thunder = Synth("Thunder");~thunder.set(\amp,0.5);~rain = Synth("Rain");~rain.set(\amp,0.15); ~thunder.set(\out,~thunderout);~rain.set(\out,~rainout);};
~rp = {1.wait;~playCrow.play;};
~rp = {1.wait;~playCrow.play;1.wait;~playCrow.play;0.5.wait;~playCrow.play;};
~rp = {1.wait;~runEsampler.value(~bassdrum,~drumSound,~tr808Template,);~runEsampler.value(~snare,~drumSound,~tr808Template,);~runEsampler.value(~c7,~drumSound,~tr808Template,1,9);~runEsampler.value(~roll,~drumSound,~tr808Template,0.85);~runEsampler.value(~crash,~drumSound,~tr808Template,0.85);~null.value(~roll);~null.value(~crash);};

~rp = {0.95.wait;~runEsampler.value(~viola,~violasounds,~violaTemplate);~runEsampler.value(~cello,~cellosounds,~celloTemplate);~runEsampler.value(~violin,~violinsounds,~violinTemplate);~null.value(~viola);~null.value(~violin);~null.value(~cello);};

~reroll.value;
~recrash.value;~null.value(~roll);
~null.value(~crash);

~reroll.value;
~recrash.value;~null.value(~roll);~rp = {1.wait;~playGCrash.play;~playCrow.play;};
~null.value(~crash);


~rp = {1.wait;~playGCrash.play;~playCrow.play;};

~reroll.value;
~recrash.value;~null.value(~roll);~first.value;
~null.value(~crash);

~firstMiddle.value;

~reroll.value;
~recrash.value;~null.value(~roll);~second.value;
~null.value(~crash);

~secMiddle.value;
~secMiddle2.value;

~middle8.value;
~m8d.value;

~rp = {~null.value(~bassdrum);~null.value(~snare);~null.value(~roll);~null.value(~viola);~null.value(~violin);~null.value(~cello);1.wait;~playGCrash.play;~playCrow.play;};


~reroll.value;~null.value(~c7);~tr8.value;
~recrash.value;~null.value(~roll);~main.value;~melEnd.value;
~null.value(~crash);~normal.value;

~secMiddle.value;
~secMiddle2E.value;
~end.value;
~null.value(~bassdrum);~null.value(~snare);~null.value(~roll);

~reroll.value;~endDrums.value;
~recrash.value;~null.value(~roll);
~null.value(~crash);


~rpp = {fork{~playCrow.play; 2.wait;~playCrow.play;1.wait;~playCrow.play;1.wait;~playCrow.play;0.5.wait;~playCrow.play;0.25.wait;~playCrow.play;0125.wait;~playCrow.play;006.wait;~playCrow.play;003.wait;~playCrow.play;0015.wait;~playCrow.play;00075.wait;~playCrow.play;}};

~rpp.value;

~haunting.value;
~null.value(~bassdrum);~null.value(~snare);~null.value(~roll);~null.value(~viola);~null.value(~violin);~null.value(~cello);

~null.value(~bassdrum);~null.value(~snare);~null.value(~roll);~c7.filter.gain = 2.90;

~null.value(~c7);
~c7.filter.gain = 2.90;

~rp ={1.wait;fork{loop{h=[58,60,62,65,68].choose.midicps*(1..3).choose;x = Synth("eStrings");x.set(\freq,h);x.set(\gate,1);8.wait;x.set(\gate,0);}};}; 

~rp ={1.wait;fork{loop{i=[58,60,62,65,68].choose.midicps*(1..2).choose;y = Synth("FMdarkpad1");y.set(\freq,i);y.set(\gate,1);8.wait;y.set(\gate,0);}};};



(

 ~start = {

   var num = 60,timeNow;
   t = TempoClock.default.tempo = num / 60;

   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;
       t.schedAbs(timeNow + 0.9,{ // 00 = Time in beats 
	   (
         ~runEsampler.value(~viola,~violasounds,~violaTemplate);
         ~runEsampler.value(~cello,~cellosounds,~celloTemplate);
         ~runEsampler.value(~violin,~violinsounds,~violinTemplate);
         ~null.value(~viola);~null.value(~violin);~null.value(~cello);
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow + 1,{ // 00 = Time in beats 
	   (
         ~thunder = Synth("Thunder");~thunder.set(\amp,0.5);~rain = Synth("Rain");~rain.set(\amp,0.15); 
         ~thunder.set(\out,~thunderout);~rain.set(\out,~rainout);
         ~playCrow.play;

         ~runEsampler.value(~bassdrum,~drumSound,~tr808Template,);
         ~runEsampler.value(~snare,~drumSound,~tr808Template,);
         ~runEsampler.value(~c7,~drumSound,~tr808Template,1,9);
         ~runEsampler.value(~roll,~drumSound,~tr808Template,0.85);
         ~runEsampler.value(~crash,~drumSound,~tr808Template,0.85);
         ~null.value(~roll);~null.value(~crash);
	    );
 
	   (
	    // If No put stuff here otherwise nil
	    nil
	    );
	 };	 // End of if statement

	 ); // End of t.schedAbs



       t.schedAbs(timeNow + ((15*4)),{ // 00 = Time in beats 
	   (
         ~reroll.value;
	    );   (nil); };); // End of t.schedAbs


       t.schedAbs(timeNow +  ((16*4)),{ // 00 = Time in beats 
	   (
         ~recrash.value;~null.value(~roll);
 
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((16*4)+1),{ // 00 = Time in beats 
	   (
        ~playGCrash.play;~playCrow.play;
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((17*4)),{ // 00 = Time in beats 
	   (
        ~null.value(~crash);
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((23*4)),{ // 00 = Time in beats 
	   (
		   //~reroll.value;
	    );   (nil); };); // End of t.schedAbs


       t.schedAbs(timeNow +  ((24*4)),{ // 00 = Time in beats 
	   (
        ~first.value;
        ~recrash.value;~null.value(~roll);
	    );   (nil); };); // End of t.schedAbs


       t.schedAbs(timeNow +  ((25*4)),{ // 00 = Time in beats 
	   (
        ~null.value(~crash);~first.value;
	    );   (nil); };); // End of t.schedAbs
 
       t.schedAbs(timeNow +  ((32*4)),{ // 00 = Time in beats 
	   (
        ~firstMiddle.value;
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((39*4)),{ // 00 = Time in beats 
	   (
		   //        ~reroll.value;
	    );   (nil); };); // End of t.schedAbs
  

       t.schedAbs(timeNow +  ((40*4)),{ // 00 = Time in beats 
	   (
        ~second.value;
        ~recrash.value;~null.value(~roll);
	    );   (nil); };); // End of t.schedAbs
   

       t.schedAbs(timeNow +  ((41*4)),{ // 00 = Time in beats 
	   (
        ~null.value(~crash);~secMiddle.value;
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((41*4)),{ // 00 = Time in beats 
	   (
         ~secMiddle.value;
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((53*4)),{ // 00 = Time in beats 
	   (
		   ~secMiddle2.value;

	    );   (nil); };); // End of t.schedAbs
       t.schedAbs(timeNow +  ((56*4)),{ // 00 = Time in beats 
	   (
		   ~middle8.value;

	    );   (nil); };); // End of t.schedAbs


       t.schedAbs(timeNow +  ((59*4)),{ // 00 = Time in beats 
	   (
           ~m8d.value;
	    );   (nil); };); // End of t.schedAbs


       t.schedAbs(timeNow +  ((64*4)),{ // 00 = Time in beats 
	   (
           ~null.value(~bassdrum);~null.value(~snare);~null.value(~roll);
           ~null.value(~viola);~null.value(~violin);~null.value(~cello);
	    );   (nil); };); // End of t.schedAbs



       t.schedAbs(timeNow +  ((65*4) + 1),{ // 00 = Time in beats 
	   (
            ~playGCrash.play;~playCrow.play;~c7.filter.gain = 2.90;
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((66*4)-1),{ // 00 = Time in beats 
	   (
        ~null.value(~crash);
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((72*4) - 1),{ // 00 = Time in beats 
	   (
		     ~reroll.value;
	    );   (nil); };); // End of t.schedAbs


       t.schedAbs(timeNow +  ((73*4) - 1),{ // 00 = Time in beats 
	   (
            ~recrash.value;~null.value(~roll);
            ~main.value;~melEnd.value;~c7.filter.gain = 1.0;
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((74*4)-1),{ // 00 = Time in beats 
	   (
        ~null.value(~crash);
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((81*4) - 1),{ // 00 = Time in beats 
	   (
        ~secMiddle.value;  
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((87*4) - 1),{ // 00 = Time in beats 
	   (
         ~secMiddle2E.value;
    
	    );   (nil); };); // End of t.schedAbs

       t.schedAbs(timeNow +  ((88*4) - 1),{ // 00 = Time in beats 
	   (
         ~end.value; ~endDrums.value; 
	    );   (nil); };); // End of t.schedAbs


       t.schedAbs(timeNow +  ((97*4) - 1),{ // 00 = Time in beats 
	   (
			   ~null.value(~bassdrum);~null.value(~snare);~null.value(~roll);~c7.filter.gain = 2.90;
	    );   (nil); };); // End of t.schedAbs


     }); // End of Routine
       //Add more 

 }; //End of Start

 )

~startTimer.value(60);
~rp = {~start.value;};


