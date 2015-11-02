// =====================================================================
// SuperCollider Workspace
// =====================================================================
//Drifty noodle machine

(
SynthDef(\StereoModDelay, { arg
    //Chorus delay with EQ in the feedback loop
    //for that vintage tape echo mood

	bufferL,
	bufferR,
	time = 1.5,
	fb = 0.8,
	modRate = 5.5,
	modDepth = 0.0005,
	eqFc = 800,
	eqQ = 3;
	
	var signal, tapPhase, tap, tapPhaseL, tapPhaseR, tapL, tapR;
	var timeMod, eqMod;
	
	//Drop the input slightly to avoid clicky clipping
	signal = 0.7*In.ar(18, 2);
    signal = signal + LocalIn.ar(2);
    
    timeMod = LFDNoise3.ar(modRate, modDepth);
    eqMod = LFDNoise3.kr(1, 400);
    
	tapPhaseL = DelTapWr.ar(bufferL, signal[0]);
	tapL = DelTapRd.ar(bufferL, tapPhaseL, time+LFDNoise3.ar(modRate, modDepth), 2);
	tapL = BBandPass.ar(tapL, eqFc+eqMod, eqQ);
	
	tapPhaseR = DelTapWr.ar(bufferR, signal[1]);
	tapR = DelTapRd.ar(bufferR, tapPhaseR, time+LFDNoise3.ar(modRate, modDepth), 2);
	tapR = BBandPass.ar(tapR, eqFc+eqMod, eqQ);

	//Restore the output level
	Out.ar(0,[1.4*tapL, 1.4*tapR]);
	LocalOut.ar(fb*[tapR, tapL]);
}).add;

SynthDef(\Filters, { arg
	//Slowly varying bp filter applied across the mix
	//Creates a subtle phasing effect
	cutoffBase = 500,
	cutoffMod = 2000,
	resBase = 0.3,
	lpVol = 0,
	bpVol = 1,
	hpVol = 0,
	notchVol = 0,
	peakVol = 0;
	
	var signal = In.ar(16,2);
	
	//Modulated sine wave modulation source
	var modSig = SinOsc.ar(0.05+0.5*LFDNoise3(1), 0, 0.5, 0.5);
	
	//Two 12dB LPFs for 24db total
	//
	var output = SVF.ar(signal, cutoffBase + (modSig*cutoffMod), resBase, lpVol, bpVol, hpVol, notchVol, peakVol);
	output = 4*SVF.ar(output, cutoffBase + (modSig*cutoffMod), resBase, lpVol, bpVol, hpVol, notchVol, peakVol);
	
	Out.ar([0,1], output);
	Out.ar([18, 19], output);
}).add;	

SynthDef(\ChMach, { arg 
	f=440, 
	width = 0.5, 
	modFreq = 1,
	aTime = 5,
	rTime = 5,
	filter = 2,
	filterQ = 0,
	pan = 0.5;
	
	
	 var env = EnvGen.ar(Env([0.01,1,0.01],[aTime, rTime], 'exp'),  doneAction:2);
	
     var input = Vibrato.ar(VarSaw.ar(f, 0, LFNoise2.kr(1)), 5, 0.1, 0, 0.2, 0.1, 0.7);
	var theSine = SinOsc.ar(f); 

//	var theSaw = VarSaw.ar(f*1.5, 0, width);

// Emulate six unsynched LFOs driving six comparators for a multi-pulse chorus

	var oscs = 6;
	var scaler = 1/oscs;
	
	var lfo1 = LFTri.ar(modFreq*1.51); 
	var lfo2 = LFTri.ar(modFreq*1.11); 
	var lfo3 = LFTri.ar(modFreq*1.31); 
	var lfo4 = LFTri.ar(modFreq*0.71);
	var lfo5 = LFTri.ar(modFreq*0.61);  
	var lfo6 = LFTri.ar(modFreq*0.51);  
	
	var comp1 = input > lfo1; 
	var comp2 = input > lfo2;
	var comp3 = input > lfo3;
	var comp4 = input > lfo4;
	var comp5 = input > lfo5;
	var comp6 = input > lfo6;
	
	var output = scaler*(comp1+comp2+comp3+comp4+comp5+comp6);
	//Add a hint of fundamental for body
     output = output+0.001*theSine; 
	
	output = 0.01*LeakDC.ar(output, 0.9995); 
	
	//Doubled Moog with overdrive. 
	//Mmmm yeah.
	output = MoogFF.ar(output.tanh*20.0, (f*filter)+LFNoise2.ar(1, 400, 1), LFNoise2.ar(0,3.5, 0));
	output = MoogFF.ar(output*4, f*LFNoise2.kr(0.2, 6, 4), 0.5);
	
	output = 2*env*output.tanh;
	Out.ar(0, Pan2.ar(output, pan));
	Out.ar(16, Pan2.ar(output, pan));
	Out.ar(18, Pan2.ar(output, pan));
	 
}).add;
);

