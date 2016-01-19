
 "/home/dbalchen/workspace/SuperCollider/FMpad.sc".loadPath;

~dark_pad = MyEvents.new;
~dark_pad.amp = 0.40;
~dark_pad.waits = [8.0,8.0,8.0,8.0,8.0,8.0,8.0,200.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,48.0]; 
~dark_pad.freqs = [65,63,60,58,65,63,60,58,65,63,60,58,65,63,60,58,65];
~dark_pad.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~dark_pad.durations = [8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,16.0];
~dark_pad.init;

~mididark_pad = {Pbind(\type, \midi,
		      \midiout, ~synth1,
		      \midicmd, \noteOn,
		      \note,  Pfunc.new({~dark_pad.freq.next}- 60),
		      \chan, 1,
		      \sustain, Pfunc.new({~dark_pad.duration.next}),
		      \dur, Pfunc.new({~dark_pad.wait.next})
		      ).play};

 ~channel1 = {arg num, vel =1;
   var ret;
   ret = ~midiFMdarkpad1.value(~dark_pad,num);
   ret;
 };



~chord = MyEvents.new;
~chord.amp = 0.20;
~chord.waits = [256.0,480.0]; 
~chord.freqs = [[77,70,63,60],[77,70,63,60]];
~chord.probs = [1,1];
~chord.durations = [68.0,79.5];
~chord.init;

~midichord = {Pbind(\type, \midi,
		      \midiout, ~synth1,
		      \midicmd, \noteOn,
		      \note,  Pfunc.new({~chord.freq.next}- 60),
		      \chan, 11,
		      \sustain, Pfunc.new({~chord.duration.next}),
		      \dur, Pfunc.new({~chord.wait.next})
		      ).play};

 ~channel11 = {arg num, vel = 1;
   var ret;
   ret = ~midiFMdarkpad1.value(~chord,num);
   ret;
 };