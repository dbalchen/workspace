//"/home/dbalchen/Music/JamOn6/include/Synths/envelopes.sc".load;


SynthDef(\Pulse, {arg out = 0, freq = 110, width = 0.5, lagLev = 0.0, bamp = 998;
	var sig,amp;

	freq = Lag.kr(freq, lagLev);
	sig = LFPulse.ar(freq, 0, width, 1, -0.5);
	Out.ar(out, sig);

}).add;


SynthDef(\pulseSound, {arg out = 0, amp = 1, aoc = 1, oscIn = 0, aocIn = 0, spread = 0, center = 0,// VCA Controls
	clip = 1, overd = 1, cutoff = 5000, gain = 0, mgain = 0, mul = 1, maoc = 1, dist = 0;
	// Clip and Low Pass Filter

	var sig;

	sig = In.ar(oscIn,1);
	gain = In.ar(gain) + mgain;
	cutoff = In.ar(cutoff);
	mul = maoc*(In.ar(mul) - 1) + 1;

	sig = RLPFD.ar(sig,ffreq:cutoff,res: gain, dist:dist,mul:mul);

	aoc = aoc*(In.ar(aocIn) - 1) + 1;
	sig = sig * aoc;

	sig = sig*overd;
	sig = sig.clip2(clip);
	sig = Splay.ar(sig,spread,center:center);

	OffsetOut.ar(out, sig*amp);
}).add;


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
~myadsr2.sustain = 0.5;
~myadsr2.release = 0.0;

~mixer3 = Synth("two2one",addAction: \addToTail);
~mixer3.set(\in0,~env2out1);
~mixer3.set(\in1,~asrOut);
~mixer3.set(\out,~mix3out);
~mixer3.set(\bal,0.70);

~pulse1 =  Synth("Pulse",target: ~oGroup,addAction: \addToTail);
~pulse1.set(\out,~pulse1Out);
~pulse1.set(\bamp,~circleExt4Out);
~pulse1.set(\amp,1.0);
~pulse1.set(\width,0.65);


~pulse =  Synth("pulseSound",target: ~oGroup,addAction: \addToTail);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mul, ~env2out);
~pulse.set(\oscIn, ~pulse1Out);
~pulse.set(\aocIn, ~adsr2Out);
~pulse1.set(\lagLev,0.0250);
~pulse.set(\clip,1);
~pulse.set(\aoc,0.90);
~pulse.set(\cutoff,~mix3out);
~pulse.set(\mgain,0.7);
~pulse.set(\maoc,0.98);
~pulse.set(\dist,0);
~pulse.set(\amp,2.0);

~mixergui3 = SimpleMix.new;
~mixergui3.mixer = ~mixer3;

~pulseSweep = {arg start = 0.9, end = -1, time = ((32*4)/2), time2 = ((8*4)/2), mult = 0.5;

	~circleExtOut = Bus.control(s,1);
	~circleExt = ~modCircle.value(~circleExtOut,start,end,time,time2,mult);
	~mixer3.set(\bmod,~circleExtOut);
	~mixer3.set(\bal,0);
	~circleExt.set(\gate,1); };

~pulseSweepOff = {arg fb = 0.7;

	~circleExt.set(\gate,0);
	~circleExt = nil;
	~mixer3.set(\bmod,998);
	~mixer3.set(\bal,fb);
};

/*

~mixergui3.gui;

*/