(
	var g=Group.basicNew(s,1);
	
	var stereoBuffer1L = Buffer.alloc(s, s.sampleRate*3, 1);
	var stereoBuffer1R = Buffer.alloc(s, s.sampleRate*3, 1);

     var monoBuffer1 = Buffer.alloc(s, s.sampleRate*2, 1);
   		
	var rootPitch=36;										// Start on a C

	var stopTranspose = 0;									
	var transposeCount = 10;									//Wait a while after transposing to minimise semitone clashes
	
	//Non-ET pentatonic ratios
	var thisRatio = [0.25, 0.5, 0.75, 1, 1.125, 1.333333, 1.5, 1.6875, 2, 2.25, 2.6666666, 3, 3.375, 4, 5];
	var thisPitch;

	var svf = Synth.tail(g, \Filters);
	var d = Synth.tail(g, \StereoModDelay);

	stereoBuffer1L.zero;
	stereoBuffer1R.zero;
	d.set(\bufferL, stereoBuffer1L);
	d.set(\bufferR, stereoBuffer1R);
	
	thisPitch = thisRatio.choose*rootPitch.midicps;
	
	//First few notes have a slow attack and longer interval
	{4.do
		{ 
		Synth.head(g, \ChMach,
			[\f, thisPitch,
			\width, rrand(0,1),
			\pan, rrand(-1,1),
			\aTime, rrand(5,15),
			\rTime, rrand(7,20),
			\filter, rrand(4,10),
			\filterQ, rrand(0,3.7), 
			\modFreq, rrand(0.7,1.5)]);
		  rrand(1,3).wait;
		}
	};
	  
	//Pick a note from the pentatonic scale with somewhat random settings
	//and slowly noodle around the circle of fifths
	{inf.do 
		{
		thisPitch = thisRatio.choose*rootPitch.midicps;
		stopTranspose = stopTranspose + 1;
		Synth.head(g, \ChMach,
			[\f, thisPitch,
			\width, rrand(0,1),
			\pan, rrand(-1,1),
			\aTime, rrand(0.01,15),
			\rTime, rrand(7,20),
			\filter, rrand(4,10),
			\filterQ, rrand(0,3.7), 
			\modFreq, rrand(0.7,1.5)]);
		if ((0.04.coin) && (stopTranspose > transposeCount)) {
			stopTranspose = 0;
			rootPitch = rootPitch + 7;
			if (rootPitch > 47) {rootPitch = rootPitch - 12};
			rootPitch.postln;
			};	
		   rrand(0.1,2).wait;
		   }
	}.fork;
)


n=LFNoise1;Ndef(\x,{a=SinOsc.ar(65,Ndef(\x).ar*n.ar(0.1,3),n.ar(3,6)).tanh;9.do{a=AllpassL.ar(a,0.3,{0.2.rand+0.1}!2,5)};a.tanh}).play


// been listening to a lot of vangelis/wendy carlos recently
// largely modified from the cs80_mh in synthdefpool 

(
var scale,fund;

scale = [0,3,7];

fork{
	loop{
		var t = [16,32].choose;
		fund = 26+[0,3,7,10,14].choose;
		fund.postln;
		t.wait;
	};
};

fork{			
	loop{
		var t = 1/2;
		var a,d,s,r,fa,fd,fs,fr,ratio,dtune,freq,
			ffreq,vibrate,vibdepth,cutoff,amp;
 		freq = (scale.choose+fund+(12*(0..3).choose)).midicps;
 		vibrate = t/(1..10).choose;
 		vibdepth = (90..500).choose.reciprocal;
		dtune = 1e-3; LFNoise0.kr(t,0.02,1);
		cutoff = freq * (1.1,1.2..4).choose;
 		ratio = (0.99,0.991..1.01).choose;	
 		amp = 1/3;
		
 		a = 3.0.rand/t;		
 		s = 3.0.rand/t;
 		r = 3.0.rand/t;
 		fa = 3.0.rand/t;
 		fs = 3.0.rand/t;
 		fr = 3.0.rand/t;
		
		play{
			var env, fenv, sig, gate, vib;
			gate = Line.kr(1,0,t);
			env = EnvGen.kr(Env.linen(a,s,r),doneAction:2);
			fenv = EnvGen.kr(Env.linen(fa,fs,fr));
			freq = Line.kr(freq,freq*ratio,t);
			vib = SinOsc.kr(vibrate).range(vibdepth.neg,vibdepth)+1;
			freq = vib*freq;			
			//freq = freq.lag(t);
			sig = Select.ar(2.rand,[
				Pulse.ar([freq,freq*(1+dtune),freq*(1-dtune)],
					LFNoise2.kr(t,0.5,0.5), 0.1).sum,
				Saw.ar([freq,freq*(1+dtune),freq*(1-dtune)]).sum
			]);
			sig = sig.tanh * env;
			ffreq = max(fenv*freq*12,cutoff)+100;
			sig = MoogFF.ar(sig,ffreq,LFNoise2.kr(1/t,1.4,1.5)).tanh;
			sig = RLPF.ar(sig,1e4,0.9).tanh;
			Pan2.ar(sig*amp,LFNoise2.kr(t.rand));
			};
		t.wait;
		};
	};

// this was inspired by http://sccode.org/1-4EG 
// good way to get the reverb out of the loop... 
// thanks rukano ;)
{
	var in = In.ar(0,2);
	in = in * 0.25;
	in = Compander.ar(in,in,0.75,1,0.75,0.1,0.4);
	in = (in*0.2) + GVerb.ar(HPF.ar(in,100), 20, 20, mul:0.6).tanh;
	in = Limiter.ar(LeakDC.ar(in));		
	ReplaceOut.ar(0, in)
}.play(addAction:\addToTail);
)


/*
Schemawound track for Waxen Wing's "Give Me A Sine" compilation.

Compilation Description: All songs written using ONLY sine waves in their creation. All oscillations, modulations, lfo's, envelopes, etc, use only sine waves. No samples or outside source audio were permitted on this releases, unless of course the samples were of pure sine waves. Download includes full 8 panel artwork and extensive liner notes on each piece written by each artist. 

Download the free compilation here: http://waxenwings.bandcamp.com/album/give-me-a-sine

Blog post about the creation of this track: http://schemawound.tumblr.com/post/24520532915/sinusoid
*/

