Help.gui
Quarks.gui
GUI.qt

s.boot;
s.plotTree;
s.meter;
s.quit;


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
	   
    ~bassdrum = MyEvents.new;
    ~bassdrum.waits = [1.0,1.0,1.0,1.0];
    ~bassdrum.freqs = [35,35,35,35];
    ~bassdrum.probs = [1,1,1,1];
    ~bassdrum.durations = [1.0,1.0,1.0,1.0] * 1;
    ~bassdrum.amp = 2;
    ~bassdrum.init;

    ~midiBassDrum = {Pbind(\type, \midi,
			   \midiout, ~synth2,
			   \midicmd, \noteOn,
			   \note,  Pfunc.new({~bassdrum.freq.next}- 60),
			   \amp, ~bassdrum.amp,
			   \chan, 9,
			   \sustain, Pfunc.new({~bassdrum.duration.next}),
			   \dur, Pfunc.new({~bassdrum.wait.next})
			   ).play};

    ~cantus_firmus = MyEvents.new;
    ~cantus_firmus.waits = [8.0,4.0,4.0,8.0,4.0,4.0];
    ~cantus_firmus.freqs = [65,63,67,65,63,60] + 12;
    ~cantus_firmus.probs = [1,1,1,1,1,1];
    ~cantus_firmus.durations = [8.0,4.0,4.0,8.0,4.0,4.0];
    ~cantus_firmus.amp =1;
    ~cantus_firmus.init;

    ~midiCantus_firmus = {Pbind(\type, \midi,
				\midiout, ~synth2,
				\midicmd, \noteOn,
				\note,  Pfunc.new({~cantus_firmus.freq.next}- 60),
				\amp, ~cantus_firmus.amp,
				\chan, 8,
				\sustain, Pfunc.new({~cantus_firmus.duration.next}),
				\dur, Pfunc.new({~cantus_firmus.wait.next})
				).play};




    SynthDef(\Noise1, {arg out = 0, freq = 550, rq = 0.5, lagLev = 0.0;
	var sig;
	sig = WhiteNoise.ar(1);
	freq = Lag.kr(freq, lagLev);
	sig = BPF.ar(sig,freq,rq,mul:1/rq);
	Out.ar(out, sig);
      }).add;


    SynthDef(\Pulse, {arg out = 0, freq = 55, width = 0.5, lagLev = 0.0;
	var sig;
	freq = Lag.kr(freq, lagLev);
     sig = LFPulse.ar(freq, 0, 0.5, 1, -0.5);
	Out.ar(out, sig);
      }).add;


    SynthDef(\Saw2, {arg out = 0, infreq = 0;
	var sig;
	sig = LFSaw.ar(In.ar(infreq),0.0);
	Out.ar(out, sig);
      }).add;


    SynthDef(\Sine1, {arg out = 0, infreq = 0;
	var sig;
	sig = SinOsc.ar(In.ar(infreq),0.5);
	Out.ar(out, sig);
      }).add;


    ~nGroup = Group.new;
	   //   ~nGroup2 = Group.new;

    ~envout = Bus.audio(s,1);
    ~envout1 = Bus.audio(s,1);
    ~asrOut = Bus.audio(s,1);
	~adsrOut = Bus.audio(s,1);
	   
    ~wcut = Bus.audio(s,1);
    ~wmul = Bus.audio(s,1);
    ~wgain = Bus.audio(s,1);

    ~mix1out = Bus.audio(s,1);
    ~mix2out = Bus.audio(s,1);
    ~mix3out = Bus.audio(s,1);
    ~mix4out = Bus.audio(s,1);
    ~circleOut = Bus.audio(s,1);

    ~saw1Out = Bus.audio(s,1);
    ~saw2Out = Bus.audio(s,1);
    ~sine1Out = Bus.audio(s,1);
    ~noise1Out = Bus.audio(s,1);

    ~wind = Synth("windspeed",target: ~nGroup,addAction: \addToHead);
    ~wind.set(\out,~wcut);
    ~wind.set(\out2,~wmul);
    ~wind.set(\out3,~wgain);

    ~circle = Synth("myCircle",target: ~nGroup,addAction: \addToHead);
    ~circle.set(\out,~circleOut);
	  
    ~mixer1 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
    ~mixer1.set(\in0,~wcut);
    ~mixer1.set(\in1,~envout1);
    ~mixer1.set(\out,~mix1out);

    ~mixer2 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
    ~mixer2.set(\in0,~wmul);
    ~mixer2.set(\in1,~envout);
    ~mixer2.set(\out,~mix2out);
		   
    ~noise1 =  Synth("Noise1",target: ~nGroup,addAction: \addToTail);
    ~noise1.set(\freq, 77.midicps);
    ~noise1.set(\out,~noise1Out);
		  
	   
    ~saw1 =  Synth("Pulse",target: ~nGroup,addAction: \addToTail);
	~saw1.set(\out,~saw1Out);
	   /*
    ~saw2 =  Synth("Saw2",target: ~nGroup,addAction: \addToTail);
    ~saw2.set(\infreq,~envout1);
    ~saw2.set(\out,~saw2Out);

    ~sine1 =  Synth("Saw2",target: ~nGroup,addAction: \addToTail);
    ~sine1.set(\infreq,~envout1);
    ~sine1.set(\out,~sine1Out);
	   */
    ~mixer3 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
    ~mixer3.set(\in0,~envout);
    ~mixer3.set(\in1,~adsrOut);
	~mixer3.set(\out,~mix3out);
	   
	   /*
    ~mixer4 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
    ~mixer4.set(\in0,~envout);
    ~mixer4.set(\in1,~asrOut);
    ~mixer4.set(\out,~mix4Out);

	   */

	   ~saw =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
	   ~saw.set(\cutoff,~envout1);
	   ~saw.set(\cutoff,~asrOut);
	   ~saw.set(\mul, ~envout);
	   ~saw.set(\oscIn, ~saw1Out);
	   ~saw.set(\aocIn, ~envout);
	   ~saw.set(\aocIn, ~mix3out);

	   /*
    ~sine =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
    ~sine.set(\cutoff,~envout1);
    ~sine.set(\gain,~wgain);
    ~sine.set(\mul, ~mix2out);
    ~sine.set(\oscIn, ~sine1Out);
    ~sine.set(\aenv, ~envout);
    ~sine.set(\aocIn, ~circleOut);
	   */
    ~noise =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
    ~noise.set(\cutoff,~mix1out);
    ~noise.set(\gain,~wgain);
    ~noise.set(\mul, ~mix2out);
    ~noise.set(\oscIn, ~noise1Out);
	   //	~noise.set(\aocIn, ~envout);
	~noise.set(\aocIn, ~circleOut);
	  

    ~channel8 = {arg num, vel = 1;
      var ret;

	    ~noise1.set(\freq,num.midicps);
      ~saw1.set(\freq,(num-36).midicps);
		//      ~sine1.set(\freq,(num-36).midicps);

		
      ret  = Synth("myASR",addAction: \addToHead);
		ret.set(\out,~asrOut);
		ret.set(\release,0.00);
		ret.set(\attack,16);
		ret.set(\cutoff,15000);
	  ret.set(\gate,1);
	
      ret;
    };

    ~channel9 = {arg num, vel = 1;
      var ret;
      ~nGroup.set(\gate,0);
		
      ret  = Synth("env0",target: ~nGroup,addAction: \addToHead);
      ret.set(\out,~envout);
			/*
      ret = ~setenv.value(ret);
		*/
      ret  = Synth("env1",target: ~nGroup,addAction: \addToHead);
		ret.set(\out,~envout1);

	  ret  = Synth("myADSR",target: ~nGroup,addAction: \addToHead);
	  ret.set(\out,~adsrOut);
	  ret.set(\release,0.200);
	  ret.set(\attack,0.005);
	  ret.set(\decay,0.065);
	  ret.set(\sustain,0.001);
      ~nGroup.set(\gate,1);
      ~nGroup;
		

    };
    )

     };
 )

~startup.value;
~startTimer.value(120);

~nGroup.free;

~rp = {~midiBassDrum.value;~midiCantus_firmus.value;~circle.set(\zgate,1);}; // Example

~rp = {~midiBassDrum.value;};

~noise1.set(\rq,0.15);
~noise.set(\aoc,0.0);



~saw1.set(\lagLev,0.1250);
~saw1.set(\width,0.5);
~saw.set(\clip,1);
~saw.set(\aoc,1.0);

~saw.set(\mgain,2.50);
~saw.set(\amp,1);

~noise.set(\spread,1);
~mixer1.set(\bal,1);~mixer2.set(\bal,1);~mixer3.set(\bal,1);

~mixer1.set(\bal,-1);~mixer2.set(\bal,-1);
~mixer1.set(\bal,0);~mixer2.set(\bal,0);
~mixer1.set(\bal,0.5);~mixer2.set(\bal,0.15);

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

(
 ~start = {

   var num = 60,timeNow;
   t = TempoClock.default.tempo = num / 60;

   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

       t.schedAbs(timeNow + 00,{ // 00 = Time in beats
	   (
	    // If yes put stuff Here
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
