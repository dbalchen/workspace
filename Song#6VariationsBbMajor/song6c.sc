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


 "/home/dbalchen/workspace/SuperCollider/FMpad.sc".loadPath;
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/melody.sc".loadPath;
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/drums.sc".loadPath;
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/stringbass.sc".loadPath;
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/strings.sc".loadPath;
	
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


 )


~startTimer.value(106);

~rp = {~midiString2.value;~midiString1.value;}

~rp = {~playStringbass.value};

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

   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

	   ~playStringbass.play;
    
       t.schedAbs(timeNow + ((4*3)-0.2),{ // 00 = Time in beats 
	   (
		   ~midiBassDrum.value;~midiSnare.value; ~midiToms.value;~midiCyms.value;~midiString2.value;~midiString1.value;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((19*4)),{ // 00 = Time in beats 
	   (
		 ~monoPulseLead.value(~melody);
	    );(nil);};); // End of t.schedAbs

     }); // End of Routine

 }; //End of Start

 )

~startTimer.value(106);
~rp = {~start.value;};


~strings1.envelope.attack = 0.15;~strings1.envelope.release = 0.57;~strings1.envelope.decay = 4.750;
~strings2.envelope.attack = 0.15;~strings2.envelope.release = 0.57;~strings2.envelope.decay = 4.750;

~strings1.envelope.attack = 0.85;~strings1.envelope.release = 0.37;~strings1.envelope.decay = 0.750;
~strings2.envelope.attack = 0.850;~strings2.envelope.release = 0.35;~strings2.envelope.decay = 0.750;