(
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Sinusoid -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	SynthDef(\Sinusoid, {
		|
			out = 0,					gate = 1,					amp = 1,					freqArrayMult = 1,		
			mod1FreqRLfoFreq = 0.1,		mod1FreqRLfoDepth = 100,	mod1FreqRLfoOffset = 100,	
			mod2Freq = 50,				combDelay = 0.7, 			combDecay = 9,				
			attack = 0.001 				release = 0.5
		|
		//
		var combMaxDelay = 10;
		//Many Sines
		var freqArray = (1..50) * freqArrayMult; 
		var manySines = Mix(SinOsc.ar(freqArray));
		//Mod1
		var mod1FreqL = SinOsc.kr(150, 0, 20);
		var mod1FreqRLfo = SinOsc.kr(mod1FreqRLfoFreq, 0, mod1FreqRLfoDepth, mod1FreqRLfoOffset);
		var mod1FreqR = SinOsc.kr(mod1FreqRLfo, 0, 37);
		var mod1 = SinOsc.ar([mod1FreqL, mod1FreqR]);
		//Mod2
		var mod2 = SinOsc.ar(mod2Freq);
		//Sum and FX
		var sinSum = manySines * mod1 * mod2;
		var comb = sinSum; //+ CombC.ar(sinSum, combMaxDelay, combDelay, combDecay);
		var dist = comb.tanh;
		var env = dist * Linen.kr(gate, attack, amp, release, doneAction: 2);
		//Output
		Out.ar(out, env);
	}).add;

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ELEKTRO KICK -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	SynthDef(\ElektroKick, { 
		|
			out = 0,		gate = 1,		amp = 1,			freqArrayMult = 1,		
			basefreq = 50,	envratio = 3, 	freqdecay = 0.02, 	ampdecay = 0.5
		|
		var fenv = EnvGen.ar(Env([envratio, 1], [freqdecay], \exp), 1) * basefreq;
		var aenv = EnvGen.ar(Env.perc(0.005, ampdecay), 1, doneAction:2);
		var output = SinOsc.ar(fenv, 0.5pi, aenv) * amp;
		Out.ar(out, output!2);
	}).add;

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- VERB -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	SynthDef(\Verb, {
		arg 	out = 0,	in,
			mix = 0.25,	room = 0.15,	damp = 0.5;
	
		var input, verb;
		
		input = In.ar(in);
		verb = FreeVerb.ar(input, mix, room, damp);
		Out.ar(out, verb!2);
	}).add;
)

