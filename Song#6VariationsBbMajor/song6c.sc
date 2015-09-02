Help.gui
Quarks.gui
GUI.qt

(
 o = Server.local.options;
//o.numOutputBusChannels = 24; // The next time it boots, this will take effect
 o.memSize = 2097152;
 )

"/home/dbalchen/Music/setup.sc".loadPath;

(
"/home/dbalchen/Music/Song#6VariationsBbMajor/include/drumTool/eStrings.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/FMpad.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/pulseLead.sc".loadPath;
//"/home/dbalchen/workspace/SuperCollider/FMlead.sc".loadPath;


~myT1 = {Pbind(\type, \midi,
	       \midiout, ~synth1,
	       \midicmd, \noteOn,
	       \note,  Pfunc.new({~t1.freq.next}- 60),
	       \amp, 1,
           \chan, 1,
           \sustain, Pfunc.new({~t1.duration.next}),
	       \dur, Pfunc.new({~t1.wait.next})
	       ).play};
	


~oboe = MyEvents.new;
~oboe.amp = 1.0;
~oboe.init;
~oboe.filter.attack = 1.0;
~oboe.filter.release = 0.50;
~oboe.filter.cutoff = 1500;//14000;
~oboe.filter.gain = 0.5;
~oboe.filter.sustain = 1.0;
~oboe.filter.aoc = 0.25;
~oboe.envelope.attack = 0.75;//1.0;
~oboe.envelope.release = 0.5;
~oboe.envelope.decay = 4.0;
~oboe.envelope.sustain = 0.1;//0.10;


//~pulse = Synth("PulseLead");

~channel0 = {arg num;
	     var ret;
     num.postln;

	// ret = ~midiFMlead.value(~oboe,num);
	ret = ~midiPulseLead.value(~oboe,num);
	//ret = ~midiPulseLeadMono.value(~oboe,num,~pulse);
	     ret;
};


~fm_darkpad = MyEvents.new;
~fm_darkpad.amp = 0.30;
~channel1 = {arg num;
	     var ret;
     num.postln;

	     ret = ~midiFMdarkpad1.value(~fm_darkpad,num);
	     ret;
};

~fm_darkpad2 = MyEvents.new;
~fm_darkpad2.amp = 0.10;
~channel11 = {arg num;
	     var ret;
     num.postln;

	     ret = ~midiFMdarkpad1.value(~fm_darkpad2,num);
	     ret;
};




~strings1 = MyEvents.new;
~strings1.amp = 1.0;
~strings1.init;
~strings1.filter.attack = 0.0;
~strings1.filter.release = 1.5;
~strings1.filter.cutoff = 8000;
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
~strings2.amp = 1.0;
~strings2.init;
~strings2.filter.attack = 0.0;
~strings2.filter.release = 1.5;
~strings2.filter.cutoff = 8000;
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


~strings2.envelope.attack = 1.0;~strings1.envelope.attack = 1.00;
//~strings2.filter.attack = 0.10;~strings1.filter.attack = 0.10;
//~strings2.filter.aoc = 0.2;~strings1.filter.aoc = 0.2;


//~strings1.filter.attack = 0.0;~strings2.filter.attack = 0.0;
//~strings1.filter.aoc = 1;~strings2.filter.aoc = 1;
~strings1.envelope.attack = 4.0;~strings2.envelope.attack = 4.0;



~oboe.filter.makeGui;
~oboe.envelope.envGui;

~startTimer.value(120);
~rp = {}; // Example

~rp = {~myT1.value;};

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
