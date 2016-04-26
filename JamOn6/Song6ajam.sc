xHelp.gui
Quarks.gui
GUI.qt
s.plotTree;
s.meter;

(
 o = Server.local.options;
 o.numOutputBusChannels = 24; // The next time it boots, this will take effect
 o.memSize = 2097152;
 )


"/home/dbalchen/Music/setup.sc".loadPath;

(
 ~startup = {

   (
    
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

    SynthDef(\kick, { |out=0, amp=0.1, pan=0|
	  var env0, env1, env1m, son;
	
	env0 =  EnvGen.kr(Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, 0.26], [-4, -2, -4]), doneAction:2);
	env1 = EnvGen.kr(Env.new([110, 59, 29], [0.005, 0.29], [-4, -5]));
	env1m = env1.midicps;
	
		//son = LFPulse.ar(env1m, 0, 0.5, 1, -0.5);
	son = LFSaw.ar(env1m, 0);
		//son = WhiteNoise.ar(1);
	son = LPF.ar(son, env1m*1.5, env0);
	//son = son + SinOsc.ar(env1m, 0.5, env0);
	son = son * 1.2;
	son = son.clip2(1);
	
	OffsetOut.ar(out, Pan2.ar(son * amp));
      }).add;



    SynthDef(\zeroRate,{arg out = 0;
	Out.ar(out, 0);}).add;

    SynthDef(\iRate,{arg out = 0;
	Out.kr(out, 1);}).add;
		
    SynthDef(\env0, {arg out=0,r1 = 0.5,r2 = 1, r3 = 0.5, r4 = 0, r5 = 0,gate = 0; 
	var sig;
	sig = EnvGen.ar(
			Env.new([r1, r2, r3, r4, r5], [0.005, 0.06, 0.26, 0.1], [-4, -2, -4, -1],4)
			,gate,doneAction:2);

	Out.ar(out, sig);}).add;

    SynthDef(\env1, {arg out=0,gate = 0; 
	var sig;
	sig = EnvGen.ar(
			Env.new([110, 59, 29], [0.005, 0.1], [-4, -5])
			,gate,doneAction:2);

	sig = sig.midicps;
	Out.ar(out,sig);}).add;

    SynthDef(\windspeed, {arg out = 0,out2 = 0, out3 = 0;
	Out.ar(out,
	       ((LFDNoise3.ar(LFNoise1.ar(1, 0.5, 0.5), 0.5, 0.5))*500) + 350;
	       );

	Out.ar(out2,
	       ((LFDNoise3.ar(LFNoise1.ar(1, 0.5, 0.5), 0.5, 0.5))*0.3) + 0.05;
	       );

	Out.ar(out3,
	       LFNoise1.ar(1, 0.3, 0.5);
	       );

      }).add;


    SynthDef(\myCircle,{arg out = 0, zgate = 0;
	var sig;
	sig = (SinOsc.ar(1/32)) * zgate;

	Out.ar(out,sig);}).add;
	

    SynthDef(\two2one, {arg out=0,in0 = 0, in1 = 0, bal = 0;
	var amp1 = 1, amp2 = 1, sig;

	bal = bal +1;

	amp1 = bal*0.5;
	amp2 = 1 - amp1;

	sig = (In.ar(in0)*amp1) + (In.ar(in1)*amp2);

	OffsetOut.ar(out,sig);  
      }).add;


    SynthDef(\Saw1, {arg out = 0, freq = 550, lagLev = 0.0;
		var sig;
	freq = Lag.kr(freq, lagLev);
	sig = LFSaw.ar(freq,0.5);
	OffsetOut.ar(out, sig);
      }).add;	

    SynthDef(\Saw2, {arg out = 0, infreq = 0;
		var sig;
	sig = LFSaw.ar(In.ar(infreq),0.5);
	OffsetOut.ar(out, sig);
      }).add;	

    SynthDef(\Sine1, {arg out = 0, infreq = 0;
		var sig;
	sig = SinOsc.ar(In.ar(infreq),0.5);
	OffsetOut.ar(out, sig);
      }).add;	


    SynthDef(\bdNoise, {arg out = 0, amp = 1, aocIn = 0, aenv = 0, spread = 0, center = 0, // VCA Controls
	  freq = 550, rq = 0.15, lagLev = 4.0, // Band Pass Filter
	  cutoff = 0, gain = 0, mul = 1; // Low Pass Filter

	var sig, aoc;

	sig = WhiteNoise.ar(1);
	
	freq = Lag.kr(freq, lagLev);
	sig = BPF.ar(sig,freq,rq,mul:1/rq);	

	cutoff = In.ar(cutoff)*1.5;
	gain = In.ar(gain);
	mul = In.ar(mul);
	sig = MoogFF.ar(sig, freq:cutoff, gain: gain,mul:mul);

	aoc =  In.ar(aocIn) * (In.ar(aenv) - 1) + 1;
	sig = sig * aoc;

	sig = sig*1.2;
	sig = sig.clip2(1);
	sig = Splay.ar(sig,spread,center:center);

	OffsetOut.ar(out, (sig * amp));
      }).add;	


     
    SynthDef(\bdSound, {arg out = 0, amp = 1, oscIn = 0, aocIn = 0, aenv = 0, spread = 0, center = 0, // VCA Controls
	  clip = 1, cutoff = 0, gain = 0, mul = 1; // Clip and Low Pass Filter

	var sig, aoc;

	sig = In.ar(oscIn);

	cutoff = In.ar(cutoff) * 1.5;
	gain = In.ar(gain);
	mul = In.ar(mul);
	sig = MoogFF.ar(sig, freq:cutoff, gain: gain,mul:mul);

	aoc =  In.ar(aocIn) * (In.ar(aenv) - 1) + 1;
	sig = sig * aoc;

	sig = sig*1.2;
	sig = sig.clip2(clip);
	sig = Splay.ar(sig,spread,center:center);

	OffsetOut.ar(out, (sig * amp));
      }).add;	


    
    ~nGroup = Group.new;
    ~envout = Bus.audio(s,1);
    ~envout1 = Bus.audio(s,1);

    ~wcut = Bus.audio(s,1);
    ~wmul = Bus.audio(s,1);
    ~wgain = Bus.audio(s,1);

    ~mix1out = Bus.audio(s,1);
    ~mix2out = Bus.audio(s,1);
    ~mix3out = Bus.audio(s,1);

    ~circleOut = Bus.audio(s,1);

    ~saw1Out = Bus.audio(s,1);
    ~saw2Out = Bus.audio(s,1);
    ~sine1Out = Bus.audio(s,1);

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


	   /*
    ~noise =  Synth("bdNoise",target: ~nGroup,addAction: \addToTail);
    ~noise.set(\cutoff,~mix1out);
    ~noise.set(\gain,~wgain);
    ~noise.set(\mul, ~mix2out);
    ~noise.set(\freq, 77.midicps);
    ~noise.set(\aenv, ~envout);
    ~noise.set(\aocIn, ~circleOut);
	   */	  

    ~saw1 =  Synth("Saw1",target: ~nGroup,addAction: \addToTail);
    ~saw1.set(\out,~saw1Out);

    ~saw2 =  Synth("Saw2",target: ~nGroup,addAction: \addToTail);
    ~saw2.set(\infreq,~env1out1);
    ~saw2.set(\out,~saw2Out);

    ~mixer3 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
    ~mixer3.set(\in0,~saw1Out);
    ~mixer3.set(\in1,~saw2Out);
    ~mixer3.set(\out,~mix3out);

    ~saw =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
    ~saw.set(\cutoff,~mix1out);
    ~saw.set(\gain,~wgain);
    ~saw.set(\mul, ~mix2out);
    ~saw.set(\oscIn, ~mix3out);
    ~saw.set(\aenv, ~envout);
    ~saw.set(\aocIn, ~circleOut);
	  

    ~channel8 = {arg num, vel = 1;
      var ret;

		//~noise.set(\freq,num.midicps);
		~saw1.set(\freq,(num-36).midicps);

    };

    ~channel9 = {arg num, vel = 1;
      var ret;
		
			
      ret  = Synth("env0",target: ~nGroup,addAction: \addToHead);
      ret.set(\out,~envout);

      ret = ~setenv.value(ret);
	
      ret  = Synth("env1",target: ~nGroup,addAction: \addToHead);
      ret.set(\out,~envout1);
	
      ~nGroup.set(\gate,1);
      ~nGroup;

		
	
		/*
	ret  = Synth("kick");
	ret.set(\gate,1);
	ret;
		*/ 		
    };
    )


     };
 )

~startup.value;
~startTimer.value(120);

~nGroup.free;

~rp = {~midiBassDrum.value;~midiCantus_firmus.value;~circle.set(\zgate,1);}; // Example

~rp = {~midiBassDrum.value;};

      ~noise.set(\rq,0.1);

~saw.set(\lagLev,1.0);
~saw.set(\clip,0.75);

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
