
s.boot;
s.plotTree;
s.meter;
s.quit;

"/home/dbalchen/Music/setup.sc".load;

~startTimer.value(100);


(

~null4 = Bjorklund(0, 4);
~null5 = Bjorklund(0, 5);
~null7 = Bjorklund(0, 7);

~track0 = MyTrack.new(~synth1,9);
//~track0.notes.probs = Bjorklund(3, 5);
//~track0.notes.probs =[ 1, 0, 0, 0, 1 ];
~track0.notes.probs =[ 1, 0, 0, 0, 0];
~track0.notes.waits = ~track0.notes.waits*0.25;

~track1 = MyTrack.new(~synth1,9);
//~track1.notes.probs = Bjorklund(5, 7);
//~track1.notes.probs = [ 1, 0, 0, 1, 0, 1, 0 ];
//~track1.notes.probs = [ 1, 0, 0, 0, 0, 1, 0 ];
~track1.notes.probs = [ 0, 0, 0, 0, 0, 1, 0 ] *0;
~track1.notes.waits = ~track1.notes.waits*0.25;
~track1.notes.freqs = ~track1.notes.probs*61;

~track2 = MyTrack.new(~synth1,9);
~track2.notes.probs = Bjorklund(4, 4);
~track2.notes.freqs = ~track2.notes.probs*36;

~track3 = MyTrack.new(~synth1,0);
~track3.notes.probs =[ 0, 0, 1, 0, 0];
~track3.notes.waits = ~track3.notes.waits * 2;
~track3.notes.durations =[16];
~track3.notes.freqs = [ 0, 0, [64,69,75], 0, 0];

~track4 = MyTrack.new(~synth1,1);
~track4.notes.probs = [ 0, 0, 1, 0, 0, 0, 0 ];
~track4.notes.waits = ~track4.notes.waits * 0.25;
~track4.notes.durations =[0.5];
~track4.notes.freqs = [42];

~track5 = MyTrack.new(~synth1,1);
~track5.notes.probs = [ 1, 0, 0, 0];
~track5.notes.waits = ~track5.notes.waits * 1;
~track5.notes.durations =[1];
~track5.notes.freqs = [42];

~track6 = MyTrack.new(~synth1,1);
~track6.notes.probs =[ 0, 0, 1, 0, 0];
~track6.notes.waits = ~track6.notes.waits;
~track6.notes.durations =[0.5];
~track6.notes.freqs = [42];

~track7 = MyTrack.new(~synth1,9);
~track7.notes.probs = [ 0, 0, 1, 0, 1]++[ 0, 0, 1, 0, 1]++[ 0, 0, 1, 0, 1];
~track7.notes.waits = ~track7.notes.waits * 0.25;
~track7.notes.durations =[1];
~track7.notes.freqs = [ 0, 0, 38, 0, 42]++[ 0, 0, 42, 0, 38]++[ 0, 0, 38, 0, 42];

~track8 = MyTrack.new(~synth1,9);
~track8.notes.probs = [ 1, 0, 1, 0, 0, 0, 1] ++ [ 1, 0, 1, 0, 0, 0, 1 ] ++ [ 1, 0, 1, 0, 0, 0, 1 ];
~track8.notes.waits = ~track8.notes.waits * 0.5;
~track8.notes.durations =[1];
~track8.notes.freqs = [ 42, 0, 42, 0, 0, 0, 42] ++ [ 42, 0, 42, 0, 0, 0, 38] ++ [ 42, 0, 42, 0, 0, 0, 42];

~track9 = MyTrack.new(~synth1,1);
~track9.notes.probs = [ 0, 0, 0, 1, 0, 0, 0 ];
~track9.notes.waits = ~track9.notes.waits*0.25;
~track9.notes.freqs = ~track9.notes.probs*42;

)

~startTimer.value(100);

~rp = {~track0.transport.play;
	~track1.transport.play;
	~track2.transport.play;
	~track3.transport.play;
	~track4.transport.play;
	~track5.transport.play;
	~track6.transport.play;
	~track7.transport.play;
	~track8.transport.play;
	~track9.transport.play;
}




~track0.transport.pause;
~track1.transport.pause;
~track2.transport.pause;
~track3.transport.pause;
~track4.transport.pause;
~track5.transport.pause;
~track6.transport.pause;
~track7.transport.pause;
~track8.transport.pause;
~track9.transport.pause;
~track10.transport.pause;



~track4.notes.probs