(
	//Groups and Busses
	var sourceGroup = Group.new;
	var fxGroup = Group.after(~sourceGroup);
	var verbBus = Bus.audio(s, 2);
	var mainOut = 0;
	var verb = Synth.tail(~fxGroup, \Verb, [\in, verbBus, \out, mainOut, \mix, 1, \room, 1]);

	//Song Variables
	var bar = 0.94;
	var qNote = bar/4;
	var eNote = bar/8;

	//Mix
	var finalAmp 	= 0.1;
	var hatAmp 		= 0.6 * finalAmp;
	var bassAmp 	= 0.8 * finalAmp;
	var loToneAmp 	= 0.8 * finalAmp;
	var hiWhineAmp 	= 0.7 * finalAmp;
	var eKickAmp 	= 2.1 * finalAmp;

	//Basic Patterns
	var hat = {|beatsPerMeasure = 9, freqArrayMult = 1|
		Pbind(*[instrument: \Sinusoid, amp: hatAmp, group: sourceGroup,
			dur:				Pseq([bar / beatsPerMeasure], beatsPerMeasure),
			freqArrayMult:		Pxrand((1..12), inf),
			mod2Freq:			Pwhite(60, 6000, inf),
			mod1FreqRLfoFreq:	0.01,
			mod1FreqRLfoDepth:	Pwhite(1000, 3000, inf),
			mod1FreqRLfoOffset:	Pwhite(10, 300, inf),
			release:			Pkey(\dur)
		])
	};
	var bass = {|beatsPerMeasure|
		Pbind(*[instrument: \Sinusoid, amp: bassAmp, group: sourceGroup,
			dur:				Pseq([bar / beatsPerMeasure], beatsPerMeasure),
			mod2Freq:			Pwhite(30, 300, inf),
			mod1FreqRLfoFreq:	Pwhite(0.1, 0.3, inf),
			mod1FreqRLfoDepth:	Pwhite(10, 300, inf),
			mod1FreqRLfoOffset:	Pwhite(10, 300, inf),
			release:			0.001
		])
	};
	var lowtone = {|beatsPerMeasure = 1, attack = 0.001, out = 0|
		Pbind(*[instrument: \Sinusoid, amp: loToneAmp, group: sourceGroup,
			dur:				Pseq([bar / beatsPerMeasure], beatsPerMeasure),
			mod2Freq:			Pwhite(30, 400, inf),
			mod1FreqRLfoFreq:	Pwhite(0.1, 0.3, inf),
			mod1FreqRLfoDepth:	Pwhite(10, 300, inf),
			mod1FreqRLfoOffset:	Pwhite(10, 300, inf),
			attack:				attack,
			release:			Pkey(\dur),
			out:				out
		])
	};
	var lowtoneLong = Pbind(*[instrument: \Sinusoid, amp: loToneAmp, group: sourceGroup,
		dur:				Pseq([bar*8], 1),
		freqArrayMult:		3,
		mod2Freq:			50,
		mod1FreqRLfoFreq:	0.1,
		mod1FreqRLfoDepth:	100,
		mod1FreqRLfoOffset:	100,
		release:			3
	]);
	var hiWhine = {|out = 0|
		Pbind(*[instrument: \Sinusoid, amp: hiWhineAmp, group: sourceGroup,
			dur:				Pseq([bar], 1),
			mod2Freq:			2000,
			mod1FreqRLfoFreq:	Pwhite(0.1, 0.3, inf),
			mod1FreqRLfoDepth:	100,
			mod1FreqRLfoOffset:	100,
			release:			Pkey(\dur),
			out:				out
		])
	};
	var elektroKick = {|beatsPerMeasure = 1|
		Pbind(*[instrument: \ElektroKick, amp: eKickAmp, group: sourceGroup,
			dur:				Pseq([bar / beatsPerMeasure], beatsPerMeasure),
			basefreq:			Pwhite(70, 75),
			ampdecay:			2,
			envratio:			1,
			freqdecay:			1
		])
	};

	//8 Bar Patterns
	var loTonePat = [
		Pn(lowtone.(1), 8),					//loTone pattern 0 - 8 bars
		Pn(lowtone.(1, bar), 8),				//loTone pattern 1 - 8 bars
		Pn(lowtone.(1, out:verbBus), 8)	//loTone pattern 2 - 8 bars
	];

	var hiWhinePat = [
		Pn(hiWhine.(verbBus), 8),	//hiWhine pattern 0 - 8 bars
		Pn(hiWhine.(mainOut), 8)	//hiWhine pattern 0 - 8 bars
	];

	var hatPat = [
		Pseq([//hat pattern 0 - 8 bars
			Pn(hat.(9), 7),		hat.(11)
		]),	
		Pseq([//hat pattern 1 - 8 bars
			hat.(8), 			hat.(9,(1..12)),	hat.(9), 			hat.(7,(1..12)),
			hat.(6,(1..12)),	hat.(12,(1..12)),	hat.(6,(1..12)),	hat.(24,(1..12))
		]),
		Pseq([//hat pattern 2 - 8 bars
			hat.(8), 			hat.(3),			hat.(6),			hat.(9),
			hat.(8,(1..12)),	hat.(3,(1..12)),	hat.(6,(1..12)),	hat.(12,(1..12))
		]),
		Pseq([//hat pattern 3 - 8 bars
			hat.(9), 			hat.(8),			hat.(7),			hat.(8),
			hat.(9,(1..12)),	hat.(8,(1..12)),	hat.(16,(1..12)),	hat.(32,(1..12))
		])
	];

	var bassPat = [
		Pn(bass.(3), 8),	//bass pattern 0 - 8 bars
		Pseq([				//bass pattern 1 - 8 bars
			bass.(4),	Pn(bass.(3),3)
		], 2),
		Pseq([				//bass pattern 2 - 8 bars
			bass.(4),	Pn(bass.(3),3),		
			bass.(4),	Pn(bass.(3),2), 	bass.(5)
		]),
		Pseq([				//bass pattern 3 - 8 bars
			bass.(4), 	bass.(3.5), 		bass.(3),		bass.(3.5),
			bass.(4), 	bass.(3), 			bass.(6),		bass.(7)
		]),
		Pseq([				//bass pattern 4 - 8 bars
			bass.(4),	Pn(bass.(3), 7)
		]),
	];

	var kickPat = [
		Pn(elektroKick.(1), 8),		//kick pattern 0 - 8 bars
		Pn(elektroKick.(2), 8)	//kick pattern 1 - 8 bars
	];

	var drop = [
		Pn(Ppar([lowtone.(1), hiWhine.(verbBus)]), 2),										//Drop Pattern 0 - 2 bars
		Pn(Ppar([lowtone.(1), hiWhine.(verbBus), elektroKick.(1)]), 2),						//Drop Pattern 1 - 2 bars
		Pn(Ppar([lowtone.(1), hiWhine.(verbBus), elektroKick.(1), hiWhine.(mainOut)]), 2),	//Drop Pattern 2 - 2 bars
	];

	//Song
	var song = Pseq([
								loTonePat[0], 				
		Ppar([	bassPat[0], 	loTonePat[0]																				]), 
		Ppar([	bassPat[0], 	loTonePat[0],					hatPat[0]													]), 
		drop[0], 
		Ppar([	bassPat[0], 	loTonePat[0], 								kickPat[0]										]), 
		Ppar([	bassPat[0], 	loTonePat[0],					hatPat[0], 	kickPat[0]										]),
		drop[1],
		Ppar([	bassPat[1], 									hatPat[2], 	kickPat[0]										]), 
		Ppar([	bassPat[2], 	loTonePat[0], 					hatPat[2], 	kickPat[0]										]),
		drop[2],
		Ppar([	bassPat[1], 									hatPat[2], 	kickPat[0],		hiWhinePat[0]					]), 
		Ppar([	bassPat[2], 	loTonePat[0], 					hatPat[2], 	kickPat[0]										]),
		Ppar([	bassPat[1], 					loTonePat[2],	hatPat[2], 	kickPat[0],		hiWhinePat[0],	hiWhinePat[1]	]), 
		Ppar([	bassPat[2], 	loTonePat[0],	loTonePat[2],	hatPat[2], 	kickPat[0],						hiWhinePat[1]	]),
		drop[0],
								loTonePat[2]
	]);

	song.play;
)


