"/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;
~string3_firmusBOut = 0;
~string3_firmus = ~cf_clock.deepCopy;
~string3_firmus.amp = 0.5;
~string3_firmus.filter = 1;
~string3_firmus.envelope = 1;
~string3_firmus.init;
~string3_firmus.envelope.init;
~string3_firmus.envelope.attack = 0.50;
~string3_firmus.envelope.decay = 2.0;
~string3_firmus.envelope.sustain = 0.6;
~string3_firmus.envelope.release = 0.6;
~string3_firmus.filter.init;
~string3_firmus.filter.aoc = 0.6;
~string3_firmus.filter.cutoff = 4200.00;
~string3_firmus.filter.gain = 0.7;
~string3_firmus.filter.attack = 0.50;
~string3_firmus.filter.sustain = 0.8;
~string3_firmus.filter.release = 0.6;

~midistring3_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string3_firmus.freq.next}- 60),
	\amp, ~string3_firmus.amp,
	\chan, 3,
	\sustain, Pfunc.new({~string3_firmus.duration.next}),
	\dur, Pfunc.new({~string3_firmus.wait.next})
).play};

/*

~string3_firmus.envelope.gui;
~string3_firmus.filter.gui;

~string3_firmusB.envelope.gui;
~string3_firmusB.filter.gui;

*/

~defaultViolin = {

	~string3_firmus.envelope.attacks = [ 1, 1, 1, 1 ];
	~string3_firmus.envelope.decays = [ 1, 1, 1, 1 ];
	~string3_firmus.envelope.attack = 0.50;
	~string3_firmus.envelope.decay = 2.0;
	~string3_firmus.envelope.sustain = 0.2;
	~string3_firmus.envelope.release = 0.6;
	~string3_firmus.filter.attack = 0.50;
	~string3_firmus.filter.release = 0.6;

};

~defaultViolinB = {

	~string3_firmusB = ~string3_firmus.deepCopy;
	~string3_firmusB.filter.cutoff = 9500.00;
	~string3_firmusB.amp = 0.25;
	~string3_firmusB.envelope.sustain = 0.6;
	~string3_firmusB.envelope.release = 0.6;
	~string3_firmus.envelope.decay = 0.9;
	~string3_firmus.envelope.attack = 0.8;
	~string3_firmusB.out = ~string3_firmusBOut;

};


~defaultViolin.value();
~defaultViolinB.value();

~violin1 = {

	~defaultViolin.value();

	~string3_firmus.waits = [24.0,4.0,2.0,2.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,4.0,2.0,1.0,1.0];
	~string3_firmus.freqs = [70,70,74,72,69,70,72,75,77,79,75,72,75,72,72,70,72];
	~string3_firmus.probs = [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
	~string3_firmus.durations = [1.0,4.0,2.0,2.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,4.0,2.0,1.0,1.0];
	~string3_firmus.envelope.attacks = [1.0,4.0,2.0,2.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,4.0,2.0,1.0,1.0];
	~string3_firmus.envelope.decays = [1.0,4.0,2.0,2.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,4.0,2.0,1.0,1.0];

	~defaultViolinB.value();
};

~violin2 = {

	~defaultViolin.value();

	~string3_firmus.waits = [2.0,2.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,4.0,4.0];
	~string3_firmus.freqs = [74,70,67,70,69,70,72,74,67,75,77,72,74,72,75,69,72];
	~string3_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
	~string3_firmus.durations = [2.0,2.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,4.0,4.0];
	~string3_firmus.envelope.attacks = [2.0,2.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,4.0,4.0];
	~string3_firmus.envelope.decays = [2.0,2.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,4.0,4.0];

	~defaultViolinB.value();
};

~violin3 = {

	~defaultViolin.value();

	~string3_firmus.waits = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,8.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,8.0];
	~string3_firmus.freqs = [72,73,72,75,77,74,70,72,72,73,72,75,77,79,75,72];
	~string3_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
	~string3_firmus.durations = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,8.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,8.0];
	~string3_firmus.envelope.attacks = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,8.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,8.0];
	~string3_firmus.envelope.decays = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,8.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,8.0];

	~defaultViolinB.value();
};


~violin4 = {

	~defaultViolin.value();

	~string3_firmus.waits = [2.0,2.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
	~string3_firmus.freqs = [74,70,67,70,69,70,72,74,67,72,70,72,75,77,79,75,72,75,77,78];
	~string3_firmus.probs =  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
	~string3_firmus.durations = [2.0,2.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
	~string3_firmus.envelope.attacks = [2.0,2.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
	~string3_firmus.envelope.decays = [2.0,2.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];

	~defaultViolinB.value();
};


~violinE = {

	~defaultViolin.value();

	~string3_firmus.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,4.0];
	~string3_firmus.freqs =  [77,72,77,78,77,72,77,78,77,72,77,75,77];
	~string3_firmus.probs =  [1,1,1,1,1,1,1,1,1,1,1,1,1];
	~string3_firmus.durations = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
	~string3_firmus.envelope.attacks = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
	~string3_firmus.envelope.decays = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];

	~defaultViolinB.value();
};