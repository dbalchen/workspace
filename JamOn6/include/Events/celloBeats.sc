// "/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;
~string1_firmus = nil;
~string1_firmus = nil;
~midistring1_firmus = nil;

~string1_firmusBOut = 0;

~string1_firmus = ~cf_clock.deepCopy;
~string1_firmus.filter = 1;
~string1_firmus.envelope = 1;
~string1_firmus.init;
~string1_firmus.envelope.init;
~string1_firmus.amp = 3.0;
~string1_firmus.envelope.attack = 0.5;
~string1_firmus.envelope.decay = 0.25;
~string1_firmus.envelope.sustain = 0.60;
~string1_firmus.envelope.release = 0.3;
~string1_firmus.filter.init;
~string1_firmus.filter.cutoff = 980.00;
~string1_firmus.filter.gain = 0.90;
~string1_firmus.filter.attack = 1.25;
~string1_firmus.filter.aoc = 0.85;
~string1_firmus.filter.release = 0.6;

~string1_firmusB = ~string1_firmus.deepCopy;
~string1_firmusB.filter.cutoff = 9800.00;
//~string1_firmusB.filter.aoc = 0.0;
~string1_firmusB.amp = 1.75;
~string1_firmusB.envelope.sustain = 1.0;
~string1_firmusB.filter.attack = 1.25;
~string1_firmusB.out = ~string1_firmusBOut;

~midistring1_firmus = {Pbind(\type, \midi,
	\midiout, ~synth2,
	\midicmd, \noteOn,
	\note,  Pfunc.new({~string1_firmus.freq.next}- 60),
	\amp, ~string1_firmus.amp,
	\chan, 1,
	\sustain, Pfunc.new({~string1_firmus.duration.next}),
	\dur, Pfunc.new({~string1_firmus.wait.next})
).play};

/*

~string1_firmus.envelope.gui;
~string1_firmus.filter.gui;

~string1_firmusB.envelope.gui;
~string1_firmusB.filter.gui;

*/

~defaultCello = {
	~string1_firmus.envelope.attack = 0.50;
	~string1_firmus.envelope.decay = 0.25;
	~string1_firmus.envelope.sustain = 0.60;
	~string1_firmus.envelope.release = 0.4;
	~string1_firmus.filter.cutoff = 980.00;
	~string1_firmus.filter.gain = 0.90;
	~string1_firmus.filter.attack = 1.25;
	~string1_firmus.filter.aoc = 0.85;
	~string1_firmus.filter.release = 0.6;
};


~defaultCelloB = {
	~string1_firmusB = ~string1_firmus.deepCopy;
	~string1_firmusB.filter.cutoff = 9800.00;
	~string1_firmusB.filter.aoc = 0.85;
	~string1_firmusB.amp = 0.1;
	~string1_firmusB.envelope.sustain = 1.0;
	~string1_firmusB.out = ~string1_firmusBOut;
};

~defaultCello.value();
~defaultCelloB.value();

~cello0 = {

	~defaultCello.value();

	~string1_firmus.waits = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
	~string1_firmus.freqs = [53,54,53,48,53,51,46,48,51,53,54,53,48,53,51,48,53,48,51];
	~string1_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
	~string1_firmus.durations = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
	~string1_firmus.envelope.attacks = [6.0,0.5,6.0,0.5,4.0,0.5,0.5,6.0,0.5,6.0,0.5,4.0,0.5,0.5,4.0,4.0,4.0,0.5,0.5];
	~string1_firmus.envelope.decays = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];

	~string1_firmus.envelope.attack = 0.1250;

	~defaultCelloB.value();
	~string1_firmusB.amp = 0.0;

};

~cello2 = {

	~defaultCello.value();

	~string1_firmus.waits = [6.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,8.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0];
	~string1_firmus.freqs = [55,51,53,48,53,51,48,46,48,54,56,58,53,49,46,51,54,48,51];
	~string1_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
	~string1_firmus.durations = [6.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,8.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0];
	~string1_firmus.envelope.attacks = [6.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,8.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0];
	~string1_firmus.envelope.decays = [6.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,8.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0];
	~string1_firmus.envelope.attack = 0.1250;

	~defaultCelloB.value();
	~string1_firmusB.amp = 0.05;

};


~cello3 = {

	~defaultCello.value();

	~string1_firmus.waits = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
	~string1_firmus.freqs = [53,54,53,48,51,53,51,48,48,51,53,54,53,48,53,55,48,53,48,51];
	~string1_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
	~string1_firmus.durations = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
	~string1_firmus.envelope.attacks = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
	~string1_firmus.envelope.decays = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];

	~defaultCelloB.value();
};


~cello4 = {

	~defaultCello.value();

	~string1_firmus.waits = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,6.0,2.0];
	~string1_firmus.freqs = [55,51,48,51,53,48,53,51,48,46,48,48,51,53,54,53,48,53,55,48,53,54];
	~string1_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
	~string1_firmus.durations = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,6.0,2.0];
	~string1_firmus.envelope.attacks = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,6.0,2.0];
	~string1_firmus.envelope.decays = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,4.0,6.0,2.0];

	~defaultCelloB.value();
};


~celloE = {
  ~defaultCello.value();

  ~string1_firmus.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,4.0];
  ~string1_firmus.freqs = [53,48,53,54,53,48,53,54,53,48,53,51,53];
  ~string1_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1];
  ~string1_firmus.durations = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
  ~string1_firmus.envelope.attacks = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
  ~string1_firmus.envelope.decays = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];

  ~defaultCelloB.value();
};
