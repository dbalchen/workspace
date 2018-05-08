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

"/home/dbalchen/Music/MyAmbientTune/include/synths/envelopes.sc".load;
"/home/dbalchen/Music/MyAmbientTune/include/synths/eStrings.sc".load;
"/home/dbalchen/Music/MyAmbientTune/include/patch/LowStrings.sc".load;
"/home/dbalchen/Music/MyAmbientTune/include/classes/PitchClass.sc".load;
"/home/dbalchen/Music/MyAmbientTune/include/synths/eSampler.sc".load;
"/home/dbalchen/Music/MyAmbientTune/include/patch/strings.sc".load;
"/home/dbalchen/Music/MyAmbientTune/include/patch/cello.sc".load;
"/home/dbalchen/Music/MyAmbientTune/include/patch/viola.sc".load;

~motif = [57,59,57,61,56,52,59];

~lowStrings = MyTrack.new(~synth1,0);
~lowStrings.notes.waits = [6.0,1.0,1.0,2.0,2.0,2.0,2.0];
~lowStrings.notes.freqs = ~motif - 12;
~lowStrings.notes.probs = [1,1,1,1,1,1,1];
~lowStrings.notes.durations = [6.0,1.0,1.0,2.0,2.0,2.0,2.0];
~lowStrings.notes.init;
~lowStrings.amp = 1.35;
~lowStrings.notes.lag = 0.25;

~cello = MyTrack.new(~synth1,1);
~cello.notes.waits = [6.0,1.0,1.0,2.0,2.0,2.0,2.0];
~cello.notes.freqs = ~motif;
~cello.notes.probs = [1,1,1,1,1,1,1];
~cello.notes.durations = [6.0,1.0,1.0,2.0,2.0,2.0,2.0];
~cello.notes.init;
~cello.amp = 0.80;

~viola = MyTrack.new(~synth1,2);
~viola.notes.waits = [6.0,1.0,1.0,2.0,2.0,2.0,2.0];
~viola.notes.freqs = ~motif + 12;
~viola.notes.probs = [1,1,1,1,1,1,1];
~viola.notes.durations = [6.0,1.0,1.0,2.0,2.0,2.0,2.0];
~viola.notes.init;
~viola.amp = 0.80;



"/home/dbalchen/Music/MyAmbientTune/include/midiDefs.sc".load;

)


~startup.value;
~startTimer.value(90);

~lowStrings.transport.play;
~lowStrings.transport.stop;
~lowStrings.transport.mute;
~lowStrings.transport.unmute;


~cello.transport.play;
~cello.transport.stop;
~cello.transport.mute;
~cello.transport.unmute;


~viola.transport.play;
~viola.transport.stop;
~viola.transport.mute;
~viola.transport.unmute;

~rp = {~cello.transport.play;~lowStrings.transport.play;~viola.transport.play;};
~rp = {~cello.transport.play;};
~rp = {~viola.transport.play;};
~rp = {~lowStrings.transport.play;};

~keyoff = 8;
~dic = ~buildDic.value([0,1,3,5,8],[0,2,4,7,9]);
~dic = ~buildDic.value([0,1,3,5,8],[0,1,2,3,4]);
~dic = ~buildDic.value([0,1,3,5,8],[0,2,4,6,9]);


~motif = [57,59,57,61,56,52,59];

~motif = ~fullDic.value([57,59,57,61,56,52,59],~dic,~keyoff);

~lowStrings.notes.freqs = ~motif - 12;
~cello.notes.freqs = ~motif -5 ;
~viola.notes.freqs = ~motif + 12;

~viola.notes.freqs = ~motif + 12 + 4;
t = TempoClock.default.tempo = 90 / 60;


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
