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
		~scale = Scale.majorPentatonic.degrees.collect({ arg item, i; item; item}) + 72;

		~clock = MyTrack.new(~synth1,0);
		~clock.notes.probs = Bjorklund(15, 32);
		~clock.notes.freqs = ~clock.notes.probs.collect({ arg item, i; item; item*~scale.choose});

	)

};
)

~startup.value;
~startTimer.value(60);

~clock.transport.play;
~clock.transport.stop;

~rp = {}; // Example

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
