Help.gui
Quarks.gui
GUI.qt

(
 o = Server.local.options;
 o.numOutputBusChannels = 26; // The next time it boots, this will take effect
 o.memSize = 2097152;
 )

"/home/dbalchen/Music/setup.sc".loadPath;

(
~startup = {

(

 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/melody.sc".loadPath;
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/drums.sc".loadPath;
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/stringbass.sc".loadPath;
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/strings.sc".loadPath;
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/pads.sc".loadPath;

 ~bassd.out = 2;
 ~tom1.out = 4;
 ~tom2.out = 6;
 ~tom3.out = 8;
 ~snare.out = 10;
 ~ride.out = 12;
 ~crash.out = 14;
 ~melody.out = 16;
 ~strings1.out = 18;
 ~strings2.out = 20;
 ~dark_pad.out = 22;
 ~chord.out = 24;

 )

};
)

~startTimer.value(106);

~rp = {~midiString2.value;~midiString1.value;}

~rp = {~mididark_pad.value;}
~rp = {~midichord.value;}


~rp = {~monoPulseLead.value(~melody);};

~playStringbass.value;

~rp = {~midiBassDrum.value;~midiSnare.value; ~midiToms.value;~midiCyms.value;};

~rp = {~tom1.amp = 0;~tom2.amp = 0;~tom3.amp = 0;0.2.wait;~monoPulseLead.value(~melody);};

~bassd.filter.gui;~bassd.envelope.gui;
~snare.filter.gui;~snare.envelope.gui;
~ride.filter.gui;~ride.envelope.gui;

~tom1.filter.gui;~tom1.envelope.gui;
~melody.envelope.gui;~melody.filter.gui;


~rp = {~tomBegin.value;};

~tomMid.value;
~tomend1.value;
~tomend2.value;
~mainDrum = {~bassd.probs = [1.00,0.00,0.0,0.00,0.00,1.00,0.00,1.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00] * 1.0;~snare.probs = ~snaremain;~tom1.amp = 0
~mainDume.value;

~roleOn  = {~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1};
~roleOff = {~tom1.amp = 0;~tom2.amp = 0;~tom3.amp = 0};

~roleOn.value;
~roleOff.value;



(

 ~start = {

   var bpm = 106,timeNow,bass;
   t = TempoClock.default.tempo = bpm / 60;


   ~startup.value;
   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

	   ~playStringbass.play;
               ~strings1.envelope.attack = 0.55;~strings1.envelope.release = 0.9;~strings1.envelope.decay = 0.650;~strings1.amp = 1.50;
           ~strings2.envelope.attack = 0.55;~strings2.envelope.release = 0.9;~strings2.envelope.decay = 0.650;~strings2.amp = 1.50;
       t.schedAbs(timeNow + ((4*3)-0.2),{ // 00 = Time in beats 
	   (
		 ~midiBassDrum.value;~midiSnare.value; ~midiToms.value;~midiCyms.value;~midiString2.value;~midiString1.value;~mididark_pad.value;~midichord.value;~midiCrash.value;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((19*4)-0.2),{ // 00 = Time in beats 
	   (
		 ~strings1.envelope.attack = 0.850;~strings1.envelope.release = 0.9;~strings1.envelope.decay = 0.55;
		 ~midiMelody.value;//~monoPulseLead.value(~melody);
         ~strings2.envelope.attack = 0.8500;~strings2.envelope.release = 0.9;~strings2.envelope.decay = 0.55;

	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((31*4)-1),{ // 00 = Time in beats 
	   (
		   ~strings1.envelope.attack = 0.80;~strings1.envelope.release = 0.8;~strings1.envelope.decay = 0.55;
		   ~strings2.envelope.attack = 0.80;~strings2.envelope.release = 0.8;~strings2.envelope.decay = 0.55;

	    );(nil);};); // End of t.schedAbs


       t.schedAbs(timeNow + ((51*4)- 1),{ // 00 = Time in beats 
	   (
		   ~strings1.envelope.attack = 0.85;~strings1.envelope.release = 0.9;~strings1.envelope.decay = 0.650;
		   ~strings2.envelope.attack = 0.85;~strings2.envelope.release = 0.9;~strings2.envelope.decay = 0.650;

	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((58*4)- 1),{ // 00 = Time in beats 
	   (
		   ~strings1.envelope.attack = 0.80;~strings1.envelope.release = 0.8;~strings1.envelope.decay = 0.55;
		   ~strings2.envelope.attack = 0.80;~strings2.envelope.release = 0.8;~strings2.envelope.decay = 0.55;

	    );(nil);};); // End of t.schedAbs
       t.schedAbs(timeNow + ((67*4) -1),{ // 00 = Time in beats 
	   (
           ~strings1.envelope.attack = 0.55;~strings1.envelope.release = 0.9;~strings1.envelope.decay = 0.650;~strings1.amp = 1.50;
           ~strings2.envelope.attack = 0.55;~strings2.envelope.release = 0.9;~strings2.envelope.decay = 0.650;~strings2.amp = 1.50;
	    );(nil);};); // End of t.schedAbs

     }); // End of Routine

 }; //End of Start

 )


~startup.value;
~startTimer.value(106);
~rp = {~start.value;};

