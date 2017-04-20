// =====================================================================
// MyTrack Class
// =====================================================================


MyTrack {
	var <>notes = nil,     <>synth = nil,
	<>chan = 0,        <>out = 0,
	<>amp = 1.0,        <>transport;

	init {
		notes = MyNotes.new;
		notes.init;
		this.play;
	}


	play {
		transport = Pbind(\type, \midi,
			\midiout, synth,
			\midicmd, \noteOn,
			\note,  Pfunc.new({notes.freq.next}- 60),
			\amp, amp,
			\chan, chan,
			\sustain, Pfunc.new({notes.duration.next}),
			\dur, Pfunc.new({notes.wait.next})
		);
	}

}
