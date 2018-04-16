~lowStrings = MyTrack.new(~synth1,0);
~lowStrings.amp = 0.15;

~lowStringsInit = {
	~lowStrings.notes.freqs = [41,42,41,39,41,42,41,39] + 5;
	~lowStrings.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0];
	~lowStrings.notes.durations = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0];
	~lowStrings.notes.probs = [1];
	~lowStrings.notes.lag = 0.9;

};

~lowStringsInit.value();
~lowStrings.notes.init;


~lowStringsInit4 = {
	~lowStrings.notes.freqs = [41,42,41,39,41,42,41] + 5;
	~lowStrings.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,12.0];
	~lowStrings.notes.durations = [6.0,2.0,6.0,2.0,6.0,2.0,12.0];
	~lowStrings.notes.lag = 0.9;

};

~lowStringsInitStop = {
	~lowStrings.notes.waits = [2.0,1.0,1.0];
	~lowStrings.notes.freqs = [36,36,36];
	~lowStrings.notes.probs = [0,0,0];
	~lowStrings.notes.durations = [2.0,1.0,1.0];
};

~lowStringsVerse1 = {
	~lowStrings.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,8.0];
	~lowStrings.notes.freqs = [58,59,58,53,58,56,58] -12;
	~lowStrings.notes.durations = [6.0,2.0,6.0,2.0,6.0,2.0,8.0];
	~lowStrings.notes.probs = [1];
};

~lowStringsVerse2 = {
	~lowStrings.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,8.0];
	~lowStrings.notes.freqs = [48,43,46,41,44,46,41];
	~lowStrings.notes.durations = [6.0,2.0,6.0,2.0,6.0,2.0,8.0];
};


~lowStringsVerse3 = {
	~lowStrings.notes.waits = [4.0,4.0,6.0,2.0,4.0,4.0,4.0,4.0];
	~lowStrings.notes.freqs = [47,49,46,39,44,47,41,44];
	~lowStrings.notes.durations = [4.0,4.0,6.0,2.0,4.0,4.0,4.0,4.0];
};


~lowStringsVerse4 = {
	~lowStrings.notes.waits = [6.0,2.0,6.0,2.0,4.0,4.0,6.0,2.0];
	~lowStrings.notes.freqs = [46,47,46,41,46,44,41,44];
	~lowStrings.notes.durations= [6.0,2.0,6.0,2.0,4.0,4.0,6.0,2.0];
	~lowStrings.notes.lag = 0.05;
};

~lowStringsVerse5 = {
	~lowStrings.notes.waits = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
	~lowStrings.notes.freqs = [46,47,46,41,46,48,41,46,41,44];
	~lowStrings.notes.durations = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,4.0,2.0,2.0];
	~lowStrings.notes.lag = 0.05;
};

~lowStringsVerse6 = {
	~lowStrings.notes.waits = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];
	~lowStrings.notes.freqs = [48,44,41,44,46,41,46,44,41,39,41,41,44];
	~lowStrings.notes.durations = [2.0,2.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0,4.0,2.0,2.0];
};

~lowStringsVerse7 = {
	~lowStrings.notes.waits = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,6.0,2.0];
	~lowStrings.notes.freqs = [46,47,46,41,46,48,41,46,47];
	~lowStrings.notes.durations = [6.0,2.0,4.0,2.0,2.0,4.0,4.0,6.0,2.0];
};

~lowStringsVerse8 = {
	~lowStrings.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
	~lowStrings.notes.freqs = [46,41,46,47,46,41,46,47,46,41,46,44,46];
	~lowStrings.notes.durations = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0,4.0,4.0,12.0];
};