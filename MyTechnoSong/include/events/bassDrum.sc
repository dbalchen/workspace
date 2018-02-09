~bassDrum = MyTrack.new(~synth1,9);
~bassDrum.notes.freqs = [36];

~bassDrumNotes = MyTrack.new(~synth1,10);

~bassDrumNotes.notes.freqs = [41,42,41,39,41,42,41,39] - 4;
~bassDrumNotes.notes.waits = [6.0,2.0,6.0,2.0,6.0,2.0,6.0,2.0];
~bassDrumNotes.notes.durations = [1.40];
