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
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/melody.sc".loadPath;
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/drums.sc".loadPath;


 ~myT1 = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~t1.freq.next}- 60),
		\amp, 1,
		\chan, 1,
		\sustain, Pfunc.new({~t1.duration.next}),
		\dur, Pfunc.new({~t1.wait.next})
		).play};
	
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


 )


~startTimer.value(106);

~rp = {~midiMelody.value;};

~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;
~tom1.amp = 0;~tom2.amp = 0;~tom3.amp = 0;
~snare.amp = 0;
~ride.amp = 0;
~snare.amp = 1;
~ride.amp = 4;
~melody.amp = 0;
~rp = {~midiBassDrum.value;~midiSnare.value; ~midiToms.value;~midiCyms.value;};

~rp = {~tom1.amp = 0;~tom2.amp = 0;~tom3.amp = 0;0.2.wait;~monoPulseLead.value(~melody);};

~bassd.filter.gui;~bassd.envelope.gui;
~snare.filter.gui;~snare.envelope.gui;
~ride.filter.gui;~ride.envelope.gui;

~tom1.filter.gui;~tom1.envelope.gui;
~melody.envelope.gui;~melody.filter.gui;
~bassd.probs = [1.00,0.00,0.00,0.00,0.00,1.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00] * 1.0;

~tom1.probs = ([0.00,0.80,0.00,1.00,0.40,0.00,0.60,0.00,1.00,0.60,1.00,0.00,0.80,0.80,0.40]  * (Array.fill(15, { arg i; i/15;}))) + ( [0.00,0.00, 0.00,1.00, 0.00, 0.00,0.00, 0.00,1.00, 0.00, 1.00, 0.00,0.00, 1.00,0.00] * 1.0);

~bassd.probs = [1.00,0.00,0.00,0.00,0.00,1.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00] * 1.0;~snare.amp = 0;~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;

~bassd.probs = [1.00,0.00,0.0,0.00,0.00,1.00,0.00,1.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00] * 1.0;~tom1.amp = 0;~tom2.amp = 0;~tom3.amp = 0;~ride.amp = 3;~snare.amp = 1;

(
 ~start = {

   var bpm = 106,timeNow;
   t = TempoClock.default.tempo = bpm / 60;

   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

       //       ~strings1.envelope.attack = 4.0;~strings2.envelope.attack = 4.0;~strings1.envelope.decay = 4.0; ~strings2.envelope.decay = 4.0;

       ~midiBassDrum.value;~midiSnare.value;
       ~midiToms.value;
       ~midiCyms.value;//~midiMelody.value;

       0.2.wait;
       ~monoPulseLead.value(~melody);

       t.schedAbs(timeNow + ((4*27)-2),{ // 00 = Time in beats 
	   (
	    //         ~strings1.envelope.attack = 2; ~strings1.envelope.decay = 3;
	    // ~strings2.envelope.attack = 2; ~strings2.envelope.decay = 3;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*33)-2),{ // 00 = Time in beats 
	   (
	    //~strings1.envelope.attack = 1; ~strings1.envelope.decay = 2;
	    //~strings2.envelope.attack = 1; ~strings2.envelope.decay = 2;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*35)-2),{ // 00 = Time in beats 
	   (
	    //~strings1.envelope.attack = 2; ~strings1.envelope.decay = 3;
	    ///~strings2.envelope.attack = 2; ~strings2.envelope.decay = 3;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*37)-2),{ // 00 = Time in beats 
	   (
	    //~strings1.envelope.attack = 1; ~strings1.envelope.decay = 2;
	    //~strings2.envelope.attack = 1; ~strings2.envelope.decay = 2;
	    );(nil);};); // End of t.schedAbs
       //Add more 

       t.schedAbs(timeNow + ((4*67)-2),{ // 00 = Time in beats 
	   (
	    //~strings1.envelope.attack = 4.0;~strings2.envelope.attack = 4.0;~strings1.envelope.decay = 4.0; ~strings2.envelope.decay = 4.0;
         
	    );(nil);};); // End of t.schedAbs
       //Add more 
     }); // End of Routine

 }; //End of Start

 )


~rp = {~start.value;};