/*
"Please Hold (Extended)" by Schemawound
Appears on the album "They Want To Make Your Body Move.  I Want To Hold You Perfectly Still."
Full album is available for download from http://www.schemawound.com

Code by Jonathan Siemasko
Contact: schemawound@yahoo.com
Homepage: http://www.schemawound.com/
*/

(
	var seconds;

	{	
		SynthDef(\PleaseHold, {|seconds = 7|
			var sines = 
				SinOsc.ar(Line.kr([40, 47], 47, seconds - 1)) 
				* 
				SinOsc.ar(Line.kr([65, 60], 47, seconds - 1))
				* 
				SinOsc.ar(Line.kr([80, 89], 47, seconds - 1))
				* 
				SinOsc.ar(Line.kr([300, 270], 47, seconds - 1))
				* 
				SinOsc.ar(Line.kr([435, 472], 47, seconds - 1))
				*
				Line.ar(1, 0, seconds)
			;
			var verb = FreeVerb.ar(sines, 1, 1, 0) * 0.9;
			var riseLine = (SinOsc.ar([330, 335]) * Line.ar(0, 0.5, seconds)).clip2(0.4);
			var env = EnvGen.ar(Env.linen(0.1, seconds - 0.2, 0.1), doneAction:2);
			var output = (verb + riseLine) * env;
			Out.ar(0, output * 0.6);
		}).add;

		s.sync;

		seconds = 420; Synth(\PleaseHold, [\seconds, seconds]);
	}.fork
)


/*
"Any Moment" by Schemawound
Appears on the album "They Want To Make Your Body Move.  I Want To Hold You Perfectly Still."
Full album is available for download from http://www.schemawound.com

Code by Jonathan Siemasko
Contact: schemawound@yahoo.com
Homepage: http://www.schemawound.com/
*/

({//-=-=-=-=-=-=-=-=-=-=-=-=-=- WATERPADRISE DEF -=-=-=-=-=-=-=-=-=-=-=-=-=-
	SynthDef(\WaterPadRise5, {
		|
			out = 0,	amp = 1, baseEnvLfoSpeed = 1, sinLfoSpeed = 0.001,
			maxEnvLfoDepth = 10, maxSinLfoDepth = 60
		|
		var numOfSines = 5;
		var minEnvLfoSpeed = baseEnvLfoSpeed * 0.09;
		var maxEnvLfoSpeed = baseEnvLfoSpeed * 1.1;
		var output = Mix(
			Array.fill(numOfSines, {
				arg i;
				var envLfoSpeed = Rand(minEnvLfoSpeed, maxEnvLfoSpeed);
				var envLfo = i * SinOsc.kr(envLfoSpeed).range(1, maxEnvLfoDepth);
				var env = max(0, LFNoise1.kr(envLfo));
				var oscLfo = SinOsc.kr(sinLfoSpeed).range(1, maxSinLfoDepth) * (i + 1);
				SinOsc.ar(oscLfo, mul: env);
			})
		);
		Out.ar(out, output * (amp * 0.1));
	}).add;

	SynthDef(\WaterPadRise25, {
		|
			out = 0,	amp = 1, baseEnvLfoSpeed = 1, sinLfoSpeed = 0.001,
			maxEnvLfoDepth = 10, maxSinLfoDepth = 60
		|
		var numOfSines = 25;
		var minEnvLfoSpeed = baseEnvLfoSpeed * 0.09;
		var maxEnvLfoSpeed = baseEnvLfoSpeed * 1.1;
		var output = Mix(
			Array.fill(numOfSines, {
				arg i;
				var envLfoSpeed = Rand(minEnvLfoSpeed, maxEnvLfoSpeed);
				var envLfo = i * SinOsc.kr(envLfoSpeed).range(1, maxEnvLfoDepth);
				var env = max(0, LFNoise1.kr(envLfo));
				var oscLfo = SinOsc.kr(sinLfoSpeed).range(1, maxSinLfoDepth) * (i + 1);
				SinOsc.ar(oscLfo, mul: env);
			})
		);
		Out.ar(out, output * (amp * 0.1));
	}).add;

	SynthDef(\WaterPadRise50, {
		|
			out = 0,	amp = 1, baseEnvLfoSpeed = 1, sinLfoSpeed = 0.001,
			maxEnvLfoDepth = 10, maxSinLfoDepth = 60
		|
		var numOfSines = 50;
		var minEnvLfoSpeed = baseEnvLfoSpeed * 0.09;
		var maxEnvLfoSpeed = baseEnvLfoSpeed * 1.1;
		var output = Mix(
			Array.fill(numOfSines, {
				arg i;
				var envLfoSpeed = Rand(minEnvLfoSpeed, maxEnvLfoSpeed);
				var envLfo = i * SinOsc.kr(envLfoSpeed).range(1, maxEnvLfoDepth);
				var env = max(0, LFNoise1.kr(envLfo));
				var oscLfo = SinOsc.kr(sinLfoSpeed).range(1, maxSinLfoDepth) * (i + 1);
				SinOsc.ar(oscLfo, mul: env);
			})
		);
		Out.ar(out, output * (amp * 0.1));
	}).add;

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- VERB DEF -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	SynthDef(\Verb, {
		arg 	out = 0,	in,
			mix = 0.25,	room = 0.15,	damp = 0.5;
	
		var input, verb;
		
		input = In.ar(in);
		verb = FreeVerb.ar(input, mix, room, damp);
		Out.ar(out, verb!2);
	}).add;

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- CONTROL OSC DEF -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	SynthDef(\ControlOsc, {
		|
			out = 0,	freq = 60, phase = 0pi, amp = 1
		|
	
		Out.kr(out, SinOsc.kr(freq, phase).range(0, amp));
	}).add;

	Server.default.sync;

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- SIGNAL FLOW -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
/*
	Water5  -> Verb1 -> Verb2 -> Out
	Water25 ->
	Water50 ->
*/

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- GROUPS AND BUSSES -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	~sourceGroup = Group.new;
	~fxGroup = Group.after(~sourceGroup);
	~mainOut = 0;
	~verbBus1 = Bus.audio(s, 2);
	~verbBus2 = Bus.audio(s, 2);
		
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- VERBS -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	// Verb 1
	~verb1 = Synth.head(~fxGroup, \Verb, [\in, ~verbBus1, \out, ~verbBus2]);
	~verb1AmntCtrlBus = Bus.control(s, 1); ~verb1AmntCtrlBus.set(1); 
	~verb1.map(\mix, ~verb1AmntCtrlBus);
	~verb1MixOsc = Synth.before(~verb1, \ControlOsc, [\out, ~verb1AmntCtrlBus, \freq, 0.05, \amp, 1]); 

	//Verb 2
	~verb2 = Synth.tail(~fxGroup, \Verb, [\in, ~verbBus2, \out, ~mainOut]);
	~verb2AmntCtrlBus = Bus.control(s, 1); ~verb2AmntCtrlBus.set(0); 
	~verb2.map(\mix, ~verb2AmntCtrlBus);
	~verb2MixOsc = Synth.before(~verb2, \ControlOsc, [\out, ~verb2AmntCtrlBus, \freq, 0.04, \amp, 1]); 

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- WATERS -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	// Water 5
	~water5Group = Group.head(~sourceGroup);
	~water5CtrlBus = Bus.control(s, 1); ~water5CtrlBus.set(0);
	~waterPadRise5 = Synth.tail(~water5Group, \WaterPadRise5, [\out, ~verbBus1]);
	~waterPadRise5.map(\amp, ~water5CtrlBus);
	~water5Lfo = Synth.head(~water5Group, \ControlOsc, [\out, ~water5CtrlBus, \freq, 0.1, \amp, 1]);

	// Water 25
	~water25Group = Group.head(~sourceGroup);
	~water25CtrlBus = Bus.control(s, 1); ~water25CtrlBus.set(0);
	~waterPadRise25 = Synth.tail(~water25Group, \WaterPadRise25, [\out, ~verbBus1]);
	~waterPadRise25.map(\amp, ~water25CtrlBus);
	~water25Lfo = Synth.head(~water25Group, \ControlOsc, [\out, ~water25CtrlBus, \freq, 0.1, \phase, 1pi, \amp, 1]);

	// Water 50
	~water50Group = Group.head(~sourceGroup);
	~water50CtrlBus = Bus.control(s, 1); ~water50CtrlBus.set(0);
	~waterPadRise50 = Synth.tail(~water50Group, \WaterPadRise50, [\out, ~verbBus1]);
	~waterPadRise50.map(\amp, ~water50CtrlBus);
	~water50Lfo = Synth.head(~water50Group, \ControlOsc, [\out, ~water50CtrlBus, \freq, 0.01, \phase, 1pi, \amp, 0.5]);
}.fork
)


