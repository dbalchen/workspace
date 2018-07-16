// =====================================================================
// MyTrack Class
// =====================================================================


MyTrack {
	var <>notes = nil,     <>synth = nil, <>out = 0,
	<>chan = 0,  <>balance = 0, <>spread = 0,
	<>amp = 1.0, <>transport = nil;

	*new {arg syn,chn = 0, nts = nil;
		^super.new.init(syn,chn,nts);
	}

	init {arg syn,chn,nts;

		chan = chn;

		if(nts == nil,
			{
				notes = MyNotes.new;
				notes.init;
		});

		synth = syn;

		this.setup();
	}


	setup {

		if(transport != nil,
			{transport.stop;transport = nil; });

		transport = Pbind(\type, \midi,
			\midiout, synth,
			\midicmd, \noteOn,
			\note,  Pfunc.new({notes.freq.next}- 60),
			\amp, amp,
			\chan, chan,
			\sustain, Pfunc.new({notes.duration.next}),
			\dur, Pfunc.new({notes.wait.next})
		).play;

		transport.stop;
	}

}
