Help.gui
Quarks.gui

s.boot;
s.plotTree;
s.meter;
s.quit;

FreqScope.new(400, 200, 0, server: s);
Server.default.makeGui


(
o = Server.local.options;
o.numOutputBusChannels = 24; // The next time it boots, this will take effect
o.memSize = 2097152;
)

"/home/dbalchen/Music/setup.sc".load;

(
~startup = {

	(
		// Put stuff here...........
        ~scale = Scale.majorPentatonic.degrees.collect({ arg item, i; item; item}) + 72;
		~clock = MyTrack.new(~synth1,0);

	    ~clock.notes.probs = [1,1,0,1,1,0,1,0];
		~clock.notes.probs = [1.00,0.50,0.58,0.50,0.92,0.33,0.67,0.33] * 1.0;
		~clock.notes.waits = [ 1, 1, 1, 1, 1, 1, 1, 1 ] * 1;
		~clock.notes.freqs = [64, 60, 67, 64, 67, 64, 60, 62] + 12;
		~clock.notes.freqs = [69,65,0,69,62,0,60,0] + 12;
		~clock.notes.freqs = [57,61,62,57,64,69,66,62] + 12;
		//	~clock.notes.freqs =~clock.notes.probs.collect({ arg item, i; item; ~scale.choose});

		~clock.notes.durations = [1];

		
		~clock2 = MyTrack.new(~synth1,9);
		~clock2.notes.freqs = [35,38,35,38,35,38,35,38];
	    ~clock2.notes.probs = [1,0,1,0,1,0,0,0];
		~clock2.notes.probs =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];
	
		~clock3 = MyTrack.new(~synth1,1);
		~clock3.notes.waits = [ 1, 1, 1, 1, 1, 1, 1, 1 ];
		~clock3.notes.probs = [1,0,1,0,1,0,0,0];
		~clock3.notes.probs =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];

		~clock3.notes.freqs = [45,41,40,45,38,33,36,40];
			/*
		~clock4 = MyTrack.new(~synth1,1);
		~clock4.notes.probs =  [ 1, 0, 1, 1, 0, 1, 1, 0 ].reverse;
		~clock4.notes.freqs = [ 48, 0, 57, 52, 0, 57, 50, 0 ].reverse + 12;
		~clock4.notes.freqs = ~clock4.notes.probs.collect({ arg item, i; item; item*~scale.choose});
		
		~clock4.notes.probs = Bjorklund(15, 32);
		~clock4.notes.freqs =[ 67, 0, 0, 69, 0, 64, 0, 69, 0, 62, 0, 64, 0, 60, 0, 64, 0, 0, 67, 0, 67, 0, 62, 0, 67, 0, 67, 0, 62, 0, 69, 0 ];
		~clock4.notes.freqs = ~clock4.notes.probs.collect({ arg item, i; item; item*~scale.choose});
		*/

	)

};
)



~startup.value;
~startTimer.value(120);

~clock4.notes.freqs =([ 10, -60, 8, 3, -60, 8, 0, -60].reverse) + 60;

~p0 = [3,0,10,8];
~p4 = [7,4,2,0];
~p9 = [0,9,7,5];
~p2 = [5,2,0,10];


~clock4.notes.freqs =([ 3, -60, 0, 7, -60, 0, 1, -60 ].reverse) + 60;
~clock4.notes.freqs =([ 0, -60, 9, 4, -60, 9, 2, -60 ].reverse) + 60;
~clock4.notes.freqs =([ -2, -60, 7, 2, -60, 7, 0, -60 ].reverse) + 60;
~clock4.notes.freqs =([ 8, -60, 5, 0, -60, 5, 10, -60 ].reverse) + 60;
~clock4.notes.freqs = ([ ~p0.choose, -60, ~p9.choose, ~p4.choose, -60, ~p9.choose, ~p2.choose, -60 ].reverse) + 60;;

~rp = {~clock.transport.play;~clock2.transport.play;~clock3.transport.play};

~rp = {~clock3.transport.play;};

~clock4.transport.stop;


~rp = {}; // Example

(
~start = {

	var num = 120,timeNow;
	t = TempoClock.default.tempo = num / 60;

	Routine.run({
		s.sync;
		timeNow = TempoClock.default.beats;

		t.schedAbs(timeNow + 8,{ // 00 = Time in beats
			(
			~clock.transport.play;~clock2.transport.play;~clock3.transport.play;~clock4.transport.play;
				// If yes put stuff Here
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement

		); // End of t.schedAbs


		//Add more

	}); // End of Routine

}; //End of Start

)


~rp = {~start.value;};
