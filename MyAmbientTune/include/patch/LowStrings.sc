/*
~string_low_vca_envelope.gui;
~string_low_vcf_envelope.gui;
*/


~string_low_synth = Synth("mono_eStrings",addAction: \addToTail);
~string_low_synth.set(\cutoff,7950);
~string_low_synth.set(\gain,1.2);
~string_low_synth.set(\aoc,0.2);
~string_low_synth.set(\hpf,175);
~string_low_vca_control_in = Bus.control(s, 1);
~string_low_vcf_control_in = Bus.control(s, 1);


~string_low_synth.set(\fenvIn,~string_low_vcf_control_in);
~string_low_synth.set(\vcaIn,~string_low_vca_control_in);


~string_low_vca_envelope = MyADSR.new;
~string_low_vcf_envelope = MyADSR.new;
~string_low_vca_envelope.init;
~string_low_vcf_envelope.init;

~lowStringsEnvInit = {
	~string_low_vca_envelope.attack = 1.0;
	~string_low_vca_envelope.decay = 0.5;
	~string_low_vca_envelope.sustain = 0.5;
	~string_low_vca_envelope.release = 0.4;

	~string_low_vcf_envelope.attack = 3.5;
	~string_low_vcf_envelope.decay = 0.5;
	~string_low_vcf_envelope.sustain = 0.5;
	~string_low_vcf_envelope.release = 0.5;
};

~lowStringsEnvInit.value();


SynthDef(\stringLow, {arg num = 60,gate = 1;
	var env = Env.asr(0,1,0);
	var trig = EnvGen.kr(env, gate,doneAction:2);
	SendReply.kr(trig, '/stringLow', num);
}).add;

OSCdef(\stringLow, { |m|

	var num = m[3].asInteger;

	~string_low_synth.set(\freq,num.midicps);
	~string_low_synth.set(\lagtime,	~lowStrings.notes.lag);
	~string_low_synth.set(\amp,	~lowStrings.amp);
	~string_low_synth.set(\balance,	~lowStrings.balance);
	~string_low_synth.set(\release,~string_low_vca_envelope.release);


	~stringLow_fenv = Synth("myADSRk",addAction: \addToHead);
	~stringLow_fenv.set(\out,~string_low_vcf_control_in);
	~string_low_vcf_envelope.setADSR(~stringLow_fenv);

	~stringLow_env  = Synth("myADSRk",addAction: \addToHead);
	~string_low_vca_envelope.setADSR(~stringLow_env);
	~stringLow_env.set(\out,~string_low_vca_control_in);

	~stringLow_env.set(\gate,1);
	~stringLow_fenv.set(\gate,1);
	~string_low_synth.set(\gate,1);


}, '/stringLow');


