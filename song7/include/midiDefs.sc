// Low String Setup

~string_low_synth = Synth("mono_eStrings",addAction: \addToTail);

~string_low_vca_control_in = Bus.control(s, 1);
~string_low_vcf_control_in = Bus.control(s, 1);


~string_low_synth.set(\fenvIn,~string_low_vcf_control_in);
~string_low_synth.set(\vcaIn,~string_low_vca_control_in);


~string_low_vca_envelope = MyADSR.new;
~string_low_vca_envelope.init;
~string_low_vca_envelope.attack = 2.0;
~string_low_vca_envelope.decay = 4.0;
~string_low_vca_envelope.sustain = 0.4;
~string_low_vca_envelope.release = 0.9;

~string_low_vcf_envelope = MyADSR.new;
~string_low_vcf_envelope.init;
~string_low_vcf_envelope.attack = 2.0;
~string_low_vcf_envelope.decay = 4;
~string_low_vcf_envelope.sustain = 0.8;
~string_low_vcf_envelope.release = 0.9;

// Bell Setup
~belladsr = MyADSR.new;
~belladsr.init;
~belladsr.attack = 0;
~belladsr.decay = 120.25;
~belladsr.sustain = 0.2;
~belladsr.release = 0.5;

~belladsr6 = MyADSR.new;
~belladsr6.init;
~belladsr6.attack = 0;
~belladsr6.decay = 0.25;
~belladsr6.sustain = 0.5;
~belladsr6.release = 0.5;

~saxadsr = MyADSR.new;
~saxadsr.attack = 0.20;
~saxadsr.decay = 1.0;
~saxadsr.sustain = 0.5;
~saxadsr.release = 0.1;

~saxadsrf = MyADSR.new;
~saxadsrf.attack = 0.10;
~saxadsrf.decay =  1.0;
~saxadsrf.sustain = 0.5;
~saxadsrf.release = 0.1;

SynthDef(\stringLow, {arg num = 60,gate = 1;
	var env = Env.asr(0,1,0);
	var trig = EnvGen.kr(env, gate,doneAction:2);
	SendReply.kr(trig, '/stringLow', num);
}).add;

OSCdef(\stringLow, { |m|

	var num = m[3].asInteger;

	~string_low_synth.set(\freq,num.midicps);
	~string_low_synth.set(\lagtime,	0.5);
	~string_low_synth.set(\amp,~track2.amp);
	~string_low_synth.set(\balance,~track2.balance);
	~string_low_synth.set(\release,~string_low_vca_envelope.release);


	~stringLow_fenv = Synth("myADSR",addAction: \addToHead);
	~stringLow_fenv.set(\out,~string_low_vcf_control_in);
	~string_low_vcf_envelope.setADSR(~stringLow_fenv);

	~stringLow_env  = Synth("myADSR",addAction: \addToHead);
	~string_low_vca_envelope.setADSR(~stringLow_env);
	~stringLow_env.set(\out,~string_low_vca_control_in);

	~stringLow_env.set(\gate,1);
	~stringLow_fenv.set(\gate,1);
	~string_low_synth.set(\gate,1);


}, '/stringLow');

~channel0 = {arg num, vel = 1;
	var ret;
	num.postln;
	ret = Synth("Tbell");
	ret.set(\freq,num.midicps);
	ret.set(\amp,~track0.amp);
	ret.set(\balance,~track0.balance);
	ret.set(\out,~track0.out);
	ret.set(\sing,1);
	~belladsr.setADSR(ret);
	ret.set(\gate,1);
	ret;
};

~channel1 = {arg num, vel = 1;
	var ret;
	num.postln;
	ret = Synth("sadSax");
	ret.set(\freq,num.midicps);
	~saxadsr.setADSR(ret);
	~saxadsrf.setfADSR(ret);
	ret.set(\cutoff,3200);
	ret.set(\amp,~track1.amp);
	ret.set(\balance,~track1.balance);
	ret.set(\gate,1);
	ret;
};

