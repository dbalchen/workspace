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
 "/home/dbalchen/workspace/SuperCollider/eStrings.sc".loadPath;
 "/home/dbalchen/workspace/SuperCollider/FMpad.sc".loadPath;
 "/home/dbalchen/workspace/SuperCollider/pulseLead.sc".loadPath;
 "/home/dbalchen/workspace/SuperCollider/drumSampler.sc".loadPath;


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
 ~oboe.amp = 1;
 ~oboe.init;
 ~oboe.filter.attack = 1.0;
 ~oboe.filter.release = 0.50;
 ~oboe.filter.cutoff = 1500;//14000;
 ~oboe.filter.gain = 0.5;
 ~oboe.filter.sustain = 1.0;
 ~oboe.filter.aoc = 0.25;
 ~oboe.envelope.attack = 0.75;//1.0;
 ~oboe.envelope.release = 0.5;
 ~oboe.envelope.decay = 3.0;
 ~oboe.envelope.sustain = 0.1;//0.10;


 ~channel0 = {arg num, vel = 1;
   var ret;
	 //num.postln;
	 //~oboe.amp = ~oboe.amp * vel;
   ret = ~midiPulseLead.value(~oboe,num,0);
   ret;
 };


 ~fm_darkpad = MyEvents.new;
 ~fm_darkpad.amp = 0.40;
 ~channel1 = {arg num, vel =1;
   var ret;
	 //num.postln;
	 //~fm_darkpad.amp = ~fm_darkpad.amp * vel;
   ret = ~midiFMdarkpad1.value(~fm_darkpad,num);
   ret;
 };


 ~fm_darkpad2 = MyEvents.new;
 ~fm_darkpad2.amp = 0.20;
 ~channel11 = {arg num, vel = 1;
   var ret;
	 //num.postln;
	 //~fm_darkpad2.amp = ~fm_darkpad2.amp * vel;
   ret = ~midiFMdarkpad1.value(~fm_darkpad2,num);
   ret;
 };




 ~strings1 = MyEvents.new;
 ~strings1.amp = 1.3;
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
 ~strings1.envelope.sustain = 0.2;
 ~channel2 = {arg num, vel = 1;
   var ret;
   vel.postln;
	 //   ~strings1.amp = ~strings1.amp * vel;
   ret = ~midiStrings.value(~strings1,num,2);
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
 ~strings2.envelope.sustain = 0.2;
 ~channel3 = {arg num, vel = 1;
   var ret;
	 //num.postln;
	 //~strings2.amp = ~strings2.amp * vel;
   ret = ~midiStrings.value(~strings2,num,3);
   ret;
 };


 ~drum = MyEvents.new;
 ~drum.amp = 2.0;
 ~drum.init;
 ~drum.filter.attack = 0.0;
 ~drum.filter.release = 4.0;
 ~drum.filter.cutoff = 8000;
 ~drum.filter.gain = 2.0;
 ~drum.filter.sustain = 1.0;
 ~drum.filter.aoc = 1;
 ~drum.envelope.attack = 0.0;
 ~drum.envelope.release = 8.0;
 ~drum.envelope.decay = 0.0;
 ~drum.envelope.sustain = 1.0;
 ~channel9 = {arg num, vel = 1;
   var ret, amp = 2;
	
   ~drum.amp = amp * vel;
   ret = ~midiDrum.value(~drum,~drumSound,num);
   ret;
 };

 )


 ~drum.unmute;

~strings2.envelope.attack = 0.95;~strings1.envelope.attack = 0.950; ~strings1.envelope.decay = 3.05; ~strings2.envelope.decay = 3.05;

~strings1.envelope.attack = 4.0;~strings2.envelope.attack = 4.0;~strings1.envelope.decay = 4.0; ~strings2.envelope.decay = 4.0;

~strings1.envelope.attack = 0.40;~strings2.envelope.attack = 4.00;~strings1.envelope.decay = 3.60; ~strings2.envelope.decay = 8;

~oboe.filter.makeGui;
~oboe.envelope.envGui;

~startTimer.value(106);
~rp = {}; // Example

~rp = {~myT1.value;};

(
 ~start = {

   var bpm = 106,timeNow;
   t = TempoClock.default.tempo = bpm / 60;

   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

       ~strings1.envelope.attack = 4.0;~strings2.envelope.attack = 4.0;~strings1.envelope.decay = 4.0; ~strings2.envelope.decay = 4.0;

       t.schedAbs(timeNow + ((4*27)-2),{ // 00 = Time in beats 
	   (
         ~strings1.envelope.attack = 2; ~strings1.envelope.decay = 3;
         ~strings2.envelope.attack = 2; ~strings2.envelope.decay = 3;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*33)-2),{ // 00 = Time in beats 
	   (
         ~strings1.envelope.attack = 1; ~strings1.envelope.decay = 2;
         ~strings2.envelope.attack = 1; ~strings2.envelope.decay = 2;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*35)-2),{ // 00 = Time in beats 
	   (
         ~strings1.envelope.attack = 2; ~strings1.envelope.decay = 3;
         ~strings2.envelope.attack = 2; ~strings2.envelope.decay = 3;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*37)-2),{ // 00 = Time in beats 
	   (
         ~strings1.envelope.attack = 1; ~strings1.envelope.decay = 2;
         ~strings2.envelope.attack = 1; ~strings2.envelope.decay = 2;
	    );(nil);};); // End of t.schedAbs
       //Add more 

       t.schedAbs(timeNow + ((4*67)-2),{ // 00 = Time in beats 
	   (
         ~strings1.envelope.attack = 4.0;~strings2.envelope.attack = 4.0;~strings1.envelope.decay = 4.0; ~strings2.envelope.decay = 4.0;
         
	    );(nil);};); // End of t.schedAbs
       //Add more 
     }); // End of Routine

 }; //End of Start

 )


~rp = {~start.value;};
