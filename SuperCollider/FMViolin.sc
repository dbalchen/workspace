// Example - Variation of Schottstaedts FM "Violin"
//
// ins time duration pitch amp ampfun fm-index fm1-rat fm2-rat fm3-rat noise-amount
// locate fmfun pitchfun noisefunc

(	       
SynthDef(\fmviolin, {
	arg dur = 1, fundfreq = 440, amp = 0.25, fmindex = 50, fm1rat = 1, fm2rat = 3,
	    fm3rat = 4, noiseamt = 0.1, locate = 0.5, envtab = 0, fmtab = 1;

	var env, modfreq1, modfreq2, modfreq3, index1, index2, index3, dev1, dev2, dev3, noisefreq, 
		noiseamp, envdur, chan1, chan2, vib, randvib, vibrate, noise, noiseenv, fmenv, pitchenv,
		mod1, mod2, mod3, modall, car, sig, sig1, sig2;
		
	modfreq1 = fundfreq * fm1rat;
	modfreq2 = fundfreq * fm2rat;
	modfreq3 = fundfreq * fm3rat;
	index1 = (7.5 / fundfreq.log) * fmindex;
	index2 = (15.0 / fundfreq.sqrt) * fmindex;
	index3 = (1.25 / fundfreq.sqrt) * fmindex;
	dev1 = index1 * fundfreq;
	dev2 = index2 * fundfreq;
	dev3 = index3 * fundfreq;
	amp = amp * 0.25;
	noisefreq = 1000;
	noiseamp = noiseamt * amp;
	chan1 = locate.sqrt;
	chan2 = (1 - locate).sqrt;
	
	// Vibrato Section
	
	randvib = LFNoise1.kr(5, 0.0075);
	vibrate = EnvGen.kr(
		Env([1, 3.5, 4.5, 1], [0.5, dur - 1.0, 0.5], \exp), 
		doneAction: 0);
	vib = SinOsc.ar(vibrate, 0, randvib);
	vib = vib + 1;

	// Noise
	// In the book version of the FM-violin, the noise is
	// added to the output signal to simulate bow noise at
	// the beginning of a note. In this instrument the
	// noise is part of the modulation signal creating a
	// band of noise around the carrier frequency.
	
	noiseenv = EnvGen.kr(
		Env([1, 0.001, 0.001], [dur * 0.25, dur * 0.75], \exp),
		doneAction: 2);
	noise = LFNoise1.ar(noisefreq, noiseenv * noiseamp);
	
	env = Osc.kr(envtab, dur.reciprocal, 0, 1);
	fmenv = Osc.kr(fmtab, dur.reciprocal, 0, 1);
	pitchenv = XLine.kr(1, 1.001, dur);

	// Modulator section
	
	mod1 = SinOsc.ar(modfreq1 * pitchenv * vib, 0, dev1 * fmenv);
	mod2 = SinOsc.ar(modfreq2 * pitchenv * vib, 0, dev2 * fmenv);
	mod3 = SinOsc.ar(modfreq3 * pitchenv * vib, 0, dev3 * fmenv);

	modall = mod1 + mod2 + mod3 + noise;

	car = SinOsc.ar((fundfreq + modall) * pitchenv * vib, 0, amp);
	
	sig = car * env;

	// Make the signal stereo and place somewhere between the channels.
	sig1 = sig * chan1;
	sig2 = sig * chan2;
	Out.ar(0, [sig1, sig2]);
	}).load(s);
)



s = Server.internal.boot;

// amp and freq envelopes are predefined through tables
// table 0 will be envtab, 1 will be fmtab

s.sendBundle(0.1,
	[\b_alloc, 0, 4096], [\b_alloc, 1, 4096],
	[\b_gen, 0, \sine2, 3, 0.5, 1],
	[\b_gen, 1, \sine3, 2, 0.125, 1, 0.25]);
	
Synth(\fmviolin, [\dur, 4, \fundfreq, 334, \fmindex, 3, \fm1rat, 1, \fm2rat, 3, \fm3rat, 4, \noiseamt, 0.1, \locate, 0.5, \envtab, 0, \fmtab, 1]);