~channel2 = {arg num, vel = 1;
	var ret;
	num.postln;

	ret = Synth("stringLow");
	ret.set(\num,num);
	ret.set(\lag,4.0);
	ret.set(\gate,1);

	ret;
};

~channel2off = {arg num, vel = 1;
	var ret = nil;

	~stringLow_env.set(\gate,0);
	~stringLow_fenv.set(\gate,0);
	~string_low_synth.set(\gate,0);
	ret;
};

~channel3 = {arg num, vel = 1;
	var ret;
	// num.postln;
	ret = Synth("eStrings");
	ret.set(\freq,num.midicps);
	ret.set(\amp,~track3.amp);
	ret.set(\balance,~track3.balance);
	ret.set(\attack,0.5);
	ret.set(\release,0.4);
	ret.set(\gate,1);
	ret;
};

~channel4 = {arg num, vel = 1;
	var ret;
	num.postln;

	ret = Synth("Esampler");
	ret.set(\gate,0);

	~violinTemplate.value(ret,num,~violinsounds);
	ret.set(\amp,~track4.amp);
	ret.set(\balance,~track4.balance);

	ret.set(\attack,0.5);
	ret.set(\decay,3);
	ret.set(\sustain,0.3);
	ret.set(\release,0.8);
	ret.set(\gate,1);
	ret;
};


~channel5 = {arg num, vel = 1;

	var ret;
	num.postln;
	ret = Synth("FMdarkpad");
	ret.set(\freq,num.midicps);

	ret.set(\amp,~track5.amp);
	ret.set(\balance,~track5.balance);
	ret.set(\attack,2);
	ret.set(\gate,1);
	ret;
};


~turndown1 = {
	arg vol,cc,chan,src;
	vol = vol/127;
	vol.postln;

	if((chan == 0), {
		~track0.amp = vol;

	});

	if((chan == 1), {

		~track1.amp = vol;
	});

	if((chan == 2), {

		~track2.amp = vol;

	});

	if((chan == 3), {
		~track3.amp = vol;

	});

	if((chan == 4), {

		~track4.amp = vol;
	});

	if((chan == 5), {
		~track5.amp = vol;

	});

	if((chan == 6), {
		~track6.amp = vol;

	});

	if((chan == 7), {


	});

	if((chan == 8), {


	});
	if((chan == 9), {
		~track9.amp = vol;

	});

	if((chan == 10), {
		~track10.amp = vol;
	});

	if((chan == 11), {


	});

	if((chan == 12), {

	});

	if((chan == 13), {


	});

	if((chan == 14), {


	});

	if((chan == 15), {


	});


};

~volCC.free;
~volCC = MIDIdef.cc(\volume, ~turndown1, 7);

~pan1 = {
	arg vol,cc,chan,src;
	vol = (2*(vol/127))-1;

	vol.postln;

	if((chan == 0), {
		~track0.balance = vol;

	});

	if((chan == 1), {

		~track1.balance = vol;
	});

	if((chan == 2), {

		~track2.balance = vol;

	});

	if((chan == 3), {
		~track3.balance = vol;

	});

	if((chan == 4), {

		~track4.balance = vol;
	});

	if((chan == 5), {
		~track5.balance = vol;

	});

	if((chan == 6), {
		~track6.balance = vol;

	});

	if((chan == 7), {


	});

	if((chan == 8), {


	});
	if((chan == 9), {
		~track9.balance = vol;

	});

	if((chan == 10), {
		~track10.balance = vol;
	});

	if((chan == 11), {


	});

	if((chan == 12), {

	});

	if((chan == 13), {


	});

	if((chan == 14), {


	});

	if((chan == 15), {


	});


};

~ballCC.free;
~balCC = MIDIdef.cc(\pan, ~pan1,10); // match cc 1


