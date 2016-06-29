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
		"/home/dbalchen/Music/JamOn6/include/Synths/oscillator.sc".load;
		"/home/dbalchen/Music/JamOn6/include/Synths/bell.sc".load;
		"/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;


		SynthDef("eStrings",
			{
				arg out = 0, freq = 110, gate = 0, amp = 0.5, da = 2,bassamt = 0.09,
				attack = 4, decay = 4, sustain = 0, release = 0.5, fattack = 0.0, fsustain = 1,
				frelease = 0.05, aoc = 0, gain = 1, cutoff = 10000.00, bend = 0;

				var sig, env, fenv;

				env  = Env.adsr(attack,decay,sustain,release,curve: 'welch');

				freq = {freq * bend.midiratio * LFNoise2.kr(2.5,0.01,1)}!16;

				fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
				fenv = EnvGen.kr(fenv, gate,doneAction:da);

				sig = (LFSaw.ar(freq,0,0.1));

				sig = Splay.ar(sig);
				sig = sig*EnvGen.kr(env, gate: gate,doneAction:da);
				sig = MoogFF.ar
				(
					sig,
					cutoff*fenv,
					gain
				);


				Out.ar(out,amp*sig);

		}).send(s);



		~nGroup = Group.new;
		~nGroup2 = Group.new;

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

		~pulse1Out = Bus.audio(s,1);
		~noise1Out = Bus.audio(s,1);
		~sine1Out = Bus.audio(s,1);
		~bellOut = Bus.audio(s,1);
		~vcaOut = Bus.audio(s,1);

		~stringsOut  = Bus.audio(s,1);


		~myadsr = MyADSR.new;
		~myadsr.init;
		~myadsr.attack = 0.2;
		~myadsr.decay = 2.5;
		~myadsr.sustain = 0.0;
		~myadsr.release = 0.0;


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

		~mixer3 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
		~mixer3.set(\in0,~envout1);
		~mixer3.set(\in1,~asrOut);
		~mixer3.set(\out,~mix3out);

		~mixer4 = Synth("two2one",addAction: \addToTail);
		~mixer4.set(\in0,~bellOut);
		~mixer4.set(\in1,~sine1Out);
		~mixer4.set(\out,~vcaOut);


		~pulse1 =  Synth("Pulse",target: ~nGroup,addAction: \addToTail);
		~pulse1.set(\out,~pulse1Out);

		~pulse =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
		~pulse.set(\cutoff,~mix3out);
		~pulse.set(\mul, ~envout);
		~pulse.set(\oscIn, ~pulse1Out);
		~pulse.set(\aocIn, ~adsrOut);

		~noise1 =  Synth("Noise",target: ~nGroup,addAction: \addToTail);
		~noise1.set(\freq, 77.midicps);
		~noise1.set(\out,~noise1Out);

		~noise =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
		~noise.set(\cutoff,~mix1out);
		~noise.set(\gain,~wgain);
		~noise.set(\mul, ~mix2out);
		~noise.set(\oscIn, ~noise1Out);
		~noise.set(\aocIn, ~circleOut);

		~dcs = 0.50;
		~fscale = 2;
		~release = 0.4;
		~attack = 0.0;
		~amp = 0.200;
		~pitch = 440.00;

		~channel6 = {arg num, vel = 1;
			var ret;

			ret = Synth("eStrings",target: ~nGroup2,addAction: \addToTail);
			ret.set(\freq,(num-24).midicps);
			ret.set(\release,0.5);
			ret.set(\frelease,1);
			ret.set(\gain,1.0);
			ret.set(\fattack,4);
			ret.set(\gate,1);

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

			ret =  Synth("Sine",addAction: \addToHead);
			ret.set(\out,~sine1Out);
			ret.set(\amp,0.5);
			ret.set(\gate,1);

			ret;
		};

		~channel8 = {arg num, vel = 1;
			var ret;

			~noise1.set(\freq,num.midicps);
			~pulse1.set(\freq,(num-36).midicps);

			~pitch = (num - 36).midicps;

			ret  = Synth("myASR",target: ~nGroup2,addAction: \addToHead);
			ret.set(\out,~asrOut);
			ret.set(\release,0.02);
			ret.set(\attack,16);
			ret.set(\cutoff,1);
			ret.set(\aoc,1.0);

			ret;
		};

		~channel9 = {arg num, vel = 1;
			var ret;

			ret  = Synth("env0",target: ~nGroup,addAction: \addToHead);
			ret.set(\out,~envout);
			ret  = Synth("env1",target: ~nGroup,addAction: \addToHead);
			ret.set(\out,~envout1);

			ret  = Synth("myADSR",target: ~nGroup,addAction: \addToHead);
			ret.set(\out,~adsrOut);
			~myadsr.setADSR(ret);

			~nGroup.set(\gate,1);
			~nGroup;

		};
	)

};
)

~startup.value;
~startTimer.value(120);

~dcs = 4.5;
~fscale = 2.0;
~release = 0.4;
~attack = 2.0;
~amp = 0.00;

~nGroup.free;
~strings1.set(\LagLev,0.0);
~rp ={~midiBassDrum.value;~midiSineDrum.value;~midiCantus_firmus.value;~midistring1_firmus.value;~circle.set(\zgate,1);}; // Exampl;



~noise1.set(\rq,0.15);
~noise1.set(\lagLev,4.00);
~noise.set(\aoc,0.0);
~noise.set(\spread,1);
~noise.set(\amp,5.0);
~noise.set(\amp,3.0);
~noise.set(\amp,0.0);

~pulse1.set(\lagLev,0.0250);
~pulse1.set(\width,0.5);
~pulse.set(\clip,1);
~pulse.set(\aoc,0.0);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mgain,2.0);
~pulse.set(\maoc,0.0);
~pulse.set(\amp,0.40);
~pulse.set(\amp,0.00);
~pulse.set(\overd,1.2);

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








(
~start = {

	var num = 120,timeNow;
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
