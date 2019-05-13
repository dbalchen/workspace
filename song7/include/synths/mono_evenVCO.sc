/*
** mono_evenVCO
*/


"/home/dbalchen/workspace/SuperCollider/makeWaveTable.sc".load;
"/home/dbalchen/Music/song7/include/synths/envelopes.sc".load;

SynthDef("mono_evenVCO", {
	arg ss, freq = 55, out = 0, amp = 0.45, lagtime = 0, idx = 0.25,
	vcaIn = 9999, vcfIn = 9999,gate = 0,bend = 0,
	aoc = 1, gain = 1.3, cutoff = 9500,hpf = 256,
	spread = 1, balance = 0;

	var sig, env, fenv;

	fenv = In.kr(vcfIn);
	fenv = aoc*((fenv - 1) + 1);

	freq = Lag.kr(freq,lagtime);
	freq = {freq *  LFNoise2.kr(2.5,0.01,1)}!8;

	sig = VOsc.ar(ss + idx,freq,0);

	sig = MoogFF.ar
	(
		sig,
		cutoff*fenv,
		gain
	);

	sig = sig*((In.kr(vcaIn) - 1) + 1);

	sig = HPF.ar(sig,hpf);

	sig = LeakDC.ar(sig);

	sig = Splay.ar(sig,spread,center:balance);

	Out.ar(out,sig * amp);

}).send(s);


/*
*** mono_evenVCO midi setup
*/

~wavetables.free;
~wavetables = ~fileList.value("/home/dbalchen/Music/song7/include/samples/evenVCO");
~windex = ~wavetables.size;

~wavebuff = ~loadWaveTables.value(~wavetables);



~mono_evenVCO = Synth("mono_evenVCO",addAction: \addToTail);
~mono_evenVCO.set(\cutoff,7500);
~mono_evenVCO.set(\hpf,220);
~mono_evenVCO.set(\aoc,0.6);
~mono_evenVCO.set(\ss,~wavebuff);
~mono_evenVCO.set(\windex, ~windex);
~mono_evenVCO.set(\idx,0.6);
~mono_evenVCO.set(\lagtime, 0.05);


~mono_evenVCO_vca_control_in = Bus.control(s, 1);
~mono_evenVCO_vcf_control_in = Bus.control(s, 1);

~mono_evenVCO.set(\vcfIn,~mono_evenVCO_vcf_control_in);
~mono_evenVCO.set(\vcaIn,~mono_evenVCO_vca_control_in);

~mono_evenVCO_vca_envelope = MyADSR.new;
~mono_evenVCO_vca_envelope.init;
~mono_evenVCO_vca_envelope.attack = 1.0;
~mono_evenVCO_vca_envelope.decay = 2.5;
~mono_evenVCO_vca_envelope.sustain = 0.4;
~mono_evenVCO_vca_envelope.release = 0.5;

~mono_evenVCO_vcf_envelope = MyADSR.new;
~mono_evenVCO_vcf_envelope.init;
~mono_evenVCO_vcf_envelope.attack = 1.0;
~mono_evenVCO_vcf_envelope.decay = 2.5;
~mono_evenVCO_vcf_envelope.sustain = 0.4;
~mono_evenVCO_vcf_envelope.release = 0.5;


~channel0 = {arg num, vel = 1;
	var ret,tidx;

	tidx = (~wavetables.size/120)* num;
	~mono_evenVCO.set(\freq,num.midicps);
	~mono_evenVCO.set(\idx,tidx);

	~mono_evenVCO_fenv = Synth("myADSRk",addAction: \addToHead);
	~mono_evenVCO_fenv.set(\out,~mono_evenVCO_vcf_control_in);
	~mono_evenVCO_vcf_envelope.setADSR(~mono_evenVCO_fenv);

	~mono_evenVCO_env  = Synth("myADSRk",addAction: \addToHead);
	~mono_evenVCO_env.set(\out,~mono_evenVCO_vca_control_in);
	~mono_evenVCO_vca_envelope.setADSR(~mono_evenVCO_env);

	~mono_evenVCO_env.set(\gate,1);
	~mono_evenVCO_fenv.set(\gate,1);
	~mono_evenVCO.set(\gate,1);

};

~channel0off = {arg num, vel = 1;
	var ret = nil,tdx = 0;

	~mono_evenVCO_env.set(\gate,0);
	~mono_evenVCO_fenv.set(\gate,0);
};

