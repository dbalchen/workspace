~snare = MyEvents.new;
~snare.amp = 1.0;
~snare.probs = [0,0,0,1,0,0,0,0,0,0,0,1,0,0,0];
~snare.freqs = [0.00,0.00,0.00,38.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,38.00,0.00,0.00,0.00];
~snare.waits = [1.00,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50];
~snare.durations = [1.00,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50] * 2;
~snare.init;

~bassd =  MyEvents.new;
~bassd.amp = 1.0;
~bassd.probs = [1,0,0.25,0,0,1,0,0.75,0,0,0,0.5,0,0,0];
~bassd.freqs = [36.00,0.00,36.00,0.00,0.00,36.00,0.00,36.00,0.00,0.00,0.00,36.00,0.00,0.00,0.00];
~bassd.waits = [1.00,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50];
~bassd.durations = [1.00,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50] * 2;
~bassd.init;

~tom1 = MyEvents.new;
~tom1.amp = 1.0;
~tom1.probs = [0,0.8,0,1,0.4,0,0.6,0,1,0.6,1,0,0.8,0.8,0.4];
~tom1.freqs = [0.00,41.00,0.00,47.00,43.00,0.00,41.00,0.00,47.00,43.00,41.00,0.00,47.00,43.00,47.00];
~tom1.waits = [1.00,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50];
~tom1.durations = [1.00,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50] * 2;
~tom1.init;

~tom2 = MyEvents.new;
~tom2.amp = 1.0;
~tom2.init;

~tom3 = MyEvents.new;
~tom3.amp = 1.0;
~tom3.init;

~ride = MyEvents.new;
~ride.amp = 1.0;
~ride.probs = [1,0.5,0.5,0,0,1,0,1,0,1,0,0,0,0,0];
~ride.freqs = [59.00,59.00,59.00,0.00,0.00,59.00,0.00,59.00,0.00,59.00,0.00,0.00,0.00,0.00,0.00];
~ride.waits = [1.00,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50];
~ride.durations = [1.00,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50,0.50] * 2;
~ride.init;

~midiBassDrum = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~bassd.freq.next}- 60),
		\amp, ~bassd.amp,
		\chan, 9,
		\sustain, Pfunc.new({~bassd.duration.next}),
		\dur, Pfunc.new({~bassd.wait.next})
		).play};

~midiSnare = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~snare.freq.next}- 60),
		\amp, ~snare.amp,
		\chan, 9,
		\sustain, Pfunc.new({~snare.duration.next}),
		\dur, Pfunc.new({~snare.wait.next})
		).play};

~midiToms = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~tom1.freq.next}- 60),
		\amp, ~tom1.amp,
		\chan, 9,
		\sustain, Pfunc.new({~tom1.duration.next}),
		\dur, Pfunc.new({~tom1.wait.next})
		).play};

~midiCyms = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~ride.freq.next}- 60),
		\amp, ~ride.amp,
		\chan, 9,
		\sustain, Pfunc.new({~ride.duration.next}),
		\dur, Pfunc.new({~ride.wait.next})
		).play};

 ~channel9 = {arg num, vel = 1;
   var ret, amp = 2, drum;

   
   if((num == 36),{drum = ~bassd;});
   if((num == 38),{drum = ~snare;});
   if((num == 41),{drum = ~tom1;});
   if((num == 43),{drum = ~tom2;});
   if((num == 47),{drum = ~tom3;});
   if((num == 59),{drum = ~ride;});

   ~drum.amp = amp * vel;
   ret = ~midiDrum.value(~drum,~drumSound,num);
   ret;
 };
