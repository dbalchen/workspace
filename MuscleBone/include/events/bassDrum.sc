~bassDrum = MyTrack.new(~synth1,9);
~bassDrumNotes = MyTrack.new(~synth1,10);

~initialBassDrum = {


	~bassDrum.notes.waits = [1.0,1.0,1.0,1.0,1,1,1,1];
	~bassDrum.notes.freqs = [36,36,36,36,36,36,36,36];
	~bassDrum.notes.probs = [1,1,1,1,1,1,1,1];
	~bassDrum.notes.durations = [1.0,1.0,1.0,1.0,1,1,1,1];

	~bassDrumNotes.notes.freqs = ([41,42,41,39,41,42,41,39] - 7);
	~bassDrumNotes.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0];
	~bassDrumNotes.notes.probs = [1,1,1,1,1,1,1,1];
	~bassDrumNotes.notes.durations = [1.40];


};

~initialBassDrum.value;
~bassDrum.notes.init;
~bassDrumNotes.notes.init;

~bassDrumOnFour = {
	~bassDrum.notes.probs = [1,1,1,1]++[1,0,0,0];
	~bassDrumNotes.notes.waits = [1,1,1,1] ++ [1,1,1,1];
	~bassDrumNotes.notes.freqs = [36,36,36,36];
	~bassDrumNotes.notes.probs = [1,1,1,1]++[1,0,0,0];
	~bassDrumNotes.notes.durations = [0.5];

};

// ~bassDrumOnFour.value();

~bassDrum2ndVerse = {
	~bassDrum.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.freqs = [58,59,58,53,58,56,58] - 24;
	~bassDrumNotes.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,8.0];
	~bassDrumNotes.notes.durations = [1.40];
};

// ~bassDrum2ndVerse.value();

~bassDrum1st8 = {
	~bassDrum.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,8.0];
	~bassDrumNotes.notes.freqs = [48,43,46,41,44,46,41] - 12;
	~bassDrumNotes.notes.durations = [1.40];
};
// ~bassDrum1st8.value;

~bassDrum2nd8 = {
	~bassDrum.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.probs = [1,1,1,1];

	~bassDrumNotes.notes.waits = [4.0,4.0,6.0,2.0,4.0,4.0,4.0,4.0];
	~bassDrumNotes.notes.freqs = [47,49,46,39,44,47,41,44] -12;
	~bassDrumNotes.notes.durations = [1.40];
};

// ~bassDrum2nd8.value;

~bassDrumBig1 = {
	~bassDrum.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.probs = [1,1,1,1];

	~bassDrumNotes.notes.waits = [6.0,2.0,6.0,2.0,4.0,4.0,6.0,2.0];
	~bassDrumNotes.notes.freqs = [46,47,46,41,46,44,41,44] -12;
	~bassDrumNotes.notes.durations= [1.40];
};

// ~bassDrumBig1.value;


~bassDrumBig2 = {
	~bassDrum.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.waits = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
	~bassDrumNotes.notes.freqs = [46,47,46,41,46,48,41,46,41,44] -12;
	~bassDrumNotes.notes.durations= [1.40];

};

// ~bassDrumBig2.value;

~bassDrum3rd8 = {
	~bassDrum.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.waits = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];
	~bassDrumNotes.notes.freqs = [48,44,41,44,46,41,46,44,41,39,41,41,44] -12;
	~bassDrumNotes.notes.durations= [1.40];
};

// ~bassDrum3rd8.value;

~bassDrum3rdVerse = {
	~bassDrum.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.waits = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,6.0,2.0];
	~bassDrumNotes.notes.freqs = [46,47,46,41,46,48,41,46,47]-12;
	~bassDrumNotes.notes.durations= [1.40];
};

// ~bassDrum3rdVerse.value();

~bassDrumEnding = {
	~bassDrum.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.probs = [1,1,1,1];
	~bassDrumNotes.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
	~bassDrumNotes.notes.freqs = [46,41,46,47,46,41,46,47,46,41,46,44,46] - 12;
	~bassDrumNotes.notes.durations= [1.40];
};

// ~bassDrumEnding.value();

~bassDrumFinal = {
	~bassDrum.notes.waits = [1,1,1,1,36];
	~bassDrum.notes.freqs = [36];
	~bassDrum.notes.probs = [1,1,1,1]++[1,0,0,0];
	~bassDrumNotes.notes.waits = [1,1,1,1,36];
	~bassDrumNotes.notes.freqs = [34];
	~bassDrumNotes.notes.probs = [1];
	~bassDrumNotes.notes.durations = [0.5];

};

// ~bassDrumFinal.value();