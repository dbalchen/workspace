Help.gui
Quarks.gui

s.boot;
s.plotTree;
s.meter;
s.quit;

FreqScope.new(400, 200, 0, server: s);
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
		// Put stuff here...........
		"/home/dbalchen/Music/song7/include/synths/FMPiano.sc".load;
		"/home/dbalchen/Music/song7/include/synths/eStrings.sc".load;
		"/home/dbalchen/Music/song7/include/synths/vangelis.sc".load;
		"/home/dbalchen/Music/song7/include/synths/FMpad.sc".load;
		"/home/dbalchen/Music/song7/include/synths/basicControlEnv.sc".load;
		"/home/dbalchen/Music/song7/include/synths/Tbell.sc".load;
		"/home/dbalchen/Music/song7/include/synths/strings.sc".load;
		"/home/dbalchen/Music/song7/include/synths/eSampler.sc".load;

		// Bells
		~track0 = MyTrack.new(~synth2,0);

		// Bass
		~track1 = MyTrack.new(~synth1,1);

		// Low Strings
		~track2 = MyTrack.new(~synth2,2);

		// Mid Strings
		~track3 = MyTrack.new(~synth2,3);

		// High Strings
		~track4 = MyTrack.new(~synth2,4);

		// Dark Pad
		~track5 = MyTrack.new(~synth2,5);

		// Open
		~track6 = MyTrack.new(~synth2,6);

		// Drums
		~track9 = MyTrack.new(~synth1,9);

		// Trumpet
		~track10 = MyTrack.new(~synth1,10);

		"/home/dbalchen/Music/song7/include/midiDefs.sc".load;


	)

};
)



~startup.value;
~startTimer.value(120);

~rp = {~start.value;};

~string_low_vca_envelope.gui;
~string_low_vcf_envelope.gui;

~belladsr.gui;


~rp = {}; // Example

(
~start = {

	var num = 120,timeNow;
	t = TempoClock.default.tempo = num / 60;

	Routine.run({
		s.sync;
		timeNow = TempoClock.default.beats;

		t.schedAbs(timeNow + 8,{ // 00 = Time in beats
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
