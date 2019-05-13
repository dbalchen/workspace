/*
** mono_eCello
*/


"/home/dbalchen/workspace/SuperCollider/makeWaveTable.sc".load;
"/home/dbalchen/Music/song7/include/synths/envelopes.sc".load;

SynthDef("mono_eCello", {
	arg ss, freq = 55, out = 0, amp = 0.35, lagtime = 0, idx = 0.25,
	vcaIn = 9999, vcfIn = 9999,gate = 0,bend = 0,iq = 1.5,
	aoc = 1, gain = 0.3, cutoff = 12500,hpf = 128,
	spread = 0.2, balance = 0;

	var sig, env, fenv,freq2;

	fenv = In.kr(vcfIn);
	fenv = aoc*((fenv - 1) + 1);

	freq = Lag.kr(freq,lagtime);

	freq2 = {freq *  LFNoise2.kr(2.5,0.01,1)}!3;

//	sig = VOsc.ar(ss+idx,freq,0) + (0.175*SawDPW.ar(freq,0.20));

	sig = VOsc3.ar(ss+idx, freq+[0,1],freq+[0.37,1.1],freq+[0.43, -0.29], 0.3);

	sig = sig + (0.175*SawDPW.ar(freq2,0.20));

	sig = MoogFF.ar
	(
		sig,
		cutoff*fenv,
		gain
	);

	sig = sig*((In.kr(vcaIn) - 1) + 1);

	sig = HPF.ar(sig,hpf);

	//sig = BPF.ar(sig,freq,iq);

	sig = LeakDC.ar(sig);

	sig = Splay.ar(sig,spread,center:balance);

	Out.ar(out,sig * amp);

}).send(s);


/*
*** mono_eCello midi setup
*/


~cellowavetables.free;
~cellowavetables =  ~fileList.value("/home/dbalchen/Music/song7/include/samples/cello/");
~cellowindex = ~wavetables.size;

~cellowavebuff = ~loadWaveTables.value(~cellowavetables);


~mono_eCello = Synth("mono_eCello",addAction: \addToTail);
~mono_eCello.set(\cutoff,12500);
~mono_eCello.set(\hpf,42);
~mono_eCello.set(\aoc,0.3);
~mono_eCello.set(\ss,~cellowavebuff);
~mono_eCello.set(\idx,0.6);
~mono_eCello.set(\iq,0.5);
~mono_eCello.set(\amp,0.25);
~mono_eCello.set(\lagtime, 0.1);


~mono_eCello_vca_control_in = Bus.control(s, 1);
~mono_eCello_vcf_control_in = Bus.control(s, 1);

~mono_eCello.set(\vcfIn,~mono_eCello_vcf_control_in);
~mono_eCello.set(\vcaIn,~mono_eCello_vca_control_in);

~mono_eCello_vca_envelope = MyADSR.new;
~mono_eCello_vca_envelope.init;
~mono_eCello_vca_envelope.attack = 1.720;
~mono_eCello_vca_envelope.decay = 2.5;
~mono_eCello_vca_envelope.sustain = 0.4;
~mono_eCello_vca_envelope.release = 0.5;

~mono_eCello_vcf_envelope = MyADSR.new;
~mono_eCello_vcf_envelope.init;
~mono_eCello_vcf_envelope.attack = 1.720;
~mono_eCello_vcf_envelope.decay = 1.5;
~mono_eCello_vcf_envelope.sustain = 0.4;
~mono_eCello_vcf_envelope.release = 0.5;


~channel2 = {arg num, vel = 1;
	var ret,tidx;

	tidx = (~wavetables.size/120)* num;
	~mono_eCello.set(\freq,num.midicps);
	~mono_eCello.set(\idx,tidx);

	~mono_eCello_fenv = Synth("myADSRk",addAction: \addToHead);
	~mono_eCello_fenv.set(\out,~mono_eCello_vcf_control_in);
	~mono_eCello_vcf_envelope.setADSR(~mono_eCello_fenv);

	~mono_eCello_env  = Synth("myADSRk",addAction: \addToHead);
	~mono_eCello_env.set(\out,~mono_eCello_vca_control_in);
	~mono_eCello_vca_envelope.setADSR(~mono_eCello_env);

	~mono_eCello_env.set(\gate,1);
	~mono_eCello_fenv.set(\gate,1);
	~mono_eCello.set(\gate,1);

};

~channel2off = {arg num, vel = 1;
	var ret = nil,tdx = 0;

	~mono_eCello_env.set(\gate,0);
	~mono_eCello_fenv.set(\gate,0);
};

