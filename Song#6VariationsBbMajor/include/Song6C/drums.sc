
~drum = MyEvents.new;
~snare = MyEvents.new;
~bass =  MyEvents.new;

~tom1 = MyEvents.new;
~tom2 = MyEvents.new;
~tom3 = MyEvents.new;
~tom4 = MyEvents.new;

~ride = MyEvents.new;
 
~midiDrum = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~drum.freq.next}- 60),
		\amp, ~drum.amp,
		\chan, 0,
		\sustain, Pfunc.new({~drum.duration.next}),
		\dur, Pfunc.new({~drum.wait.next})
		).play};

~midiToms = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~tom1.freq.next}- 60),
		\amp, ~tom1.amp,
		\chan, 0,
		\sustain, Pfunc.new({~tom1.duration.next}),
		\dur, Pfunc.new({~tom1.wait.next})
		).play};

~midiCyms = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~ride.freq.next}- 60),
		\amp, ~ride.amp,
		\chan, 0,
		\sustain, Pfunc.new({~ride.duration.next}),
		\dur, Pfunc.new({~ride.wait.next})
		).play};


 ~channel9 = {arg num, vel = 1;
   var ret, amp = 2;
	
   ~drum.amp = amp * vel;
   ret = ~midiDrum.value(~drum,~drumSound,num);
   ret;
 };
