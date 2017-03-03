"/home/dbalchen/Music/JamOn6/include/Events/beats.sc".load;
~string2_firmusBOut = 0;
~string2_firmus = ~cf_clock.deepCopy;
~string2_firmus.filter = 1;
~string2_firmus.envelope = 1;
~string2_firmus.amp = 1.2;
~string2_firmus.init;
~string2_firmus.envelope.init;
~string2_firmus.envelope.attack = 1.25;
~string2_firmus.envelope.decay = 0.25;
~string2_firmus.envelope.sustain = 0.6;
~string2_firmus.envelope.release = 0.8;
~string2_firmus.filter.init;
~string2_firmus.filter.aoc = 0.6;
~string2_firmus.filter.cutoff = 3500.00;
~string2_firmus.filter.gain = 0.5;
~string2_firmus.filter.attack = 0.5;
~string2_firmus.filter.release = 0.8;

~midistring2_firmus = {Pbind(\type, \midi,
    \midiout, ~synth2,
    \midicmd, \noteOn,
    \note,  Pfunc.new({~string2_firmus.freq.next}- 60),
    \amp, ~string2_firmus.amp,
    \chan, 2,
    \sustain, Pfunc.new({~string2_firmus.duration.next}),
    \dur, Pfunc.new({~string2_firmus.wait.next})
).play};

/*

~string2_firmus.envelope.gui;
~string2_firmus.filter.gui;




~string2_firmusB.envelope.gui;
~string2_firmusB.filter.gui;

*/

~defaultViola = {
    ~string2_firmus.amp = 0.80;
    ~string2_firmus.envelope.attacks = [ 1, 1, 1, 1 ];
    ~string2_firmus.envelope.decays = [ 1, 1, 1, 1 ];
    ~string2_firmus.envelope.attack = 0.125;
    ~string2_firmus.envelope.decay = 0.85;
    ~string2_firmus.envelope.sustain = 0.2;
    ~string2_firmus.envelope.release = 0.6;
    ~string2_firmus.filter.attack = 0.80;
    ~string2_firmus.filter.release = 0.9;
};

~defaultViolaB = {
    ~string2_firmusB = ~string2_firmus.deepCopy;
    ~string2_firmusB.filter.cutoff = 9000.00;
    ~string2_firmusB.amp = 0.2;
    ~string2_firmusB.envelope.sustain = 0.8;
    ~string2_firmusB.envelope.release = 0.8;
    ~string2_firmus.envelope.decay = 0.9;
    ~string2_firmus.envelope.attack = 1.0;
	~string2_firmusB.out = ~string2_firmusBOut;


};

~defaultViola.value();
~defaultViolaB.value();

~viola0 = {

    ~defaultViola.value();
    ~string2_firmus.amp = 1.5;
    ~string2_firmus.waits = [32.0,6.0,2.0,6.0,1.0,1.0,4.0,2.0,2.0,4.0,2.0,2.0];
    ~string2_firmus.freqs = [65,65,66,69,70,69,65,60,63,65,60,63];
    ~string2_firmus.probs = [0,1,1,1,1,1,1,1,1,1,1,1];
    ~string2_firmus.durations = [1.0,6.0,2.0,6.0,1.0,1.0,4.0,2.0,2.0,4.0,2.0,2.0];
    ~string2_firmus.envelope.attacks = [1.0,6.0,2.0,6.0,1.0,1.0,4.0,2.0,2.0,4.0,2.0,2.0];
    ~string2_firmus.envelope.decays = [1.0,6.0,2.0,6.0,1.0,1.0,4.0,2.0,2.0,4.0,2.0,2.0];

    ~defaultViolaB.value();
	~string2_firmusB.amp = 0.15;
};


~viola1 = {

    ~defaultViola.value();

    ~string2_firmus.waits = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,1.0,1.0];
    ~string2_firmus.freqs = [65,63,58,60,63,62,60,63,56,58,62,60,65,63,58,60,63,65,67,63,60,63,65,58,65];
    ~string2_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
    ~string2_firmus.durations =[6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,1.0,1.0];
    ~string2_firmus.envelope.attacks = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,1.0,1.0];
    ~string2_firmus.envelope.decays =[6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,1.0,1.0];

    ~defaultViolaB.value();
};

~viola2 = {

    ~defaultViola.value();

    ~string2_firmus.waits = [4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,8.0,4.0,4.0,4.0,4.0];
    ~string2_firmus.freqs = [67,63,62,65,63,65,67,60,66,68,65,63,66,60,63];
    ~string2_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
    ~string2_firmus.durations = [4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,8.0,4.0,4.0,4.0,4.0];
    ~string2_firmus.envelope.attack = 1.0;
    ~string2_firmus.envelope.attacks = [4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,8.0,4.0,4.0,4.0,4.0];
    ~string2_firmus.envelope.decays = [4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,8.0,4.0,4.0,4.0,4.0];

    ~defaultViolaB.value();
};

~viola3 = {

    ~defaultViola.value();

    ~string2_firmus.amp = 1.0;
    ~string2_firmus.waits = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,2.0,1.0,1.0];
    ~string2_firmus.freqs = [65,66,69,70,65,67,63,60,63,65,66,69,70,72,67,63,65,60,63,65];
    ~string2_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
    ~string2_firmus.durations = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,2.0,1.0,1.0];
    ~string2_firmus.envelope.attacks = [4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,8.0,4.0,4.0,4.0,4.0];
    ~string2_firmus.envelope.decays =[4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,4.0,4.0,8.0,4.0,4.0,4.0,4.0];

    ~defaultViolaB.value();
};

~viola4 = {

    ~defaultViola.value();

    ~string2_firmus.amp = 1.0;
    ~string2_firmus.waits = [4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
    ~string2_firmus.freqs = [67,63,62,65,63,65,67,60,65,63,58,60,63,65,67,63,60,63,65,66];
    ~string2_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
    ~string2_firmus.durations = [4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
    ~string2_firmus.envelope.attacks = [4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
    ~string2_firmus.envelope.decays = [4.0,2.0,2.0,8.0,4.0,2.0,2.0,8.0,6.0,1.0,1.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];

    ~defaultViolaB.value();
};

~violaE = {

    ~defaultViola.value();
 ~string2_firmus.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,4.0];
 ~string2_firmus.freqs = [65,60,65,66,65,60,65,66,65,60,65,63,65];
 ~string2_firmus.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1];
 ~string2_firmus.durations = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];

 ~string2_firmus.envelope.attacks =  [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
 ~string2_firmus.envelope.decays =  [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];

    ~defaultViolaB.value();
};