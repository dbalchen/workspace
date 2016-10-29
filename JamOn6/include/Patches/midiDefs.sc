SynthDef(\mainClock, {arg num = 60,gate = 0;
	var env = Env.asr(0,1,0);
	var trig = EnvGen.kr(env, gate,doneAction:2);
	SendReply.kr(trig, '/mainClock', num);
}).add;


SynthDef(\cfClock, {arg num = 60,gate = 0;
	var env = Env.asr(0,1,0);
	var trig = EnvGen.kr(env, gate,doneAction:2);
	SendReply.kr(trig, '/cfClock', num);
}).add;

OSCdef(\cfClock, { |m|
	m[3].postln;
	//var num = m[3];
	~noise1.set(\freq,m[3].midicps);
	~pulse1.set(\freq,(m[3] - 24).midicps);
	~ret6.set(\gate,0);
	~ret6  = Synth("myASR",addAction: \addToHead);
	~ret6.set(\out,~asrOut);
	~ret6.set(\release,0.02);
	~ret6.set(\attack,16);
	~ret6.set(\cutoff,10000);
	~ret6.set(\aoc,1.0);
	~ret6.set(\gate,1);
}, '/cfClock');


OSCdef(\mainClock, { |m|
	m.postln;
	~ret0.set(\gate,0);
	~ret0  = Synth("env0",addAction: \addToHead);
	~ret0.set(\out,~envout);
	~ret0.set(\gate,1);

	~ret1.set(\gate,0);
	~ret1  = Synth("env1",addAction: \addToHead);
	~ret1.set(\out,~envout1);
	~ret1.set(\gate,1);

	~ret2.set(\gate,0);
	~ret2  = Synth("env0",addAction: \addToHead);
	~ret2.set(\out,~env2out);
	~ret2.set(\gate,1);

	~ret3.set(\gate,0);
	~ret3  = Synth("env1",addAction: \addToHead);
	~ret3.set(\out,~env2out1);
	~ret3.set(\gate,1);

	~ret4.set(\gate,0);
	~ret4 = Synth("Sine",addAction: \addToHead);
	~ret4.set(\out,~sine1Out);
	~ret4.set(\amp,0.5);
	~ret4.set(\gate,1);

	~ret5.set(\gate,0);
	~ret5  = Synth("myADSR",addAction: \addToHead);
	~ret5.set(\out,~adsr2Out);
	~myadsr2.setADSR(~ret5);
	~ret5.set(\gate,1);

}, '/mainClock');


~channel0 = {arg num, vel = 1;
	var ret;
	ret = ~midiFMdarkpad1.value(~pad_firmus,num);
	ret;
};

~channel1 = {arg num, vel = 1;
	var ret;
	ret = ~midiStrings.value(~string1_firmus,num,1);
	ret;
};

~channel2 = {arg num, vel = 1;
	var ret;
	ret = ~midiStrings.value(~string2_firmus,num,2);
	ret;
};

~channel3 = {arg num, vel = 1;
	var ret;

	ret = Synth("tbell",addAction: \addToHead);
	ret.set(\freq,num.midicps);
	ret.set(\decayscale,~dcs);
	ret.set(\fscale,~fscale);
	ret.set(\release,~release);
	ret.set(\attack,~attack);
	ret.set(\amp,~amp);
	ret.set(\out,~bellOut);
	ret.set(\gate,1);
	ret;
};



~channel9 = {arg num, vel = 1;
	var ret;

	ret = Synth(\mainClock);
	ret.set(\num,23);
	ret.set(\gate,1);

	ret;

};

~channel10 = {arg num, vel = 1;
	var ret = nil;

	ret = Synth(\cfClock);
	ret.set(\num,num);
	ret.set(\gate,1);

	ret;
};
