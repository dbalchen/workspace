SynthDef(\Noise, {arg out = 0, freq = 550, rq = 0.5, lagLev = 0.0, amp = 2;
	var sig;
	sig = WhiteNoise.ar(1);
	freq = Lag.kr(freq, lagLev);
	sig = BPF.ar(sig,freq,rq,mul:1/rq);
	Out.ar(out, sig*amp);
}).add;


SynthDef(\env0, {arg out=0,r1 = 0.5,r2 = 1, r3 = 0.5, r4 = 0, r5 = 0,gate = 0;
	var sig;
	sig = EnvGen.ar(
		Env.new([r1, r2, r3, r4, r5], [0.005, 0.06, 0.26, 0.1], [-4, -2, -4, -1],4)
		,gate,doneAction:2);

	Out.ar(out, sig);}).add;


SynthDef(\env1, {arg out=0,gate = 0;
	var sig;
	sig = EnvGen.ar(
		Env.new([110, 59, 29], [0.005, 0.1], [-4, -5])
		,gate,doneAction:2);

	sig = sig.midicps;
	Out.ar(out,sig);}).add;


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

~noise =  Synth("bdSound",target: ~nGroup,addAction: \addToTail);
~noise.set(\cutoff,~mix1out);
~noise.set(\gain,~wgain);
~noise.set(\mul, ~mix2out);
~noise.set(\oscIn, ~noise1Out);
~noise.set(\aocIn, ~circleOut);
~noise.set(\spread,1);

~noise1.set(\rq,0.015);
~noise1.set(\lagLev,4.00);
~noise.set(\aoc,0.9);
~noise.set(\spread,1);
~noise.set(\amp,5.5);

~noise.set(\maoc,1);


~noiseSweep = {arg start = 1, end = -0.35, time = ((24*4)/2), time2 = ((8*4)/2), mult = 0.25;

	~circleExt2Out = Bus.control(s,1);
	~circleExt2 = ~modCircle.value(~circleExt2Out,start,end,time,time2,mult);
	~mixer2.set(\bmod,~circleExt2Out);
	~mixer2.set(\bal,0);
	~circleExt2.set(\gate,1); };

