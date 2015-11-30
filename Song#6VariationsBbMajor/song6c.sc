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
 "/home/dbalchen/Music/Song#6VariationsBbMajor/include/Song6C/stringbass.sc".loadPath;

	
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


~rp = {~playStringbass.value};

~playStringbass.value;

~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;
~tom1.amp = 0;~tom2.amp = 0;~tom3.amp = 0;
~snare.amp = 0;
~ride.amp = 0;
~snare.amp = 1;
~ride.amp = 4;
~melody.amp = 0;
~bassd.amp =1;
~bassd.amp =0;

~rp = {~midiBassDrum.value;~midiSnare.value; ~midiToms.value;~midiCyms.value;1.wait;~tom1.amp = 0;~tom2.amp = 0;~tom3.amp = 0;~snare.amp = 0;~ride.amp = 0;~bassd.amp =0;};

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


       t.schedAbs(timeNow + (0.0198),{ // 00 = Time in beats 
	   (
	    ~playStringbass.play;
	    );(nil);};); // End of t.schedAbs
    
       t.schedAbs(timeNow + ((4*1)-0.5),{ // 00 = Time in beats 
	   (
		   /*
		   ~tom1.probs = (~tom1probs * 1.4 * ~fadein) + (~tom1probsPrime);~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;
           ~midiToms.value;
           //1.wait;
		   ~tom1.amp = 0;~tom2.amp = 0;
		   ~tom3.amp = 0;
		   */
		   //~midiCyms.value;
           ~ride.amp =0;
	    );(nil);};); // End of t.schedAbs


       t.schedAbs(timeNow + ((4*3)),{ // 00 = Time in beats 
	   (
		  ~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;
		   // ~bassd.amp =1;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*5)-2),{ // 00 = Time in beats 
	   (
		   // ~bassdrummiddle.value;
		   //~tomMid.value;
		 ~tom1.probs = (~tom1probs * 3.4 * ~fadein) + (~tom1probsPrime);~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;


	    );(nil);};); // End of t.schedAbs

	   
       t.schedAbs(timeNow + ((4*9)-2),{ // 00 = Time in beats 
	   (
		   // ~mainDrum.value;
		   ~tom1.probs = (~tom1probs * 1.5) + (~tom1probsPrime);~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;
	    );(nil);};); // End of t.schedAbs




       t.schedAbs(timeNow + ((4*11)-2),{ // 00 = Time in beats 
	   (
		 ~tom1.probs = (~tom1probs * 1.4 * ~fadein) + (~tom1probsPrime);~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;

		   // ~bassd.amp =1;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*13)-2),{ // 00 = Time in beats 
	   (
		   // ~bassdrummiddle.value;
		   //~tomMid.value;
		 ~tom1.probs = (~tom1probs * 3.4 * ~fadein) + (~tom1probsPrime);~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;

	    );(nil);};); // End of t.schedAbs

	   
       t.schedAbs(timeNow + ((4*17)-2),{ // 00 = Time in beats 
	   (
		   // ~mainDrum.value;
		   //~tomend2.value
		   ~tom1.probs = ~tom1end;
	    );(nil);};); // End of t.schedAbs


       t.schedAbs(timeNow + ((4*19)),{ // 00 = Time in beats 
	   (
		   // ~mainDrum.value;
		   //~tomend2.value
		   ~tom1.probs = ~tom1roll;
		   ~tom1.amp = 0;~tom2.amp = 0;~tom3.amp = 0;~ride.amp = 7.0;
	    );(nil);};); // End of t.schedAbs

	   ////////////////////////////////////////////////////////////////////////////////


       t.schedAbs(timeNow + ((4*67)-1),{ // 00 = Time in beats 
	   (
		   ~tom1.probs = (~tom1probs * 1.4 * ~fadein) + (~tom1probsPrime);
		  ~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;
		   // ~bassd.amp =1;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*69)-2),{ // 00 = Time in beats 
	   (
		   ~ride.amp = 0.0;
		   // ~bassdrummiddle.value;
		   //~tomMid.value;
		 ~tom1.probs = (~tom1probs * 2.0 * ~fadein) + (~tom1probsPrime);~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;


	    );(nil);};); // End of t.schedAbs

	   
       t.schedAbs(timeNow + ((4*73)-2),{ // 00 = Time in beats 
	   (
		   // ~mainDrum.value;
		   ~tom1.probs = (~tom1probs * 1.5) + (~tom1probsPrime);~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;
	    );(nil);};); // End of t.schedAbs




       t.schedAbs(timeNow + ((4*75)-2),{ // 00 = Time in beats 
	   (
		 ~tom1.probs = (~tom1probs * 1.4 * ~fadein) + (~tom1probsPrime);~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;

		   // ~bassd.amp =1;
	    );(nil);};); // End of t.schedAbs

       t.schedAbs(timeNow + ((4*77)-2),{ // 00 = Time in beats 
	   (
		   // ~bassdrummiddle.value;
		   //~tomMid.value;
		 ~tom1.probs = (~tom1probs * 2 * ~fadein) + (~tom1probsPrime);~ride.amp = 0;~tom1.amp = 1;~tom2.amp = 1;~tom3.amp = 1;

	    );(nil);};); // End of t.schedAbs

	   
       t.schedAbs(timeNow + ((4*81)-2),{ // 00 = Time in beats 
	   (
		   // ~mainDrum.value;
		   //~tomend2.value
 ~tom1.probs = (~tom1probs * 10.5) + (~tom1probsPrime);		  
	    );(nil);};); // End of t.schedAbs


     }); // End of Routine

 }; //End of Start

 )


~rp = {~start.value;};
~startTimer.value(106);
