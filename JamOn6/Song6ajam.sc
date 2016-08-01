Help.gui
Quarks.gui
GUI.qt

s.boot;
s.plotTree;
s.meter;
s.quit;
Server.default.makeGui

(
 o = Server.local.options;
 o.numOutputBusChannels = 24; // The next time it boots, this will take effect
 o.memSize = 2097152;
 )

"/home/dbalchen/Music/setup.sc".load;



(
 ~startup = {

   (

    "/home/dbalchen/Music/JamOn6/include/Synths/bdSynth.sc".load;
    "/home/dbalchen/Music/JamOn6/include/Synths/envelopes.sc".load;
    "/home/dbalchen/Music/JamOn6/include/Synths/oscillator.sc".load;
    "/home/dbalchen/Music/JamOn6/include/Synths/bell.sc".load;
    "/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;
    "/home/dbalchen/Music/JamOn6/include/Events/stringBeats.sc".load;
    "/home/dbalchen/Music/JamOn6/include/Events/bellBeats.sc".load;
    "/home/dbalchen/Music/JamOn6/include/Synths/eStrings.sc".load;
    "/home/dbalchen/Music/JamOn6/include/Patches/initPatch.sc".load;

    SynthDef(\myExtCircle,{arg out = 0, mull = 1/2, phase = 0, sigp = 1024, sig2p = 256, ratio = 1, add = 0, zgate = 0;
	var sig,sig2,rate;

	sig =  LFTri.kr(1/1024,phase)* zgate;
	sig2 = (SinOsc.kr(1/256)) * zgate * mull;
	rate = 1.0 - sig.abs;
	sig2 = sig2*rate;
	sig = sig + sig2;
	sig = (sig*ratio) + add;
	Out.kr(out,sig);}).add;

    ~circleExtOut = Bus.control(s,1);
    ~circleExt = Synth("myExtCircle",addAction: \addToHead);
    ~circleExt.set(\out,~circleExtOut);
    ~circleExt.set(\phase,1);
    ~circleExt.set(\mull,0.5);
    ~circleExt.set(\ratio,0.8);
    ~circleExt.set(\add,0.1);
    ~mixer3.set(\bmod,~circleExtOut);

    ~circleExtOut2 = Bus.control(s,1);
    ~circleExt2 = Synth("myExtCircle",addAction: \addToHead);
    ~circleExt2.set(\phase,3);
    ~circleExt2.set(\out,~circleExtOut2);
    ~circleExt2.set(\mull,0.05);
    ~circleExt.set(\ratio,0.675);
    ~circleExt.set(\add,0.65);
    ~mixer1.set(\bmod,~circleExtOut2);

    ~circleExtOut3 = Bus.control(s,1);
    ~circleExt3 = Synth("myExtCircle",addAction: \addToHead);
    ~circleExt3.set(\out,~circleExtOut3);
    ~circleExt3.set(\phase,1);
    ~circleExt3.set(\mull,0.5);	
    ~mixer2.set(\bmod,~circleExtOut3);


    SynthDef(\two2two, {arg out=0, out1 = 0, in0 = 0, in1 = 0, bal = 0, bmod = 999;
	var amp1 = 1, amp2 = 1, sig;

	bal = bal + 1 + In.kr(bmod);
	amp1 = bal*0.5;
	amp2 = 1 - amp1;
	sig = (In.ar(in0)*amp1) + (In.ar(in1)*amp2);
	Out.ar(out,sig);
	Out.ar(out1,sig);
	
      }).add;


    ~channel2 = {arg num, vel = 1;
      var ret;
      ret = ~midiStrings.value(~string3_firmus,num,2);
      ret;
    };

    ~channel3 = {arg num, vel = 1;
      var ret;
      ret = ~midiStrings.value(~string2_firmus,num,3);
      ret;
    };

    ~channel4 = {arg num, vel = 1;
      var ret;

      ret  = Synth("myADSR",addAction: \addToHead);
      ret.set(\out,~adsrOut);
      ~myadsr.setADSR(ret);
      ret.set(\gate,1);
      ret;

    };

    ~channel5 = {arg num, vel = 1;
      var ret;
      ret = Synth("Sine",addAction: \addToHead);
      ret.set(\amp,~sinedrum.amp);
      ret.set(\out,~sine1Out);
      ret.set(\gate,1);
      ret;

    };

    ~channel6 = {arg num, vel = 1;
      var ret;
      ret = ~midiStrings.value(~string1_firmus,num-24,6);
      //			ret = ~midiStrings.value(~string1_firmus,num,6);
      ret;
    };

    ~channel7 = {arg num, vel = 1;
      var ret;

      ret = Synth("tbell",addAction: \addToHead);
      ret.set(\freq,~pitch);
      ret.set(\decayscale,~dcs);
      ret.set(\fscale,~fscale);
      ret.set(\release,~release);
      ret.set(\attack,~attack);
      ret.set(\amp,~amp);
      ret.set(\out,~bellOut);
      ret.set(\gate,1);
      ret;
    };

    ~channel8 = {arg num, vel = 1;
      var ret;

      ~noise1.set(\freq,num.midicps);
      ~pulse1.set(\freq,(num-36).midicps);

      ~pitch = (num - 36).midicps;

      ret  = Synth("myASR",addAction: \addToHead);
      ret.set(\out,~asrOut);
      ret.set(\release,0.02);
      ret.set(\attack,16);
      ret.set(\cutoff,10000);
      ret.set(\aoc,1.0);
      ret.set(\gate,1);
      ret;
    };

    ~channel9 = {arg num, vel = 1;
      var ret;

      ret  = Synth("env0",target: ~nGroup,addAction: \addToHead);
      ret.set(\out,~envout);
      ret  = Synth("env1",target: ~nGroup,addAction: \addToHead);
      ret.set(\out,~envout1);

      ~nGroup.set(\gate,1);
      ~nGroup;

    };

    )

     };
 )

