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
		"/home/dbalchen/Music/JamOn6/include/Patches/patchFunctions.sc".load;
		"/home/dbalchen/Music/JamOn6/include/Patches/midiDefs.sc".load;

	)

};
)

~startup.value;
~startTimer.value(120);
~synth2 = ~synth2.latency_(Server.default.latency);

~mixer1.set(\bal,1.0);
~mixer2.set(\bal,1.0);


~noiseSweep.value;
~noiseSweep2.value;

~pulseSweep.value;
~pulseSweepOff.value;

~circleOut = Bus.audio(s,1);
~circle = Synth("myCircle",addAction: \addToHead);
~circle.set(\out,~circleOut);
~circle.set(\gate,1);


~rp={
	s.sync;
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

~mixergui4 = SimpleMix.new;
~mixergui4.mixer = ~mixer4;
~mixergui4.gui;

~string1_firmus.filter.gui;
~string1_firmus.envelope.gui;

~circleExt2 = ~modCircle.value(~circleExt2Out,1,-1,((24*4)/2),((8*4)/2),0.25);
~mixer2.set(\bmod,~circleExt2Out);
~mixer2.set(\bal,0);
~circleExt2.set(\gate,1);

~circleExt3 = ~modCircle.value(~circleExt3Out,1,-0.5,((24*4)/2),((8*4)/2),0.5);
~mixer1.set(\bmod,~circleExt3Out);
~mixer1.set(\bal,0);
~circleExt3.set(\gate,1);

~vca1.set(\amp,0.0);
~noiseSweep.value;
~noiseSweep2.value;


TempoClock.default.tempo = 120 / 60;

(
~start = {

	var num = 120,timeNow;
	t = TempoClock.default.tempo = num / 60;
	Routine.run({
		s.sync;
		timeNow = TempoClock.default.beats;

		~mixer1.set(\bal,1.0);
		~mixer2.set(\bal,1.0);
		~stringSweep.value;

		t.schedAbs(timeNow + (8*4),{ // 00 = Time in beats
			(
			~noiseSweep.value;
			~noiseSweep2.value;
		);};); // End of t.schedAbs

		t.schedAbs(timeNow + (16*4),{ // 00 = Time in beats
			(
				~pulseAmp.value;
				~sineAmp.value;
		);};); // End of t.schedAbs


		t.schedAbs(timeNow + (32*4),{ // 00 = Time in beats
			(
				~pulseSweep.value;
		);};); // End of t.schedAbs


		t.schedAbs(timeNow + (96-0.2),{ // 00 = Time in beats
			(

		);};); // End of t.schedAbs

		t.schedAbs(timeNow + (160-0.2),{ // 00 = Time in beats
			(

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
