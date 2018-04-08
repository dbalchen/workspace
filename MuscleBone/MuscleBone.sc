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

"/home/dbalchen/Music/MyTechnoSong/include/synths/envelopes.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/synths/kick.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/synths/eStrings.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/synths/eSampler.sc".load;

"/home/dbalchen/Music/MyTechnoSong/include/events/bassDrum.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/patch/bassDrum.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/patch/strings.sc".load;

"/home/dbalchen/Music/MyTechnoSong/include/events/LowStrings.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/patch/LowStrings.scd".load;
"/home/dbalchen/Music/MyTechnoSong/include/events/viola.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/patch/viola.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/events/violin.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/patch/violin.sc".load;
"/home/dbalchen/Music/MyTechnoSong/include/midiDefs.sc".load

)

~startTimer.value(120);

~bassDrum.transport.mute;~bassDrumNotes.transport.mute;
~bassDrum.transport.unmute;~bassDrumNotes.transport.unmute;

~lowStrings.transport.mute;
~lowStrings.transport.unmute;

~viola.transport.mute;~viola2.transport.mute;
~viola.transport.unmute;~viola2.transport.unmute;

~violin2.transport.mute;~violin.transport.mute;
~violin2.transport.unmute;~violin.transport.unmute;

~bassDrum.transport.play;~bassDrumNotes.transport.play;
~lowStrings.transport.play;
~viola2.transport.play;~viola.transport.play;
~violin.transport.play;~violin2.transport.play;


~rp = {~lowStrings.transport.play;};
~rp = {~viola2.transport.play;~viola.transport.play;};
~rp = {~violin.transport.play;~violin2.transport.play;};
~rp = {~initialBassDrum.value;~bassDrum.transport.play;~bassDrumNotes.transport.play;}; // Example

~rp = {	~lowStringsInit4.value();~lowStrings.transport.play; ~viola2.transport.play;~viola.transport.play;};

~rp = {~violin.transport.play;~violin2.transport.play;~viola2.transport.play;~viola.transport.play;~lowStrings.transport.play;~bassDrum.transport.play;~bassDrumNotes.transport.play;};


(
~start = {

	var num = 120,timeNow;
	t = TempoClock.default.tempo = num / 60;

	Routine.run({
		s.sync;
		timeNow = TempoClock.default.beats;

		t.schedAbs(timeNow + 00,{ // 00 = Time in beats
			(
				~initialBassDrum.value;~bassDrum.transport.play;~bassDrumNotes.transport.play;
				~bassDrumPulseSaw.value(1);
			);


		};	 // End of if statement

		); // End of t.schedAbs


		t.schedAbs(timeNow + (4*8),{ // 00 = Time in beats
			(

				~lowStrings.transport.play;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement

		); // End of t.schedAbs

		t.schedAbs((timeNow + (4*16) - 0.01),{ // 00 = Time in beats
			(
				~lowStringsInit4.value();
				~viola2.transport.play;~viola.transport.play;

			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement

		); // End of t.schedAbs

		t.schedAbs((timeNow + (4*24)) - 0.01 ,{ // 00 = Time in beats
			(
				~bassDrumOnFour.value();
				~lowStringsInitStop.value;
				~violaInitStop.value;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement

		); // End of t.schedAbs

		t.schedAbs((timeNow + (4*25)) ,{ // 00 = Time in beats
			(
				~violin.transport.play;~violin2.transport.play;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement

		); // End of t.schedAbs


		t.schedAbs((timeNow + (4*26)) - 1,{ // 00 = Time in beats
			(
				~initialBassDrum.value;
				~bassDrumNotes.notes.init;
				~lowStringsInit.value();
				~lowStringsEnvRest.value;
				~violaVerse1.value;
				~violinVerse1.value;
				~violaEnv2.value;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement


		); // End of t.schedAbs
		//Add more


		t.schedAbs((timeNow + (4*34)) - 1,{ // 00 = Time in beats
			(
				~bassDrum2ndVerse.value();
				~violaVerse2.value;
				~violinVerse2.value;
				~lowStringsVerse1.value();
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement
		); // End of t.schedAbs



		t.schedAbs((timeNow + (4*42)) - 1,{ // 00 = Time in beats
			(
				~bassDrum1st8.value;
				~lowStringsVerse2.value();
				~violaVerse3.value;
				~violinVerse3.value;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement
		); // End of t.schedAbs


		t.schedAbs((timeNow + (4*50)) - 1,{ // 00 = Time in beats
			(
				~bassDrum2nd8.value;
				~lowStringsVerse3.value();
				~violaVerse4.value;
				~violinVerse4.value;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement
		); // End of t.schedAbs


		t.schedAbs((timeNow + (4*58)) - 1,{ // 00 = Time in beats
			(
				~bassDrumBig1.value;
				~lowStringsVerse4.value();
				~violaVerse5.value;
				~violinVerse5.value;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement
		); // End of t.schedAbs



		t.schedAbs((timeNow + (4*66)) - 1,{ // 00 = Time in beats
			(
				~bassDrumBig2.value;
				~lowStringsVerse5.value();
				~violaVerse6.value;
				~violinVerse6.value;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement
		); // End of t.schedAbs


		t.schedAbs((timeNow + (4*74)) - 1,{ // 00 = Time in beats
			(
				~bassDrum3rd8.value;
				~lowStringsVerse6.value();
				~violaVerse7.value;
				~violinVerse7.value;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement
		); // End of t.schedAbs


		t.schedAbs((timeNow + (4*82)) - 1,{ // 00 = Time in beats
			(
				~bassDrum3rdVerse.value();
				~lowStringsVerse7.value();
				~violaVerse8.value;
				~violinVerse8.value;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement
		); // End of t.schedAbs


		t.schedAbs((timeNow + (4*90)) - 1,{ // 00 = Time in beats
			(
				~bassDrumEnding.value();
				~lowStringsVerse8.value();
				~violaVerse9.value;
				~violinVerse9.value;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement
		); // End of t.schedAbs


		t.schedAbs((timeNow + (4*104)) - 1,{ // 00 = Time in beats
			(
				~bassDrumFinal.value();
				~lowStrings.transport.mute;
				~viola.transport.mute;~viola2.transport.mute;
				~violin2.transport.mute;~violin.transport.mute;
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement
		); // End of t.schedAbs

	}); // End of Routine

}; //End of Start

)

~startTimer.value(120);
~rp = {~start.value;};
