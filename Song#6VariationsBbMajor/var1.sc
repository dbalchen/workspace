Help.gui
Quarks.gui
GUI.qt

(
 o = Server.local.options;
 o.numOutputBusChannels = 24; // The next time it boots, this will take effect
 o.memSize = 2097152;
 )

 "/home/dbalchen/Music/Song#6VariationsBbMajor/setup.sc".loadPath;


(

"/home/dbalchen/Music/Song#6VariationsBbMajor/include/synthBass.sc".loadPath;
"/home/dbalchen/Music/Song#6VariationsBbMajor/include/bassdrum.sc".loadPath;
"/home/dbalchen/Music/Song#6VariationsBbMajor/include/melody.sc".loadPath;
"/home/dbalchen/Music/Song#6VariationsBbMajor/include/shakey.sc".loadPath;

/*
~clickPat = {Pbind(\type, \midi,
	       \midiout, ~synth1,
	       \midicmd, \noteOn,
	       \chan, 0,
	       \note,  Pfunc.new({~click.freq.next}) - 60,   
	       \amp, Pfunc.new({~click.amp}),
           \sustain, Pfunc.new({~click.duration.next}),
	       \dur, Pfunc.new({~click.wait.next})
	       ).play};
	
	*/
/*
~clickPat = {Pbind(
	       \note,  Pfunc.new({~ds0.freq.next}) - 60,   
	       \amp, Pfunc.new({~ds0.amp}),
           \sustain, Pfunc.new({~click.duration.next}),
		   \instrument, \Sawlead,
	       \dur, Pfunc.new({~click.wait.next})
	       ).play};
	*/
)


~startTimer.value(120);

~rp = {~monoSynth.value(~ds0,"Oboe",~oboe);~polySynth.value(~ds1,"Oboe",~oboe);~polySynth.value(~ds2,"Oboe",~oboe);~monoSynth.value(~ds3,"Oboe",~oboe);~monoSynth.value(~vv,"Oboe",~clar)};


~rp = {~monoSynth.value(~ds0,"Oboe",~oboe)};
~ds0.filter.makeGui;
~ds0.envelope.envGui;


~rp = {~polySynth.value(~ds1,"Oboe",~oboe)};
~rp = {~runEsampler.value(~ds1,~oboesounds,~oboeTemplate)};
~ds1.filter.makeGui;
~ds1.envelope.envGui;

~rp = {~runSampler.value(~shakey,~tr808sounds,~tr808Template,"808");~bassdPat.value;};

~rp = {~polySynth.value(~vv,"Oboe",~clar)};

~rp = {~bassPat.value;~synthVals.value;};

~rp = {~monoSynth.value(~vv,"Oboe",~clar);};
~vv.filter.makeGui;
~vv.envelope.envGui;
~vv.envelope.rel;

~rp = {~polySynth.value(~ds2,"Oboe",~oboe)};
~rp = {~runEsampler.value(~ds2,~oboesounds,~oboeTemplate)};
~ds2.filter.makeGui;
~ds2.envelope.envGui;

~rp = {~ds2.amp = 0;~monoSynth.value(~ds3,"Oboe",~oboe)};
~ds3.filter.makeGui;
~ds3.envelope.envGui;

~rp = {~ds1.amp = 0.7;};
~rp = {~ds1.amp = 0.0;~ds2.amp = 0.0;};
~rp = {~ds1.amp = 0.5;~ds2.amp = 0.7;};
~rp = {~ds1.amp = 0.0;};
~rp = {~ds2.amp = 0.8;};
~rp = {~ds2.amp = 0.0;};
~rp = {~ds0.amp = 0.0;};
~rp = {~vv.amp = 0.0;};

~rp = {~ds0.amp = 0.6;};
~rp = {~vv.amp = 0.7;};


~rp = {~ds1.amp = 0.0;~ds2.amp = 0.0;~ds3.amp = 0.6;};
~rp = {~ds3.amp = 0.0;~ds1.amp = 0.6;~ds2.amp = 0.6;};

~rp = {~ds1.amp = 0.0;};
~rp = {~ds2.amp = 0.0;};
~rp = {~ds3.amp = 0.0;};

(

   ~vv.out = 0;
   ~ds0.out = 2;
   ~ds1.out = 4;
   ~ds2.out = 6;
   ~ds3.out = 8;
   ~bass.out = 10;
   ~bassd.out = 12;
   ~shakey.out = 14;
   ~dss1.out = 16;
   ~dss2.out = 18;

)

(
 ~start = {
   var timeNow;



   t = TempoClock.default.tempo = 120 / 60;

   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

       t.schedAbs(timeNow + 0,{(
		   
		   //	   ~monoSynth.value(~ds0,"Oboe",~oboe);
		   //   	   ~runEsampler.value(~dss1,~violinsounds,~violinTemplate);
		   ~runEsampler.value(~dss2,~cellosounds,~celloTemplate);
		   /*
		   ~polySynth.value(~ds1,"Oboe",~ssaw);
		   ~polySynth.value(~ds2,"Oboe",~oboe);
		   ~monoSynth.value(~ds3,"Oboe",~oboe);
		   ~monoSynth.value(~vv,"Oboe",~clar);
		   */
			    );nil});

      t.schedAbs(timeNow + 76,{(
		  // ~runSampler.value(~shakey,~tr808sounds,~tr808Template,"808");
		  //  ~bassdPat.value;
			    );nil});
      t.schedAbs(timeNow + 108,{(
		  //		  		~bassPat.value;
		  //	~synthVals.value;
			    );nil});

	   // The end
     });};

 )


~rp = {~start.value;};