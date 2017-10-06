Help.gui
Quarks.gui

s.boot;
s.plotTree;
s.meter;
s.quit;

Server.default.makeGui
Stethoscope.new(s);
FreqScope.new(800, 400, 0, server: s);

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
		"/home/dbalchen/Music/song7/include/synths/eStrings.sc".load;
		"/home/dbalchen/Music/song7/include/synths/FMpad.sc".load;
		"/home/dbalchen/Music/song7/include/synths/basicControlEnv.sc".load;
		"/home/dbalchen/Music/song7/include/synths/Tbell.sc".load;
		"/home/dbalchen/Music/song7/include/synths/strings.sc".load;
		"/home/dbalchen/Music/song7/include/synths/eSampler.sc".load;
		"/home/dbalchen/Music/song7/include/synths/Sax.sc".load;

		// Bells
		~track0 = MyTrack.new(~synth2,0);

		// Sax
		~track1 = MyTrack.new(~synth2,1);

		// Low Strings
		~track2 = MyTrack.new(~synth2,2);

		// Mid Strings
		~track3 = MyTrack.new(~synth2,3);

		// High Strings
		~track4 = MyTrack.new(~synth2,4);

		// Dark Pad
		~track5 = MyTrack.new(~synth2,5);

		// Piano
		~track6 = MyTrack.new(~synth2,6);

		// Drums

		~allTimeswaits = [0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25];
		~allTimesdurations = [0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25];

		~track9 = MyTrack.new(~synth1,9);
		~track9.notes.freqs = [36,0,0,38,0,36,0,0,0,36,0,38,0,36,0,36,0,0,38,0,36,0,0,0,36,0,38,0,36,0];
		~track9.notes.waits	= ~allTimeswaits.deepCopy;
		~track9.notes.durations = ~allTimesdurations.deepCopy;
		~track9.notes.probs =  [1,0,0,1,0,1,0,0,0,1,0,1,0,1,0,1,0,0,1,0,1,0,0,0,1,0,1,0,1,0];


		~track9Toms = MyTrack.new(~synth1,9);
		~track9Toms.notes.freqs = [41,45,43,0,45,41,41,43,45,45,43,41,41,43,45,41,45,43,0,45,41,41,43,45,45,43,41,41,43,45];
		~track9Toms.notes.waits	= ~allTimeswaits.deepCopy;
		~track9Toms.notes.durations = ~allTimesdurations.deepCopy;

		~track9Toms.notes.probs = [1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1,0,0,0];
		~track9Toms.notes.probs = [1,0,0,0,0,1,0,0,0,1,0,1,0,1,0,1,0,0,0,0,1,0,0,0,1,0,1,0,1,0] * 1;

		// favorite so far
		~track9Toms.notes.probs = [0.75,0.2,0.2,0,0.6,0.75,0.4,0.6,0.2,0,0.2,0.75,0.2,0,0.2,0.75,0.2,0.2,0,0.6,0.75,0.4,0.6,0.2,0,0.2,0.75,0.2,0,0.2] * 1;


		~track9Toms.notes.probs = [0.75,0.2,0.2,0,0.6,0.75,0.4,0.6,0.2,0.8,0.2,0.75,0.2,0.8,0.2,0.75,0.2,0.2,0,0.6,0.75,0.4,0.6,0.2,0.8,0.2,0.75,0.2,0.8,0.2] * 1;


		~track9Toms.notes.probs = [1,0.2,0.2,0,0.6,1,0.4,0.6,0.2,0.8,0.2,1,0.2,0.8,0.2,1,0.2,0.2,0,0.6,1,0.4,0.6,0.2,0.8,0.2,1,0.2,0.8,0.2] * 0.50;


		"/home/dbalchen/Music/song7/include/midiDefs.sc".load;


	)
};
)
//


~startup.value;
~startTimer.value(120);

~rp = {~start.value;};

~string_low_vca_envelope.gui;
~string_low_vcf_envelope.gui;

~belladsr.gui;
~belladsr6.gui;

~saxadsr.gui;
~saxadsrf.gui;


~rp = {}; // Example

~rp = {~track9.transport.start}; // Example
~rp = {~track9Toms.transport.start};
~rp = {~track9Toms.transport.stop};

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
