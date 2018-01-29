Help.gui
Quarks.gui

s.boot;
s.plotTree;
s.meter;
s.quit;

Stethoscope.new(s);
FreqScope.new(800, 400, 0, server: s);
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

		"/home/dbalchen/Music/MyTechnoSong/include/synths/envelopes.sc".load;
		"/home/dbalchen/Music/MyTechnoSong/include/synths/kick.sc".load;
		"/home/dbalchen/Music/MyTechnoSong/include/synths/eStrings.sc".load;
		"/home/dbalchen/Music/MyTechnoSong/include/events/bassDrum.sc".load;
		"/home/dbalchen/Music/MyTechnoSong/include/patch/bassDrum.sc".load;

		"/home/dbalchen/Music/MyTechnoSong/include/events/LowStrings.sc".load;
		"/home/dbalchen/Music/MyTechnoSong/include/patch/LowStrings.scd".load;
		"/home/dbalchen/Music/MyTechnoSong/include/midiDefs.sc".load

	)

};
)

~myadsr.gui
~mixergui.gui

~string_low_vca_envelope.gui
~string_low_vcf_envelope.gui

~startup.value;
~startTimer.value(120);

~bassDrum.transport.play;~bassDrumNotes.transport.play;
~bassDrum.transport.stop;
~rp = {~lowStrings.transport.play;};


~rp = {~bassDrum.transport.play;~bassDrumNotes.transport.play;}; // Example


~rp = {~lowStrings.transport.play;~bassDrum.transport.play;~bassDrumNotes.transport.play;}; // Example

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