/*
"Dusk" by Schemawound
Appears on the album "They Want To Make Your Body Move.  I Want To Hold You Perfectly Still."
Full album is available for download from http://www.schemawound.com

Code by Jonathan Siemasko
Contact: schemawound@yahoo.com
Homepage: http://www.schemawound.com/
*/

(
    {
        //-----Variables-----
        var mainout = 0;
        var dawn;

        //-----SynthDefs-----
        SynthDef(\additivePad, { 
            |
                outbus = 0,     freq = 40,      amp = 1,    attack = 0.1,   decay = 0.1,    
                lfo0L = 0.5,    lfo0R = 0.5,    lfo1L= 0.1, lfo1R = 0.1,    lfo2L= 0.5,     lfo2R = 0.5
            |
            var syn, env, ampMod, output;
            var lfo2input = Array.new(2);
            var lfo = Array.new(3);
            lfo = lfo.add(SinOsc.kr([lfo0L, lfo0R]).range(0, 1));
            lfo = lfo.add(SinOsc.kr([lfo1L, lfo1R]).range(0, 1));
            lfo2input = lfo2input.add(lfo2L * lfo[0] * lfo[1]); //Left
            lfo2input = lfo2input.add((lfo2R * (1 - lfo[0])) * (1 - lfo[1])); //Right
            lfo = lfo.add(SinOsc.kr(lfo2input, 1.5pi).range(0, 1));
            env = EnvGen.kr(Env.perc(attack, decay), doneAction: 2);
            syn = SinOsc.ar(freq) * lfo[2];
            output = syn * env * amp;
            Out.ar(outbus, output);
        }).add; 

        //-----Sync-----
        Server.default.sync;

        //-----Patterns-----
        dawn = Pbind(*[instrument: \additivePad, 
            dur:        1,
            amp:        0.02,
            freq:       100,
            lfo0L:      Pwhite(0.5, 100),   lfo0R:  Pwhite(0.5, 100),
            lfo1L:      Pwhite(0.1, 0.5),   lfo1R:  Pwhite(0.1, 0.5),
            lfo2L:      Pwhite(0.5, 100),   lfo2R:  Pwhite(0.5, 1000),
            attack:     Pwhite(0.1, 30),    decay:  Pwhite(0.1, 30),
            outbus:     mainout
        ]);

        //-----Sequence-----
        "".postln;"-----Start Sequence-----".postln;
        Pdef(\dawn, dawn).fadeTime_(3).play;        "Start".postln;             //0:00
        Pbindef(\dawn, \freq, Pwhite(40, 500));     "Low".postln;   30.wait;    // 00:30
        Pbindef(\dawn, \freq, Pwhite(40, 5000));    "High".postln;  30.wait;    // 01:00
        Pbindef(\dawn, \freq, Pwhite(40, 500));     "Low".postln;   30.wait;    // 01:30
        Pbindef(\dawn, \freq, Pwhite(40, 5000));    "High".postln;  30.wait;    // 02:00
        Pbindef(\dawn, \attack, 1);
        Pbindef(\dawn, \decay, 0);
        Pbindef(\dawn, \dur, 0.1);
        Pbindef(\dawn, \freq, Pwhite(40, 5000));      "Lefturn".postln;  30.wait;    // 02:30
        Pbindef(\dawn, \freq, Pwhite(40, 1100));      "lowturn".postln;  30.wait;    // 03:00
        Pdef(\dawn, dawn);
        Pbindef(\dawn, \freq, Pwhite(40, 500));     "Low".postln;   30.wait;    // 03:30
        Pbindef(\dawn, \freq, Pwhite(40, 5000));    "High".postln;  30.wait;    // 04:00
        Pbindef(\dawn, \freq, Pwhite(40, 500));     "Low".postln;   30.wait;    // 04:30
        Pbindef(\dawn, \freq, Pwhite(40, 5000));    "High".postln;  30.wait;    // 05:00
        Pdef(\dawn).stop;
        "-----End Sequence-----".postln; "".postln;
    }.fork;
)


