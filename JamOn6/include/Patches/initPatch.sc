~nGroup = Group.new;

~envout = Bus.audio(s,1);
~envout1 = Bus.audio(s,1);
~asrOut = Bus.audio(s,1);
~adsrOut = Bus.audio(s,1);

~wcut = Bus.audio(s,1);
~wmul = Bus.audio(s,1);
~wgain = Bus.audio(s,1);

~mix1out = Bus.audio(s,1);
~mix2out = Bus.audio(s,1);
~mix3out = Bus.audio(s,1);
~mix4out = Bus.audio(s,1);
~circleOut = Bus.audio(s,1);

~pulse1Out = Bus.audio(s,1);
~noise1Out = Bus.audio(s,1);
~sine1Out = Bus.audio(s,1);
~bellOut = Bus.audio(s,1);

~vcaOut = Bus.audio(s,1);
~vca2Out = Bus.audio(s,1);

~stringsOut  = Bus.audio(s,1);

~myadsr = MyADSR.new;
~myadsr.init;
~myadsr.attack = 0.2;
~myadsr.decay = 2.5;
~myadsr.sustain = 0.0;
~myadsr.release = 0.0;


~wind = Synth("windspeed",target: ~nGroup,addAction: \addToHead);
~wind.set(\out,~wcut);
~wind.set(\out2,~wmul);
~wind.set(\out3,~wgain);

~circle = Synth("myCircle",target: ~nGroup,addAction: \addToHead);
~circle.set(\out,~circleOut);


~mixer1 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
~mixer1.set(\in0,~wcut);
~mixer1.set(\in1,~envout1);
~mixer1.set(\out,~mix1out);

~mixer2 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
~mixer2.set(\in0,~wmul);
~mixer2.set(\in1,~envout);
~mixer2.set(\out,~mix2out);

~mixer3 = Synth("two2one",target: ~nGroup,addAction: \addToTail);
~mixer3.set(\in0,~envout1);
~mixer3.set(\in1,~asrOut);
~mixer3.set(\out,~mix3out);

~mixer4 = Synth("two2one",addAction: \addToTail);
~mixer4.set(\in0,~bellOut);
~mixer4.set(\in1,~sine1Out);
~mixer4.set(\out,~vcaOut);

~vca1 =  Synth("vca",addAction: \addToTail);
~vca1.set(\in,~vcaOut);

~pulse1 =  Synth("Pulse",target: ~nGroup,addAction: \addToTail);
~pulse1.set(\out,~pulse1Out);

~pulse =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mul, ~envout);
~pulse.set(\oscIn, ~pulse1Out);
~pulse.set(\aocIn, ~adsrOut);

~noise1 =  Synth("Noise",target: ~nGroup,addAction: \addToTail);
~noise1.set(\freq, 77.midicps);
~noise1.set(\out,~noise1Out);

~noise =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
~noise.set(\cutoff,~mix1out);
~noise.set(\gain,~wgain);
~noise.set(\mul, ~mix2out);
~noise.set(\oscIn, ~noise1Out);
~noise.set(\aocIn, ~circleOut);

~dcs = 4.0;
~fscale = 1;
~release = 1.0;
~attack = 0.0;
~amp = 0.400;
~pitch = 87.3070578583;
~mixer4.set(\bal,-0.75);
~vca1.set(\amp,0.4);

~noise1.set(\rq,0.15);
~noise1.set(\lagLev,4.00);
~noise.set(\aoc,0.75);
~noise.set(\spread,1);
~noise.set(\amp,3.25);
~mixer1.set(\bal,-0.35);
~mixer2.set(\bal,-1.0);

~pulse1.set(\lagLev,0.0250);
~pulse.set(\clip,1);
~pulse.set(\aoc,1.0);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mgain,1.45);
~pulse.set(\maoc,0.9);
~pulse.set(\amp,0.80);
~mixer3.set(\bal,0.0);