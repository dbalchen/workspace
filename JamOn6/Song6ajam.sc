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
		~bellOut = Bus.audio(s,1);

		~vcaOut = Bus.audio(s,1);
		~vca2Out = Bus.audio(s,1);

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

		~vca1 =  Synth("vca",addAction: \addToTail);
		~vca1.set(\in,~vcaOut);
		//		~vca1.set(\center,-1);

		/*
		~vca2 =  Synth("vca",addAction: \addToTail);
		~vca2.set(\in,~vca2Out);
		~vca2.set(\center,0);
		*/
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

		~dcs = 4.0;
		~fscale = 1;
		~release = 12.0;
		~attack = 0.0;
		~amp = 0.200;
		~pitch = 87.3070578583;
		~mixer4.set(\bal,-0.60);
		~vca1.set(\amp,0.6);

		~noise1.set(\rq,0.15);
		~noise1.set(\lagLev,4.00);
		~noise.set(\aoc,0.75);
		~noise.set(\spread,1);
		~noise.set(\amp,3.25);
		~mixer1.set(\bal,-0.35);
		~mixer2.set(\bal,-1.0);

		~pulse1.set(\lagLev,0.0250);
		~pulse.set(\clip,1);
		~pulse.set(\aoc,1.0);
		~pulse.set(\cutoff,~mix3out);
		~pulse.set(\mgain,1.45);
		~pulse.set(\maoc,0.9);
		~pulse.set(\amp,0.80);
		~mixer3.set(\bal,0.90);

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

~dcs = 15.0;
~fscale = 1.0;
~release = 1.2;
~attack = 0.00;
~amp = 0.8;
~amp = 0.01;
~amp = 0;

~amp = 0.00;
~rp={
	s.sync;
	~midiBellDrum.value;
	~midiBassDrum.value;
	~midiCantus_firmus.value;
	~midistring1_firmus.value;
	~midistring2_firmus.value;
	~circle.set(\zgate,1);
	~midiSineDrum.value;
	~midiAdsr.value;
};

Server.latency

//	0.2695.wait;~pSineDrum.value;};

~rp = {
	//	~pBell.value;
	~midiBellDrum.value;

};
~rp = {				~midistring1_firmus.value;
	~midistring2_firmus.value;}

~noise1.set(\rq,0.45);
~noise1.set(\lagLev,4.00);
~noise.set(\aoc,0.0);

~noise.set(\aoc,1.0);
~noise.set(\spread,1);
~noise.set(\amp,5.0);
~noise.set(\amp,3.25);
~noise.set(\amp,2.0);
~noise.set(\amp,0.0);

~pulse1.set(\lagLev,0.50);
~pulse1.set(\width,0.5);
~pulse.set(\clip,1);
~pulse.set(\aoc,0.0);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mgain,1.45);
~pulse.set(\maoc,0.0);
~pulse.set(\amp,0.10);
~pulse.set(\amp,0.00);
~pulse.set(\overd,1.2);


~vca1.set(\amp,0.0);
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

~string1_firmus.amp = 1;
~string2_firmus.freqs = Array.fill(6,{Prand([62,58,65,60,56,63,64,67,57,53,55],inf).asStream.next}) + 12;

TempoClock.default.tempo = 120 / 60;

s.latency

(
~start = {

	var num = 120,timeNow;
	t = TempoClock.default.tempo = num / 60;
	Routine.run({
		s.sync;
		timeNow = TempoClock.default.beats;

		t.schedAbs(timeNow + 00,{ // 00 = Time in beats
			(
				~midistring1_firmus.value;
				~midistring2_firmus.value;
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
