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
		"/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;

		~nGroup = Group.new;

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

		~myadsr = MyADSR.new;
		~myadsr.init;
		~myadsr.attack = 0.1;
		~myadsr.decay = 2.5;
		~myadsr.sustain = 0.0;
		~myadsr.release = 0.0;

		~wind = Synth("windspeed",target: ~nGroup,addAction: \addToHead);
		~wind.set(\out,~wcut);
		~wind.set(\out2,~wmul);
		~wind.set(\out3,~wgain);

		~circle = Synth("myCircle",target: ~nGroup,addAction: \addToHead);
		~circle.set(\out,~circleOut);

		~pulse1 =  Synth("Pulse",target: ~nGroup,addAction: \addToTail);
		~pulse1.set(\out,~pulse1Out);

		~pulse =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
		~pulse.set(\cutoff,~asrOut);
		~pulse.set(\mul, ~envout);
		~pulse.set(\oscIn, ~pulse1Out);
		~pulse.set(\aocIn, ~mix3out);


		~sine1 =  Synth("Sine",target: ~nGroup,addAction: \addToTail);
		~sine1.set(\out,~sine1Out);

		~sine =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
		~sine.set(\cutoff,~asrOut);
		~sine.set(\mul, ~envout);
		~sine.set(\oscIn, ~sine1Out);
		~sine.set(\aocIn, ~mix3out);

		~noise1 =  Synth("Noise1",target: ~nGroup,addAction: \addToTail);
		~noise1.set(\freq, 77.midicps);
		~noise1.set(\out,~noise1Out);

		~noise =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
		~noise.set(\cutoff,~mix1out);
		~noise.set(\gain,~wgain);
		~noise.set(\mul, ~mix2out);
		~noise.set(\oscIn, ~noise1Out);
		~noise.set(\aocIn, ~circleOut);

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


		~channel8 = {arg num, vel = 1;
			var ret;

			~noise1.set(\freq,num.midicps);
			~pulse1.set(\freq,(num-36).midicps);
			~sine1.set(\freq,(num-36).midicps);
			
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

~nGroup.free;

~rp = {~midiBassDrum.value;~midiCantus_firmus.value;~circle.set(\zgate,1);}; // Example


~noise1.set(\rq,0.15);
~noise1.set(\lagLev,4.00);
~noise.set(\aoc,1.0);
~noise.set(\spread,1);

~pulse1.set(\lagLev,0.0250);
~pulse1.set(\width,0.75);
~pulse.set(\clip,1);
~pulse.set(\aoc,1.0);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mgain,2.0);
~pulse.set(\amp,0.25);

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