(
Server.local.waitForBoot({
(
z.free;
z = Buffer.alloc(s, 512, 1);
z.sine1(1.0 / [1, 2, 3, 4], true, true, true);

 fork( { loop {
 SynthDef("g1",{ arg out=0,bufnum=0,dur=1,rate=1,pos=0,sdens=1,edens=1;
     var dens = Line.kr(sdens,edens,dur);
     var trig = [LFNoise0,SinOsc,Impulse,LFPulse,LFSaw].choose.ar(Line.kr(sdens,edens,dur));
     //var env = EnvGen.kr(Env.perc(0.0001.rrand(0.1),dur*0.5.rrand(2)),doneAction:2);
     var env = EnvGen.kr(Env.perc(0.0001.rrand(0.1),dur*(0.5.rrand(4))),doneAction:2);
     Out.ar(out,
         GrainBuf.ar(2,trig,1/dens,bufnum,rate,pos)*env;
         )
     }).add();
  [1,2,4,8,16,32].choose.postln.wait;
 }
 }
 );


a = Pbind(\instrument,\g1,\dur,Pseq([Pseq([0.25],32),Pseq([0.25,0.125,0.125],32),Pseq([0.125],32)],inf),\sdens,Pseq([9000,1000,500]/10,inf),\edens,Prand([Pseq([9000,1000,500]/10,4),Pseq([1],1)],inf),\rate,Pfunc({-10.0.rrand(10)}),\pos,Pfunc({1.0.rand}),\bufnum,z.bufnum);
b = Pbind(\instrument,\g1,\dur,Pseq([4],inf),\sdens,Pseq([9000,1000,500]/100,inf),\edens,Prand([Pseq([9000,1000,500]/10,1),Pseq([1],3)],inf),\rate,Pfunc({-10.0.rrand(10)}),\pos,Pfunc({-10.0.rrand(10)}),\bufnum,z.bufnum);
c = Pbind(\instrument,\g1,\dur,Pseq([4/3],inf),\sdens,Pseq([9000,1000,500,25],inf),\edens,Prand([Pseq([9000,1000,500,25],1),Pseq([1],4)],inf),\rate,Pfunc({-100.0.rrand(100)}),\pos,Pfunc({-10.0.rrand(10)}),\bufnum,z.bufnum);


a =a.play;
b =b.play;
c =c.play;

)
});
)


/* 
Schemawound track from the SIGNALVOID compilation.
SIGNALVOID is a noise compilation. Participants were asked to create up to three tracks, each of exactly one minute in length, with no gaps of silence at the beginning or end. Download the free compilation here: http://archive.org/details/SignalvoidMp3 or http://archive.org/details/SignalvoidFlac
Physical copies are available here http://signalvoid.bandcamp.com/merch/signalvoid-2

Blog post about the creation of this track http://schemawound.tumblr.com/post/29070261257/signalvoid-3-the-piano
*/

