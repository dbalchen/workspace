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


	)

};
)

~startup.value;
~startTimer.value(120);
~synth2 = ~synth2.latency_(Server.default.latency);


~dcs = 1.0;
~fscale = 1.0;
~release = 0.5;
~attack = 3.00;
~amp = 0.1;

~mixer1.set(\bal,1.0);
~mixer2.set(\bal,1.0);

~circleExtOut = Bus.control(s,1);
~circleExt = nil;
~circleExt = Synth("myExtCircle",addAction: \addToHead);
~circleExt.set(\out,~circleExtOut);
~circleExt.set(\phase,1);
~circleExt.set(\mull,0.1);
~circleExt.set(\ratio,0.98);
~circleExt.set(\mull,0.9);
~circleExt.set(\sig2p,16);
~circleExt.set(\sigp,256);
~circleExt.set(\mull,0.9);
~mixer3.set(\bmod,~circleExtOut);
~mixer3.set(\bal,0);
~circleExt.set(\gate,1);



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