~noiseSweepOff = {

	~circleExt2.set(\gate,0);
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



~circleExt4.set(\gate,0);
~pulse1.set(\bamp,998);
~pulse1.set(\amp,0);
~circleExt5.set(\gate,0);
~vca1.set(\bamp,998);
~vca1.set(\amp,0);

~mixergui1.gui;
~mixergui2.gui;

~mixer1.set(\bal,1);
~mixer2.set(\bal,1);
~mixer3.set(\bal,0.85);



~noise.set(\aoc,0.3);

~noiseSweep.value(1,-0.25,((16*4)/2), ((4*4)/2), 0.25);
~noiseSweep2.value(1,-1,((16*4)/2),((8*4)/2), 0.75);

~noiseSweep.value(-0.25,1,((24*4)/2), ((4*4)/2), 1.0);
~noiseSweep2.value(-1,1,((24*4)/2),((8*4)/2), 0.55);



~pulseAmp.value(0,1,((24*4)/2),((4*4)/2),-0.85);
~pulse1.set(\bamp,~circleExt4Out);
~pulse1.set(\amp,1);

~sineAmp.value(0, 0.45,((24*4)/2), ((2*4)/2), 0.5);

~vca1.set(\bamp,~circleExt5Out);
~vca1.set(\amp,0.0);



~circleExt5.set(\gate,0);
~vca1.set(\bamp,998);
~vca1.set(\amp,0);
~sineAmp.value(0.45, 0.0,((4*4)/2), ((2*4)/2), 1.0);









~synth2 = ~synth2.latency_(Server.default.latency);


~dcs = 0.4;
~fscale = 16.0;
~release = 0.1;
~attack = 0.00;
~amp = 0.02;
//
~rp={
	s.sync;
	~midiClock.value;
	~midicf_clock.value;
	~midistring1_firmus.value;
};

~rp={
	s.sync;
	~midiBellDrum.value
};


~myadsr.gui;

~mixer1.set(\bal,-0.5);
~mixer2.set(\bal,-0.25);

~noiseSweepOff.value;
~noiseSweep2Off.value;
~mixer1.set(\bal,1);
~mixer2.set(\bal,1);

~mixer3.set(\bal,0.8);
~mixer4.set(\bal,1);

~mixergui1.gui;
~mixergui2.gui;
~mixergui3.gui;
~mixergui4.gui;

~string1_firmus.filter.gui;
~string1_firmus.envelope.gui;

~string1_firmus.amp = 9.00;
~string2_firmus.amp = 1.35;

~vca1.set(\amp,0.0);

~rp={
	~noiseSweep.value(1,-1,((16*4)/2), ((8*4)/2), 0.75);
	~noiseSweep2.value(1,-0.25,((24*4)/2),((8*4)/2), 0.5);
}


~rp={
	~noiseSweep.value(-1,1,((24*4)/2), ((8*4)/2), 0.25);
	~noiseSweep2.value(-0.25,1,((24*4)/2),((8*4)/2), 0.5);
}



~noiseSweepOff.value;
~noiseSweep2Off.value;


~rp={
	~circleExt4.set(\gate,0);
	~pulse1.set(\bamp,998);
	~pulse1.set(\amp,0);

	~pulseAmp.value(0,1,((16*4)/2),((8*4)/2),-0.85);
	~pulse1.set(\bamp,~circleExt4Out);
	~pulse1.set(\amp,0);

	~pulseSweep.value;
}


~rp={
	~circleExt4.set(\gate,0);
	~pulse1.set(\bamp,998);
	~pulse1.set(\amp,0);

	~pulseAmp.value(0,1,((16*4)/2),((8*4)/2),-0.75);
	~pulse1.set(\bamp,~circleExt4Out);
	~pulse1.set(\amp,0);

	~pulseSweep.value;
}


~pulseSweep.value(0.8,-1,((16*4)/2),((8*4)/2),0.5);
~pulseSweep.value(-1,0.8,((16*4)/2),((8*4)/2),0.5);

~rp={
	~pulseAmp.value(1,0,((16*4)/2),((8*4)/2),-0.75);
	~pulse1.set(\bamp,~circleExt4Out);
	~pulse1.set(\amp,0);
}


~rp={
	~midistring1_firmus.value;
}


~rp={
	~midistring2_firmus.value;
}

~midistring1_firmus = nil;

~string1_firmus - nil;



~circleExt5.set(\gate,0);
~vca1.set(\bamp,998);
~vca1.set(\amp,0.5);

~rp={
	~circleExt5.set(\gate,0);
	~vca1.set(\bamp,998);
	~vca1.set(\amp,0);


	~sineAmp.value(0, 0.45,((16*4)/2), ((8*4)/2), 0.5);

	~vca1.set(\bamp,~circleExt5Out);
	~vca1.set(\amp,0.0);



	~circleExt4.set(\gate,0);
	~pulse1.set(\bamp,998);
	~pulse1.set(\amp,0);

	~pulseAmp.value(0,1,((16*4)/2),((8*4)/2),-0.75);
	~pulse1.set(\bamp,~circleExt4Out);
	~pulse1.set(\amp,0);

}

~rp={
	~circleExt5.set(\gate,0);
	~vca1.set(\bamp,998);
	~vca1.set(\amp,0);
	~circleExt4.set(\gate,0);
	~pulse1.set(\bamp,998);

	~sineAmp.value(0.45,0,((16*4)/2), ((8*4)/2), 0.75);
	~vca1.set(\bamp,~circleExt5Out);
	~vca1.set(\amp,0.0);
	~pulseAmp.value(1,0,((16*4)/2),((8*4)/2),-0.75);
	~pulse1.set(\bamp,~circleExt4Out);
	~pulse1.set(\amp,0);
}

~vca1.set(\amp,0.60);



~pulse1.set(\amp,1);



//~startTimer.value(120);
~mixer1.set(\bal,1);
~mixer2.set(\bal,1);
~circleExt4.set(\gate,0);
~pulse1.set(\bamp,998);
~pulse1.set(\amp,0);
~circleExt5.set(\gate,0);
~vca1.set(\bamp,998);
~vca1.set(\amp,0);

t.schedAbs(timeNow + (8*4),{ // 00 = Time in beats
	(
		~noiseSweep.value(1,-0.4,((24*4)/2), ((4*4)/2), 0.25);
		~noiseSweep2.value(1,-0.40,((24*4)/2),((8*4)/2), 0.75);

		~pulseAmp.value(0,1,((16*4)/2),((4*4)/2),0.05);
		~pulse1.set(\bamp,~circleExt4Out);
		~pulse1.set(\amp,0);

		~sineAmp.value(0, 0.45,((16*4)/2), ((2*4)/2), 0.5);

		~vca1.set(\bamp,~circleExt5Out);
		~vca1.set(\amp,0.0);

);};); // End of t.schedAbs




t.schedAbs(timeNow + (32*4),{ // 00 = Time in beats
	(

		~pulseSweep.value;



);};); // End of t.schedAbs		//~startTimer.value(120);
~mixer1.set(\bal,1);
~mixer2.set(\bal,1);
~circleExt4.set(\gate,0);
~pulse1.set(\bamp,998);
~pulse1.set(\amp,0);
~circleExt5.set(\gate,0);
~vca1.set(\bamp,998);
~vca1.set(\amp,0);

t.schedAbs(timeNow + (8*4),{ // 00 = Time in beats
	(
		~noiseSweep.value(1,-0.4,((24*4)/2), ((4*4)/2), 0.25);
		~noiseSweep2.value(1,-0.40,((24*4)/2),((8*4)/2), 0.75);

		~pulseAmp.value(0,1,((16*4)/2),((4*4)/2),0.05);
		~pulse1.set(\bamp,~circleExt4Out);
		~pulse1.set(\amp,0);

		~sineAmp.value(0, 0.45,((16*4)/2), ((2*4)/2), 0.5);

		~vca1.set(\bamp,~circleExt5Out);
		~vca1.set(\amp,0.0);

);};); // End of t.schedAbs




t.schedAbs(timeNow + (32*4),{ // 00 = Time in beats
	(

		~pulseSweep.value;



);};); // End of t.schedAbs		//~startTimer.value(120);
~mixer1.set(\bal,1);
~mixer2.set(\bal,1);
~circleExt4.set(\gate,0);
~pulse1.set(\bamp,998);
~pulse1.set(\amp,0);
~circleExt5.set(\gate,0);
~vca1.set(\bamp,998);
~vca1.set(\amp,0);

t.schedAbs(timeNow + (8*4),{ // 00 = Time in beats
	(
		~noiseSweep.value(1,-0.4,((24*4)/2), ((4*4)/2), 0.25);
		~noiseSweep2.value(1,-0.40,((24*4)/2),((8*4)/2), 0.75);

		~pulseAmp.value(0,1,((16*4)/2),((4*4)/2),0.05);
		~pulse1.set(\bamp,~circleExt4Out);
		~pulse1.set(\amp,0);

		~sineAmp.value(0, 0.45,((16*4)/2), ((2*4)/2), 0.5);

		~vca1.set(\bamp,~circleExt5Out);
		~vca1.set(\amp,0.0);

);};); // End of t.schedAbs




t.schedAbs(timeNow + (32*4),{ // 00 = Time in beats
	(

		~pulseSweep.value;



);};); // End of t.schedAbs