(
	SynthDef(\ThePiano, {
		|
			sampleHoldFreq = 1,			saw0Freq = 0.1,			saw0DepthMin = 1,		saw0DepthMax = 1000,
			saw1FreqLeft = 10,			saw1FreqRight = 10.92, 
			saw2FreqLeft = 9, 			saw2FreqRight = 11.59,
			saw5FreqLeft = 0.1,			saw5FreqRight = 0.125,	saw5DepthMin = 1,		saw5DepthMax = 60
			i_comb0MaxDelay = 1,		comb0Delay = 0.001,		comb0Decay = 0.1,
			i_comb1MaxDelay = 1,		comb1Delay = 0.0125,	comb1Decay = 0.1,
			verb0Mix		= 1.0,		verb0Room = 0.7,
			verb1Mix		= 1.0,		verb1Room = 1.0,
			amp = 1
		|

		//Local Vars
		var sampleAndHold;
		var saw = Array.new;
		var comb = Array.new;
		var verb = Array.new;
		var comp;
		
		//Saws
		/* -----------
			Saw Index:
			0: Mod for Saw 3 (Sample and Hold mod)
			1: Dual Channel Saw
			2: Dual Channel Saw
			3: Saw with freq modified by a S&H
			4: 1 * 2 * 3
			5: Mod for saw 6
			6: 5 * 4, used for reverb
		-------------*/
		sampleAndHold = Latch.ar(WhiteNoise.ar, Impulse.ar(sampleHoldFreq));
		saw = saw.add(SinOsc.ar(saw0Freq).range(saw0DepthMin, saw0DepthMax));
		saw = saw.add(LFSaw.ar([saw1FreqLeft, saw1FreqRight]));
		saw = saw.add(LFSaw.ar([saw2FreqLeft, saw2FreqRight]));
		saw = saw.add(LFSaw.ar(sampleAndHold * saw[0]));
		saw = saw.add(saw[1] * saw[2] * saw[3]);
		saw = saw.add(LFSaw.kr([saw5FreqLeft, saw5FreqRight]).range(saw5DepthMin, saw5DepthMax));
		saw = saw.add(LFSaw.ar(saw [5] * saw[4]));
		
		//Combs
		comb = comb.add(CombC.ar(saw[4],	i_comb0MaxDelay, 	comb0Delay, 	comb0Decay));
		comb = comb.add(CombC.ar(comb[0],	i_comb1MaxDelay, 	comb1Delay, 	comb1Decay));
		
		//Verbs
		verb = verb.add(FreeVerb.ar(comb[1], 			verb0Mix,	verb0Room));
		verb = verb.add(FreeVerb.ar(verb[0] * saw[6],	verb1Mix,	verb1Room));
		
		//Out
		Out.ar(0, verb[1] * (amp * 0.2));
	}).add;
)

(
	x = Synth(\ThePiano, [
		\saw0ModFreq, 		0.1,	\saw0ModDepthMin,	1,		\saw0ModDepthMax,	1000,	
		\saw1FreqLeft,		10,		\saw1FreqRight,		10.92,
		\saw2FreqLeft,		9,		\saw2FreqRight,		11.59,
		\saw5FreqLeft,		0.1,	\saw5FreqRight,		0.125,	\saw5DepthMin,		1,		\saw5DepthMax,		60,
		\i_comb0MaxDelay,	0.001,	\comb0Delay,		0.001,	\comb0Decay,		0.1,
		\i_comb1MaxDelay,	0.0125,	\comb1Delay,		0.0125,	\comb1Decay,		0.1,
		\verb0Mix,			1.0,	\verb0Room,			0.7,	
		\verb1Mix,			1.0,	\verb1Room,			1.0,
		\amp,				1
	]);
)


/*
Schemawound track from the SIGNALVOID compilation.
SIGNALVOID is a noise compilation. Participants were asked to create up to three tracks, each of exactly one minute in length, with no gaps of silence at the beginning or end. Download the free compilation here: http://archive.org/details/SignalvoidMp3 or http://archive.org/details/SignalvoidFlac
Physical copies are available here http://signalvoid.bandcamp.com/merch/signalvoid-2

Blog post about the creation of this track http://schemawound.tumblr.com/post/29066507849/signalvoid-2-the-same-color-as-your-skin
*/

(
var songLength = 60;
{
	//Sines
	var sineLine1 = Line.kr(600, 210, songLength);
	var sineLine2 = Line.kr(100, 210, songLength);
	var sines = SinOsc.ar(sineLine1) * SinOsc.ar(sineLine2);
	//Filter
	var filterLineLFO = SinOsc.ar(0.2);
	var filterLine = Line.kr(200, 6000, songLength, doneAction: 2) * filterLineLFO;
	var filtLFO = SinOsc.kr(0.4).range(60, filterLine);
	var filter = BMoog.ar(sines, filtLFO, 0.9, 1).tanh * 0.5;
	//Comb
	var comb = CombL.ar(filter, 1, 0.3, 1);
	var mix1 = (comb + GVerb.ar(filter)) * 0.1;
	mix1 = (CombL.ar(mix1, 1, 1, 6) * 0.3) + mix1;
	HPF.ar(mix1, 100) * 0.5;
}.play
)

SynthDef(\ChicagoPad, { |out = 0, freq = 440, cutoff = 500, amp = 0.2|
	var snd;
	freq = freq + SinOsc.kr(0.1, 0, 1, 20);
	snd = Saw.ar([freq, freq+1, freq-1, freq*3/2, freq*6/5])*0.1;
	snd = snd + VarSaw.ar(0.99*[freq, freq+1, freq-1,freq*3/2, freq*6/5],0, LFTri.kr(0.3).range(0.25,0.9))*0.1;
	snd = Mix(snd);
	snd = RLPF.ar(snd, SinOsc.kr(0.1, 0, 100, 5000), 0.1);
	snd = GVerb.ar(snd ,40, 10, 0.6, 0.6, -3, -9, -11)*0.2;
	
	//snd = RLPF.ar(snd, SinOsc.kr(0.08, 0.5, cutoff/10, cutoff), 0.2);
	snd = MoogFF.ar(snd, SinOsc.kr(0.08, 0.5, cutoff/10, cutoff), 3, 0);
	snd = DelayC.ar(snd, 1.5, 1,0.8);
	//snd = snd * EnvGen.ar(Env.linen(0.001, 0.01,0.01,1), doneAction:2);
	Out.ar(out, [snd, AllpassC.ar(snd, 0.5, 0.05, 0.3)]*amp);
}).send;