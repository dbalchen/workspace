"/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;

~string1_firmus = ~cantus_firmus.deepCopy;
~string1_firmus.filter = 1;
~string1_firmus.envelope = 1;
~string1_firmus.freqs = [53,51,55,53,51,48] + 24;
~string1_firmus.init;
~string1_firmus.envelope.attacks = [8.0,4.0,4.0,8.0,4.0,4.0];
~string1_firmus.envelope.decays =  [8.0,4.0,4.0,8.0,4.0,4.0];
~string1_firmus.envelope.releases = [1,1,1,1,1,1];
~string1_firmus.envelope.attack = 0.75;
~string1_firmus.envelope.decay = 0.5;
~string1_firmus.envelope.sustain = 0.0;
~string1_firmus.envelope.release = 0.44;
~string1_firmus.envelope.init;
~string1_firmus.filter.init;
~string1_firmus.filter.cutoff = 2800.00;
~string1_firmus.filter.gain = 1.5;
~string1_firmus.filter.release = 1.2;

~midistring1_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string1_firmus.freq.next}- 60),
	\amp, ~string1_firmus.amp,
	\chan, 1,
	\sustain, Pfunc.new({~string1_firmus.duration.next}),
	\dur, Pfunc.new({~string1_firmus.wait.next})
).play};


~string2_firmus = ~string1_firmus.deepCopy;
~string2_firmus.waits = (~string1_firmus.waits ++ ~string1_firmus.waits)  * 0.5;
//~p0 = Prand([62,58,65,60,56,63,64,67,57,53,55],inf).asStream.next;
~p0 = Prand([60,58,62,65],inf).asStream.next;
~p1 = Prand([65,60,62],inf).asStream.next;
~p2 = Prand([60,62,58],inf).asStream.next;

~p3 = Prand([63,60,58,56],inf).asStream.next;
~p4 = Prand([60,62,67,51],inf).asStream.next;
~p5 = Prand([67,53,62,60],inf).asStream.next;

~p6 = Prand([62,58,60,62],inf).asStream.next;
~p7 = Prand([58,62,65,60],inf).asStream.next;
~p8 = Prand([62,65,60,58],inf).asStream.next;

~p9 = Prand([60,58,56],inf).asStream.next;
~p10 = Prand([55,57,53,60],inf).asStream.next;
~p11 = Prand([53,55,57],inf).asStream.next;
~string2_firmus.freqs = [~p0,~p1,~p2,~p3,~p4,~p5,~p6,~p7,~p8,~p9,~p10,~p11];
~string2_firmus.freqs = [ 65, 62, 60, 58, 51, 62, 60, 58, 60, 58, 53, 57 ];
~string2_firmus.freqs = [ 58, 60, 58, 63, 60, 62, 58, 62, 65, 58, 53, 57 ];
~string2_firmus.freqs =  [ 62, 65, 62, 58, 62, 67, 60, 65, 60, 60, 53, 57 ];

~string2_firmus.freqs = [60,65,62,63,60,67,62,58,62,60,55,53];
~string2_firmus.freqs = [58,60,62,60,62,60,58,62,65,58,57,55];
~string2_firmus.freqs = [58,65,62,60,60,53,58,65,60,58,53,57];
~string2_firmus.freqs = [65,62,60,58,60,53,60,62,60,58,53,57];
~string2_firmus.freqs = [58,60,58,63,67,62,60,62,60,56,60,57];
~string2_firmus.freqs = [62,65,58,56,51,60,62,58,62,60,53,57];


//~string2_firmus.freqs = Array.fill(12,{~p0.next});
~string2_firmus.probs =  [1,1,1,1,1,1,1,1,1,1,1,1] * 1.0;
~string2_firmus.durations = (~string1_firmus.durations ++ ~string1_firmus.durations) * 0.50;
~string2_firmus.init;
~string2_firmus.envelope.attacks =  (~string1_firmus.envelope.attacks ++ ~string1_firmus.envelope.attacks) * 0.5;
~string2_firmus.envelope.decays =   (~string1_firmus.envelope.decays ++ ~string1_firmus.envelope.decays) * 0.5;
~string2_firmus.envelope.releases =  (~string1_firmus.envelope.releases ++  ~string1_firmus.envelope.releases) * 0.5;
~string2_firmus.envelope.attack = 0.75;
~string2_firmus.envelope.decay = 0.5;
~string2_firmus.envelope.sustain = 0.0;
~string2_firmus.envelope.release = 0.5;
~string2_firmus.envelope.init;
~string2_firmus.filter.init;
~string2_firmus.filter.cutoff = 3800.00;
~string2_firmus.filter.gain = 1.5;

~string2_firmus.filter.release = 1.2;

~midistring2_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string2_firmus.freq.next}- 60),
	\amp, ~string2_firmus.amp,
	\chan, 3,
	\sustain, Pfunc.new({~string2_firmus.duration.next}),
	\dur, Pfunc.new({~string2_firmus.wait.next})
).play};
