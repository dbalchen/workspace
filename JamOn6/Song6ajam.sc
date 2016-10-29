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
		"/home/dbalchen/Music/JamOn6/include/Synths/e_monoStrings.sc".load;
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


~dcs = 0.4;
~fscale = 16.0;
~release = 0.1;
~attack = 0.00;
~amp = 0.02;
//
~rp={
	s.sync;
	~midiClock.value;
	~midicf_clock.value;
	~midistring1_firmus.value;
};

~rp={
	s.sync;
~midiBellDrum.value
};


~myadsr.gui;

~mixer1.set(\bal,-0.5);
~mixer2.set(\bal,-0.25);

~noiseSweepOff.value;
~noiseSweep2Off.value;
~mixer1.set(\bal,1);
~mixer2.set(\bal,1);

~mixer3.set(\bal,0.8);
~mixer4.set(\bal,1);

~mixergui1.gui;
~mixergui2.gui;
~mixergui3.gui;
~mixergui4.gui;

~string1_firmus.filter.gui;
~string1_firmus.envelope.gui;

~string1_firmus.amp = 1.5;
~string2_firmus.amp = 2;

~vca1.set(\amp,0.0);

~rp={
~noiseSweep.value(1,-1,((24*4)/2), ((8*4)/2), 0.75);
~noiseSweep2.value(1,-0.25,((24*4)/2),((8*4)/2), 0.75);
}


~rp={
~noiseSweep.value(-1,1,((24*4)/2), ((8*4)/2), 0.25);
~noiseSweep2.value(-0.25,1,((24*4)/2),((8*4)/2), 0.75);
}



~noiseSweepOff.value;
~noiseSweep2Off.value;


~rp={
~circleExt4.set(\gate,0);
~pulse1.set(\bamp,998);
~pulse1.set(\amp,0);

~pulseAmp.value(0,1,((16*4)/2),((8*4)/2),-0.85);
~pulse1.set(\bamp,~circleExt4Out);
~pulse1.set(\amp,0);

	//~pulseSweep.value;
}


~rp={
~circleExt4.set(\gate,0);
~pulse1.set(\bamp,998);
~pulse1.set(\amp,0);

~pulseAmp.value(0,1,((16*4)/2),((8*4)/2),-0.75);
~pulse1.set(\bamp,~circleExt4Out);
~pulse1.set(\amp,0);

~pulseSweep.value;
}



~pulseSweepOff.value(-1,0.8,((16*4)/2),((8*4)/2),0.05);

~rp={
~pulseAmp.value(1,0,((16*4)/2),((8*4)/2),-0.75);
~pulse1.set(\bamp,~circleExt4Out);
~pulse1.set(\amp,0);
}


~rp={
~midistring1_firmus.value;
}


~rp={
~midistring2_firmus.value;
}

~midistring1_firmus = nil;

~string1_firmus - nil;



~circleExt5.set(\gate,0);
~vca1.set(\bamp,998);
~vca1.set(\amp,0.5);

~rp={
	~circleExt5.set(\gate,0);
~vca1.set(\bamp,998);
~vca1.set(\amp,0);
~sineAmp.value(0, 0.45,((16*4)/2), ((8*4)/2), 0.75);
~vca1.set(\bamp,~circleExt5Out);
	~vca1.set(\amp,0.0);
	~circleExt4.set(\gate,0);
~pulse1.set(\bamp,998);
~pulse1.set(\amp,0);

~pulseAmp.value(0,1,((16*4)/2),((8*4)/2),-0.75);
~pulse1.set(\bamp,~circleExt4Out);
~pulse1.set(\amp,0);

}

~rp={
		~circleExt5.set(\gate,0);
~vca1.set(\bamp,998);
~vca1.set(\amp,0);
		~circleExt4.set(\gate,0);
	~pulse1.set(\bamp,998);
	
~sineAmp.value(0.45,0,((16*4)/2), ((8*4)/2), 0.75);
~vca1.set(\bamp,~circleExt5Out);
	~vca1.set(\amp,0.0);
	~pulseAmp.value(1,0,((16*4)/2),((8*4)/2),-0.75);
~pulse1.set(\bamp,~circleExt4Out);
~pulse1.set(\amp,0);
}

~vca1.set(\amp,0.30);
~pulse1.set(\amp,1);

TempoClock.default.tempo = 120 / 60;

(
~start = {

	var num = 120,timeNow;
	t = TempoClock.default.tempo = num / 60;
	Routine.run({
		s.sync;
		timeNow = TempoClock.default.beats;
~startTimer.value(120);
	}); // End of Routine

}; //End of Start

)

~startup.value;
~startTimer.value(120);
~synth2 = ~synth2.latency_(Server.default.latency);
~rp = {~start.value;};
s.boot;
s.quit;
