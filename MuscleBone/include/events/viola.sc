~viola = MyTrack.new(~synth1,2);
~viola2 = MyTrack.new(~synth1,4);
~viola.amp = 0.24;
~viola2.amp = 0.12;


~violaInit = {

	~viola.notes.freqs = ([65,66,68,66,65,59,61] - 3);
	~viola.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,12.0];
	~viola.notes.durations = [6.0,2.0,6.0,2.0,6.0,2.0,12.0];

	~viola2.notes.freqs = ([65,66,68,66,65,59,61] - 3);
	~viola2.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,12.0];
	~viola2.notes.durations = [6.0,2.0,6.0,2.0,6.0,2.0,12.0];

};

~violaInit.value;
~viola.notes.init;
~viola2.notes.init;


~violaInitStop = {
	//End start
	~viola.notes.waits = [2.0,1.0,1.0];
	~viola.notes.freqs = [36,65,68];
	~viola.notes.probs = [0,1,1];
	~viola.notes.durations = [2.0,1.0,1.0];


	~viola2.notes.waits = [2.0,1.0,1.0];
	~viola2.notes.freqs = [36,65,68];
	~viola2.notes.probs = [0,1,1];
	~viola2.notes.durations = [2.0,1.0,1.0];
};


// Part 2
~violaVerse1 = {
	~viola.notes.freqs = [70,68,63,65,68,67,65,68,61,63,67,60];
	~viola.notes.waits = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0];
	~viola.notes.durations = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0];
	~viola.notes.probs = [1];
	~viola2.notes.freqs = [70,68,63,65,68,67,65,68,61,63,67,60];
	~viola2.notes.waits = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0];
	~viola2.notes.durations = [6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0,4.0,2.0,2.0];
	~viola2.notes.probs = [1];
};

//Part 3
~violaVerse2 = {
	~viola.notes.waits = [6.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0];
	~viola.notes.freqs = [62,63,65,68,67,62,60,56,58,62,58];
	~viola.notes.durations = [6.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0];

	~viola2.notes.waits = [6.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0];
	~viola2.notes.freqs = [62,63,65,68,67,62,60,56,58,62,58];
	~viola2.notes.durations = [6.0,2.0,6.0,1.0,1.0,6.0,1.0,1.0,6.0,1.0,1.0];
};


//Part4
~violaVerse3 = {
	~viola.notes.waits = [4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,8.0];
	~viola.notes.freqs = [60,56,55,58,53,58,56,58,60,53];
	~viola.notes.durations = [4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,8.0];

	~viola2.notes.waits = [4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,8.0];
	~viola2.notes.freqs = [60,56,55,58,53,58,56,58,60,53];
	~viola2.notes.durations = [4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,8.0];
};



//Part 5
~violaVerse4 = {
	~viola.notes.waits = [4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0];
	~viola.notes.freqs = [59,61,58,54,58,56,59,53,56];
	~viola.notes.durations = [4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0];

	~viola2.notes.waits = [4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0];
	~viola2.notes.freqs = [59,61,58,54,58,56,59,53,56];
	~viola2.notes.durations = [4.0,4.0,4.0,2.0,2.0,4.0,4.0,4.0,4.0];
};

//Part 6

~violaVerse5 = {
	~viola.notes.waits = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0];
	~viola.notes.freqs = [58,59,62,63,65,60,56,53,56];
	~viola.notes.durations = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0];

	~viola2.notes.waits = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0];
	~viola2.notes.freqs = [58,59,62,63,65,60,56,53,56];
	~viola2.notes.durations = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,6.0,2.0];
};


//Part 7

~violaVerse6 = {
	~viola.notes.waits = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];
	~viola.notes.freqs = [58,59,62,63,65,60,56,58,53,56];
	~viola.notes.durations = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];

	~viola2.notes.waits = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];
	~viola2.notes.freqs = [58,59,62,63,65,60,56,58,53,56];
	~viola2.notes.durations = [6.0,2.0,6.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];
};


//part 8

~violaVerse7 = {
	~viola.notes.waits = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];
	~viola.notes.freqs = [60,56,53,56,58,53,58,56,58,60,53,53,60];
	~viola.notes.durations = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];

	~viola2.notes.waits = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];
	~viola2.notes.freqs = [60,56,53,56,58,53,58,56,58,60,53,53,60];
	~viola2.notes.durations = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];
};


//part 9
~violaVerse8 = {
	~viola.notes.waits = [6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
	~viola.notes.freqs = [62,63,65,68,70,72,68,65,68,70,71];
	~viola.notes.durations = [6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];

	~viola2.notes.waits = [6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
	~viola2.notes.freqs = [62,63,65,68,70,72,68,65,68,70,71];
	~viola2.notes.durations = [6.0,2.0,6.0,1.0,1.0,2.0,2.0,2.0,2.0,6.0,2.0];
};


//part 10
~violaVerse9 = {
	~viola.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
	~viola.notes.freqs = [70,65,70,71,70,65,70,71,70,65,70,68,70];
	~viola.notes.durations = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];

	~viola2.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
	~viola2.notes.freqs = [70,65,70,71,70,65,70,71,70,65,70,68,70];
	~viola2.notes.durations = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
};
