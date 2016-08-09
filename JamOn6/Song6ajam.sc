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
		"/home/dbalchen/Music/JamOn6/include/Synths/FMDarkpad.sc".load;
		"/home/dbalchen/Music/JamOn6/include/Patches/initPatch.sc".load;
		"/home/dbalchen/Music/JamOn6/include/Patches/midiDefs.sc".load;

		SynthDef(\myExtCircle,{arg out = 0, mull = 1/2, phase = 1, sigp = 1024, sig2p = 256, ratio = 1, add = 0, zgate = 0;
			var sig,sig2,rate;

			sig =  LFTri.kr(1/sigp,phase)* zgate;
			sig2 = (SinOsc.kr(1/sig2p)) * zgate * mull;
			rate = 1.0 - sig.abs;
			sig2 = sig2*rate;
			sig = sig + sig2;
			sig = (sig*ratio);
			sig = sig + add;
			Out.kr(out,sig);}).add;

		~circleExtOut = Bus.control(s,1);
		~circleExt = Synth("myExtCircle",addAction: \addToHead);
		~circleExt.set(\out,~circleExtOut);
		~circleExt.set(\phase,1);
		~circleExt.set(\mull,0.1);
		~circleExt.set(\ratio,0.98);
		~circleExt.set(\mull,0.9);
		// ~circleExt.set(\sig2p,16);
		~circleExt.set(\sig2p,16);
		~circleExt.set(\mull,0.9);
		~mixer3.set(\bmod,~circleExtOut);

		~circleExtOut2 = Bus.control(s,1);
		~circleExt2 = Synth("myExtCircle",addAction: \addToHead);
		~circleExt2.set(\phase,3);
		~circleExt2.set(\out,~circleExtOut2);
		~circleExt2.set(\mull,0.25);
		~circleExt.set(\ratio,0.65);
		~circleExt.set(\add, 0.3);
		~mixer1.set(\bmod,~circleExtOut2);

		~circleExtOut3 = Bus.control(s,1);
		~circleExt3 = Synth("myExtCircle",addAction: \addToHead);
		~circleExt3.set(\out,~circleExtOut3);
		~circleExt3.set(\phase,3);
		~circleExt3.set(\mull,0.15);
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


		~pad_firmus = MyEvents.new;
		~pad_firmus.amp = 0.04;
		~pad_firmus.init;

		~channel1 = {arg num, vel = 1;
			var ret;
			ret = ~midiFMdarkpad1.value(~pad_firmus,num);
			ret;
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

~dcs = 1.5;
~fscale = 1.0;

~release = 0.5;
~attack = 3.00;
~amp = 0.8;
~amp = 0.2;
~amp = 0;
~circleExt.set(\mull,0.9);
~circleExt.set(\sig2p,8);
~circleExt.set(\mull,0.1);
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
				// ~mixer3.set(\bal,1.0);
				~mixer3.set(\bal,0.0);
				~circleExt.set(\zgate,1);

				~midiBellDrum.value;
				~midiBassDrum.value;
				~midiCantus_firmus.value;
				~circle.set(\zgate,1);
				~midiSineDrum.value;
				~midiAdsr.value;
		);};); // End of t.schedAbs

		t.schedAbs(timeNow + 16,{ // 00 = Time in beats
			(
				~mixer1.set(\bal,0.0);
				~mixer2.set(\bal,0.0);
				~circleExt2.set(\zgate,1);
				~circleExt3.set(\zgate,1);

		);};); // End of t.schedAbs


		t.schedAbs(timeNow + 32,{ // 00 = Time in beats
			(

				~mixer4.set(\bal,-1);
				//	~mixer3.set(\bal,0.0);
				//	~circleExt.set(\zgate,1);
		);};); // End of t.schedAbs


		t.schedAbs(timeNow + (96-0.2),{ // 00 = Time in beats
			(
				//	~midistring1_firmus.value;
		);};); // End of t.schedAbs

		t.schedAbs(timeNow + (160-0.2),{ // 00 = Time in beats
			(
				//~midistring2_firmus.value;
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
