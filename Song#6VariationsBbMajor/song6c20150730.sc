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
"/home/dbalchen/Music/Song#6VariationsBbMajor/include/drumTool/eStrings.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/FMpad.sc".loadPath;
//"/home/dbalchen/workspace/SuperCollider/pulseLead.sc".loadPath;
//"/home/dbalchen/workspace/SuperCollider/FMlead.sc".loadPath;

~t1 = MyEvents.new;


~t1.waits = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,4.0]; 

~t1.freqs = [[65,72,75,70],0,0,[77,72,63,70],0,0,[77,70,63,60],0,0,[65,72,75,58],0];
~t1.probs = [1,0,0,1,0,0,1,0,0,1,0];
~t1.durations = [8.0,0,0,8.0,0,0,8.0,0,0,8.0,0];

~t1.freqs = [46,43,46,48,43,46,50,48,50,46,0];
~t1.probs = [1,1,1,1,1,1,1,1,1,1,0];
~t1.durations = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,8.0,0] *2;

~t1.freqs = [[63,72,70,53],0,0,0,0,0,0,0,0,0,0] ;
~t1.probs = [1,0,0,0,0,0,0,0,0,0,0];
~t1.durations = [32.0,0,0,0,0,0,0,0,0,0,0];

~t1.freqs = [55,0,0,57,0,0,60,0,0,63,62] + 12;
~t1.probs = [1,0,0,1,0,0,1,0,0,1,1];
~t1.durations = [8.0,0,0,8.0,0,0,8.0,0,0,4.0,4.0] *2;

~t1.freqs = [65,0,0,63,0,0,60,0,0,58,0];
~t1.probs = [1,0,0,1,0,0,1,0,0,1,0];
~t1.durations = [8.0,0,0,8.0,0,0,8.0,0,0,8.0,0] * 1;
~t1.init;


~myT1 = {Pbind(\type, \midi,
	       \midiout, ~synth1,
	       \midicmd, \noteOn,
	       \note,  Pfunc.new({~t1.freq.next}- 60),
	       \amp, 1,
           \chan, 1,
           \sustain, Pfunc.new({~t1.duration.next}),
	       \dur, Pfunc.new({~t1.wait.next})
	       ).play};

~t2 = MyEvents.new;
~t2.waits = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,4.0]; 
~t2.freqs = [[63,72,58,65],0,0,0,0,0,0,0,0,0,0] ;
~t2.probs = [1,0,0,0,0,0,0,0,0,0,0];
~t2.durations = [32.0,0,0,0,0,0,0,0,0,0,0] + 0 ;
~t2.init;
~myT2 = {Pbind(\type, \midi,
	       \midiout, ~synth1,
	       \midicmd, \noteOn,
	       \note,  Pfunc.new({~t2.freq.next}- 60),
	       \amp, 0.25,
           \chan, 11,
           \sustain, Pfunc.new({~t2.duration.next}),
	       \dur, Pfunc.new({~t2.wait.next})
	       ).play};



~oboe = MyEvents.new;
~oboe.amp = 1.00;
~oboe.init;
~oboe.filter.attack = 0.25;
~oboe.filter.release = 0.50;
~oboe.filter.cutoff = 2500;//14000;
~oboe.filter.gain = 1.0;
~oboe.filter.sustain = 0.50;
~oboe.filter.aoc = 0.5;
~oboe.envelope.attack = 0.25;//1.0;
~oboe.envelope.release = 1.5;
~oboe.envelope.decay = 4.0;
~oboe.envelope.sustain = 0.30;//0.10;
~channel0 = {arg num;
	     var ret;
     num.postln;

	//   ret = ~midiFMlead.value(~oboe,num);
		     ret = ~midiPulseLead.value(~oboe,num);
	     ret;
};


~fm_darkpad = MyEvents.new;
~fm_darkpad.amp = 0.10;
~channel1 = {arg num;
	     var ret;
     num.postln;

	     ret = ~midiFMdarkpad1.value(~fm_darkpad,num);
	     ret;
};

~fm_darkpad2 = MyEvents.new;
~fm_darkpad2.amp = 0.20;
~channel11 = {arg num;
	     var ret;
     num.postln;

	     ret = ~midiFMdarkpad1.value(~fm_darkpad2,num);
	     ret;
};




~strings1 = MyEvents.new;
~strings1.amp = 2;
~strings1.init;
~strings1.filter.attack = 0.0;
~strings1.filter.release = 0.5;
~strings1.filter.cutoff = 10000;
~strings1.filter.gain = 1.0;
~strings1.filter.sustain = 1.0;
~strings1.filter.aoc = 1;
~strings1.envelope.attack = 4.0;
~strings1.envelope.release = 0.50;
~strings1.envelope.decay = 4.0;
~strings1.envelope.sustain = 0.3;
~channel2 = {arg num;
	     var ret;
     num.postln;
	     ret = ~midiStrings.value(~strings1,num);
	     ret;
};


~strings2 = MyEvents.new;
~strings2.amp = 2;
~strings2.init;
~strings2.filter.attack = 0.0;
~strings2.filter.release = 0.5;
~strings2.filter.cutoff = 10000;
~strings2.filter.gain = 1.0;
~strings2.filter.sustain = 1.0;
~strings2.filter.aoc = 1;
~strings2.envelope.attack = 4.0;
~strings2.envelope.release = 0.50;
~strings2.envelope.decay = 4.0;
~strings2.envelope.sustain = 0.3;
~channel3 = {arg num;
	     var ret;
     num.postln;
	     ret = ~midiStrings.value(~strings2,num);
	     ret;
};




)

~startTimer.value(120);
~rp = {}; // Example

~rp = {~myT1.value;~myT2.value;};

(
 ~start = {

   var bpm = 120,timeNow;
   t = TempoClock.default.tempo = bpm / 60;

   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

       t.schedAbs(timeNow + 00,{ // 00 = Time in beats 
	   (
		   fork{loop{h=[65,63,60,58].choose.midicps*(2..3).choose;x = Synth("eStrings");x.set(\freq,h);x.set(\gate,1);16.wait;x.set(\gate,0);}};
		   //~myT1.value;~myT2.value;~myT3.value;~myT4.value;
		   ~myT1.value;~myT2.value;
	    );
 
	   (
	    // If No put stuff here otherwise nil
	    nil
	    );
	 };	 // End of if statement

	 ); // End of t.schedAbs


       //Add more 

     }); // End of Routine

 }; //End of Start

 )


~rp = {~start.value;};
