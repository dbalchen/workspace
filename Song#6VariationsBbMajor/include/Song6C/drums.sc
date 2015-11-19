~snare = MyEvents.new;
~bassd =  MyEvents.new;

~tom1 = MyEvents.new;
~tom2 = MyEvents.new;
~tom3 = MyEvents.new;

~ride = MyEvents.new;
 
~midiBassDrum = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~bassd.freq.next}- 60),
		\amp, ~bassd.amp,
		\chan, 0,
		\sustain, Pfunc.new({~bassd.duration.next}),
		\dur, Pfunc.new({~bassd.wait.next})
		).play};

~midiSnare = {Pbind(\type, \midi,
		\midiout, ~synth1,
		\midicmd, \noteOn,
		\note,  Pfunc.new({~snare.freq.next}- 60),
		\amp, ~snare.amp,
		\chan, 0,
		\sustain, Pfunc.new({~snare.duration.next}),
		\dur, Pfunc.new({~snare.wait.next})
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