~startup.value;
~startTimer.value(120);
~synth2 = ~synth2.latency_(Server.default.latency);

~string2_firmus.amp = 0.0;
~string1_firmus.amp = 0.0;
~string3_firmus.amp = 0.0;

~dcs = 14.8;
~fscale = 1.5;
~release = 1.2;
~attack = 8.00;
~amp = 0.8;
~amp = 0.2;
~amp = 0;

~rp={
  s.sync;
  ~midiBellDrum.value;
  ~midiBassDrum.value;
  ~midiCantus_firmus.value;
  ~midistring1_firmus.value;
  ~midistring2_firmus.value;
  ~circle.set(\zgate,1);
  ~circleExt.set(\zgate,1);
  ~midiSineDrum.value;
  ~midiAdsr.value;
};


~noise1.set(\rq,0.15);
~noise1.set(\lagLev,4.00);
~noise.set(\aoc,0.0);
~noise.set(\aoc,1.0);
~noise.set(\spread,1);
~noise.set(\amp,5.0);
~noise.set(\amp,3.25);
~noise.set(\amp,1.0);
~noise.set(\amp,0.0);

~pulse1.set(\lagLev,0.50);
~pulse1.set(\width,0.5);
~pulse.set(\clip,1);
~pulse.set(\aoc,0.0);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mgain,1.45);
~pulse.set(\maoc,0.1);
~pulse.set(\amp,0.10);
~pulse.set(\amp,0.00);
~pulse.set(\overd,1.2);


~vca1.set(\amp,0.2);

~myadsr.gui;

~mixergui1 = SimpleMix.new;
~mixergui1.mixer = ~mixer1;
~mixergui1.gui;

~mixergui2 = SimpleMix.new;
~mixergui2.mixer = ~mixer2;
~mixergui2.gui;

~mixergui3 = SimpleMix.new;
~mixergui3.mixer = ~mixer3;
~mixergui3.gui;

~mixergui4 = SimpleMix.new;
~mixergui4.mixer = ~mixer4;
~mixergui4.gui;

~string1_firmus.filter.gui;
~string1_firmus.envelope.gui;


TempoClock.default.tempo = 120 / 60;

(
 ~start = {

   var num = 120,timeNow;
   t = TempoClock.default.tempo = num / 60;
   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

       t.schedAbs(timeNow + 00,{ // 00 = Time in beats
	   (
	    ~mixer4.set(\bal,-1.0);
	    ~mixer1.set(\bal,-1.0);
	    ~mixer2.set(\bal,-1.0);
	    ~mixer3.set(\bal,1.0);
	    ~midiBellDrum.value;
	    ~midiBassDrum.value;
	    ~midiCantus_firmus.value;
	    ~circle.set(\zgate,1);
	    ~midiSineDrum.value;
	    ~midiAdsr.value;
	    );};); // End of t.schedAbs

       t.schedAbs(timeNow + 16,{ // 00 = Time in beats
	   (
	     
	    ~circleExt2.set(\zgate,1);
		       

	    );};); // End of t.schedAbs


       t.schedAbs(timeNow + 32,{ // 00 = Time in beats
	   (
	    ~circleExt.set(\zgate,1);
	    ~mixer4.set(\bal,-0.75);
	    ~mixer3.set(\bal,0.0);
	    );};); // End of t.schedAbs


       t.schedAbs(timeNow + (96-0.2),{ // 00 = Time in beats
	   (
	    ~midistring1_firmus.value;
	    );};); // End of t.schedAbs

       t.schedAbs(timeNow + (160-0.2),{ // 00 = Time in beats
	   (
	    ~midistring2_firmus.value;
	    );};); // End of t.schedAbs
       //Add more

     }); // End of Routine

 }; //End of Start

 )

~startup.value;
~startTimer.value(120);
~synth2 = ~synth2.latency_(Server.default.latency);
~rp = {~start.value;};
s.boot;
s.quit;
