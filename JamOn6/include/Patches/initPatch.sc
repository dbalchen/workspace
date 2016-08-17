~nGroup = Group.new;
~oGroup = Group.new;





// ~adsrOut = Bus.audio(s,1);
// ~myadsr = MyADSR.new;
// ~myadsr.init;
// ~myadsr.attack = 0.2;
// ~myadsr.decay = 2.5;
// ~myadsr.sustain = 0.0;
// ~myadsr.release = 0.0;



~circle = Synth("myCircle",addAction: \addToHead);
~circle.set(\out,~circleOut);


//
// ~circleExtOut2 = Bus.control(s,1);
// ~circleExt2 = Synth("myExtCircle",addAction: \addToHead);
// ~circleExt2.set(\phase,3);
// ~circleExt2.set(\out,~circleExtOut2);
// ~circleExt2.set(\mull,0.25);
// ~circleExt.set(\ratio,0.65);
// ~circleExt.set(\add, 0.3);
// ~mixer1.set(\bmod,~circleExtOut2);
//
// ~circleExtOut3 = Bus.control(s,1);
// ~circleExt3 = Synth("myExtCircle",addAction: \addToHead);
// ~circleExt3.set(\out,~circleExtOut3);
// ~circleExt3.set(\phase,3);
// ~circleExt3.set(\mull,0.15);
// ~mixer2.set(\bmod,~circleExtOut3);
//


~sine1Out = Bus.audio(s,1);
~vca1 =  Synth("vca",addAction: \addToTail);
~vca1.set(\in,~sine1Out);
~vca1.set(\amp,0.75);

~bellOut = Bus.audio(s,1);
~vca2 =  Synth("vca",addAction: \addToTail);
~vca2.set(\in,~bellOut);

~dcs = 3.5;
~fscale = 1.0;
~release = 0.5;
~attack = 0.0;
~amp = 0.035;
~pitch = 87.3070578583;

~env2out = Bus.audio(s,1);
~env2out1 = Bus.audio(s,1);
~adsr2Out = Bus.audio(s,1);
~asrOut = Bus.audio(s,1);
~mix3out = Bus.audio(s,1);
~pulse1Out = Bus.audio(s,1);

~myadsr2 = MyADSR.new;
~myadsr2.init;
~myadsr2.attack = 0.2;
~myadsr2.decay = 2.5;
~myadsr2.sustain = 0.0;
~myadsr2.release = 0.0;

~mixer3 = Synth("two2one",target: ~oGroup,addAction: \addToTail);
~mixer3.set(\in0,~env2out1);
~mixer3.set(\in1,~asrOut);
~mixer3.set(\out,~mix3out);
~mixer3.set(\bal,0.98);

~pulse1 =  Synth("Pulse",target: ~oGroup,addAction: \addToTail);
~pulse1.set(\out,~pulse1Out);

~pulse =  Synth("bdSound",target: ~oGroup,addAction: \addToTail);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mul, ~env2out);
~pulse.set(\oscIn, ~pulse1Out);
~pulse.set(\aocIn, ~adsr2Out);
~pulse1.set(\lagLev,0.0250);
~pulse.set(\clip,1);
~pulse.set(\aoc,1.0);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mgain,1.45);
~pulse.set(\maoc,0.98);
~pulse.set(\amp,0.5);

~envout = Bus.audio(s,1);
~envout1 = Bus.audio(s,1);
~wcut = Bus.audio(s,1);
~wmul = Bus.audio(s,1);
~wgain = Bus.audio(s,1);
~mix1out = Bus.audio(s,1);
~mix2out = Bus.audio(s,1);
~noise1Out = Bus.audio(s,1);
~circleOut = Bus.audio(s,1);

~wind = Synth("windspeed",target: ~oGroup,addAction: \addToHead);
~wind.set(\out,~wcut);
~wind.set(\out2,~wmul);
~wind.set(\out3,~wgain);

~mixer1 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
~mixer1.set(\in0,~wcut);
~mixer1.set(\in1,~envout1);
~mixer1.set(\out,~mix1out);

~mixer2 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
~mixer2.set(\in0,~wmul);
~mixer2.set(\in1,~envout);
~mixer2.set(\out,~mix2out);

~noise1 =  Synth("Noise",target: ~nGroup,addAction: \addToTail);
~noise1.set(\freq, 77.midicps);
~noise1.set(\out,~noise1Out);

~noise =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
~noise.set(\cutoff,~mix1out);
~noise.set(\gain,~wgain);
~noise.set(\mul, ~mix2out);
~noise.set(\oscIn, ~noise1Out);
~noise.set(\aocIn, ~circleOut);

~noise1.set(\rq,0.15);
~noise1.set(\lagLev,4.00);
~noise.set(\aoc,0.75);
~noise.set(\spread,1);
~noise.set(\amp,3.25);
~mixer1.set(\bal,-0.35);
~mixer2.set(\bal,-1.0);


~pad_firmus.amp = 0.04;
