"/home/dbalchen/Music/JamOn6/include/Synths/envelopes.sc".load;

SynthDef(\Noise, {arg out = 0, freq = 550, rq = 0.5, lagLev = 0.0, amp = 2;
	var sig;
	sig = WhiteNoise.ar(1);
	freq = Lag.kr(freq, lagLev);
	sig = BPF.ar(sig,freq,rq,mul:1/rq);
	Out.ar(out, sig*amp);
}).add;

SynthDef(\windspeed, {arg out = 0,out2 = 0, out3 = 0;
	Out.ar(out,
		((LFDNoise3.ar(LFNoise1.ar(1, 0.5, 0.5), 0.5, 0.5))*500) + 350;
	);

	Out.ar(out2,
		((LFDNoise3.ar(LFNoise1.ar(1, 0.5, 0.5), 0.5, 0.5))*0.3) + 0.05;
	);

	Out.ar(out3,
		LFNoise1.ar(1, 0.3, 0.5);
	);

}).add;


SynthDef(\noiseSound, {arg out = 0, amp = 1, aoc = 1, oscIn = 0, aocIn = 0, spread = 0, center = 0,// VCA Controls
	clip = 1, overd = 1, cutoff = 5000, gain = 1, mgain = 0, mul = 1, maoc = 1; // Clip and Low Pass Filter

	var sig;

	sig = In.ar(oscIn,1);
	gain = In.ar(gain) + mgain;
	cutoff = In.ar(cutoff);

	mul = maoc*(In.ar(mul) - 1) + 1;

	sig = MoogFF.ar(sig, freq:cutoff, gain: gain,mul:mul);

	aoc = aoc*(In.ar(aocIn) - 1) + 1;
	sig = sig * aoc;

	sig = sig*overd;
	sig = sig.clip2(clip);
	sig = Splay.ar(sig,spread,center:center);

	OffsetOut.ar(out, sig*amp);
}).add;

~envout = Bus.audio(s,1);
~envout1 = Bus.audio(s,1);
~wcut = Bus.audio(s,1);
~wmul = Bus.audio(s,1);
~wgain = Bus.audio(s,1);
~mix1out = Bus.audio(s,1);
~mix2out = Bus.audio(s,1);
~noise1Out = Bus.audio(s,1);

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
~noise1.set(\freq, 65.midicps);
~noise1.set(\out,~noise1Out);

~noise =  Synth("noiseSound",target: ~nGroup,addAction: \addToTail);
~noise.set(\cutoff,~mix1out);
~noise.set(\gain,~wgain);
~noise.set(\mul, ~mix2out);
~noise.set(\oscIn, ~noise1Out);
~noise.set(\aocIn, ~circleOut);
~noise.set(\spread,1);

~noise1.set(\rq,0.06);
~noise1.set(\lagLev,4.00);

~noise.set(\aoc,0.9);
~noise.set(\spread,1);
~noise.set(\amp,3.0);
~noise.set(\maoc,1);

~noiseSweep = {arg start = 1, end = -0.35, time = ((24*4)/2), time2 = ((8*4)/2), mult = 0.25;

	~circleExt2Out = Bus.control(s,1);
	~circleExt2 = ~modCircle.value(~circleExt2Out,start,end,time,time2,mult);
	~mixer2.set(\bmod,~circleExt2Out);
	~mixer2.set(\bal,0);
	~circleExt2.set(\gate,1); };

~noiseSweepOff = {

	~circleExt2.set(\gate,0);
	~circleExt2 = nil;	~circleExt2.set(\gate,0);
	~circleExt2 = nil;
	~mixer2.set(\bmod,999);
	~mixer2.set(\bal,0.80);
};

~noiseSweep2 = {arg start = 1, end = 0.0, time = ((24*4)/2), time2 = ((8*4)/2), mult = 0.05;

	~circleExt3Out = Bus.control(s,1);
	~circleExt3 = ~modCircle.value(~circleExt3Out,start,end,time,time2,mult);
	~mixer1.set(\bmod,~circleExt3Out);
	~mixer1.set(\bal,0);
	~circleExt3.set(\gate,1); };

~noiseSweep2Off = {

	~circleExt3.set(\gate,0);
	~circleExt3 = nil;
	~mixer1.set(\bmod,999);
	~mixer1.set(\bal,0.80);
};

~mixergui1 = SimpleMix.new;
~mixergui1.mixer = ~mixer1;

~mixergui2 = SimpleMix.new;
~mixergui2.mixer = ~mixer2;

~mixer1.set(\bal,1);
~mixer2.set(\bal,1);

/*

~mixergui1.gui;
~mixergui2.gui;


*/