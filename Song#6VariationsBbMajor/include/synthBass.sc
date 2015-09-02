"/home/dbalchen/workspace/SuperCollider/makeFilter.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/makeWaveTable.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/makeOsc.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/makeEnv.sc".loadPath;

~bass = MyLive.new;
~bass.out = 10;
~bass.waits = [0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5];

~bass.amp = 0.3;

~bass.freqs =  [41,0,0,0,41,0,0,0,46,0,0,0,44,0,46,41,0,0,0,41,0,0,0,46,0,0,0,44,0,46,39,0,0,0,39,0,0,0,44,0,0,0,41,0,44,39,0,0,0,39,0,0,0,44,0,0,0,41,0,44];

~bass.durations = [0.997916666666667,0,0,0,1.0,0,0,0,1.0,0,0,0,0.5,0,0.5,1.0,0,0,0,1.0,0,0,0,1.0,0,0,0,0.5,0,0.5,1.0,0,0,0,0.997916666666667,0,0,0,1.0,0,0,0,0.5,0,0.5,1.0,0,0,0,1.0,0,0,0,1.0,0,0,0,0.5,0,0.497916666666667];

~bass.probs = [1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1]*0;

~bass.probs = [1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1];

~bass.calcWait;
~bass.calcFreq;
~bass.calcDur;

~makeFilter.value("synthFilter",32);
//~makeEnv.value("synthEnv");

~saw = ~makeWav.value("/home/dbalchen/Music/Samples/wavetables/AKWF_bw_saw/AKWF_saw_0017.wav");
~sine = ~makeWav.value("/home/dbalchen/workspace/SuperCollider/Moogy/Samples/Arpsin.aiff");



~synthBass = Group.new;
~filtr = Synth.tail(~synthBass,"synthFilter");
~filtr.set(\filterBus,32);
~filtr.set(\filterOut,~bass.out);
~filtr.set(\da,0);

/*
~env = Synth.tail(~synthBass,"synthEnv");
~env.set(\envIn,30);
~env.set(\eOut,0);
~env.set(\da,0);
*/

~makeOsc.value("Osc1",1);

~osc = Synth.head(~synthBass,"Osc1");
~osc.set(\ss,~saw);
~osc.set(\wiggler,~sine);
~osc.set(\out,32);
~osc.set(\da,0);
//~synthBass.set(\gate,1);


/*
~filterWindow.value("Synth Filter", ~filtr);
~envelopeWindow.value("Synth Env", ~env);
*/

/*
~bassPat = {Pbind(\type, \midi,
	       \midiout, ~synth1,
	       \midicmd, \noteOn,
	       \chan, 1,
	       \note,  Pfunc.new({~bass.freq.next}) - 60,   
	       \amp, Pfunc.new({~bass.amp}),
           \sustain, Pfunc.new({~bass.duration.next}),
	       \dur, Pfunc.new({~bass.wait.next})
	       ).play};

*/

~bassPat = {
  var myTask,x,y;

  myTask = Task({
      var num,sus;
	  //	  s.sync;
      inf.do({ 
	  num =   ~bass.freq.next;
		  sus =   3;//~bass.duration.next;
		  //	      ~synthBass.set(\gate,1);
	  if(num.isMemberOf(Integer),
	    { 
	      ~synthBass.set(\gate,1);
	      ~osc.set(\freq,num.midicps);
          ~osc.set(\amp,~bass.amp); 
           ~osc.set(\dur,sus);


	    }, {["rest"].post}); // false action
	  (~bass.wait.next - 0.1).wait;
	  ~synthBass.set(\gate,0);
          0.1.wait;
	}); 
    }).start};


~synthVals = {
   ~osc.set(\wfreq,80);
   ~osc.set(\wrange,20);
   ~osc.set(\lagt,0.5);
   ~filtr.set(\cutoff,1575);
   ~filtr.set(\gain, 2.4);
   ~filtr.set(\attack, 0.1);
   ~filtr.set(\release, 0.65);
   ~filtr.set(\sustain, 0.60);
   ~filtr.set(\aoc, 0.9);
   ~env.set(\attTime,0.1);
   ~env.set(\decTime,0.2);
   ~env.set(\relTime,3.31);
   ~env.set(\sustain,1);
};