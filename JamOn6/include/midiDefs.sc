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


SynthDef(\stringMid, {arg num = 60,gate = 0;
	var env = Env.asr(0,1,0);
	var trig = EnvGen.kr(env, gate,doneAction:2);
	SendReply.kr(trig, '/stringMid', num);
}).add;

OSCdef(\stringMid, { |m|

	var num = m[3].asInteger;
	~ret10 = ~midiStrings.value(~string2_firmus,num,2);
	~ret11 = ~eSampler.value(~string2_firmusB,~violinsounds,~violinTemplate,num);

}, '/stringMid');


SynthDef(\stringHi, {arg num = 60,gate = 0;
	var env = Env.asr(0,1,0);
	var trig = EnvGen.kr(env, gate,doneAction:2);
	SendReply.kr(trig, '/stringHi', num);
}).add;

OSCdef(\stringHi, { |m|

	var num = m[3].asInteger;
	~ret12 = ~mididStrings.value(~string3_firmus,num,3);
	~ret13 = ~eSampler.value(~string3_firmusB,~violinsounds,~violinTemplate,num);

}, '/stringHi');


SynthDef(\stringLow, {arg num = 60,gate = 0;
	var env = Env.asr(0,1,0);
	var trig = EnvGen.kr(env, gate,doneAction:2);
	SendReply.kr(trig, '/stringLow', num);
}).add;

OSCdef(\stringLow, { |m|

	var num = m[3].asInteger;
	~ret14.set(\gate,0);
	~ret14 = ~midicStrings.value(~string1_firmus,num,1);
	~ret15 = ~eSampler.value(~string1_firmusB,~cellosounds,~celloTemplate,num);

}, '/stringLow');


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
	~ret0  = Synth("env0",addAction: \addToHead);
	~ret0.set(\out,~envout);
	~ret0.set(\gate,1);

	~ret1  = Synth("env1",addAction: \addToHead);
	~ret1.set(\out,~envout1);
	~ret1.set(\gate,1);

	~ret2  = Synth("env0",addAction: \addToHead);
	~ret2.set(\out,~env2out);
	~ret2.set(\gate,1);

	~ret3  = Synth("env1",addAction: \addToHead);
	~ret3.set(\out,~env2out1);
	~ret3.set(\gate,1);

	~ret4 = Synth("Sine",addAction: \addToHead);
	~ret4.set(\out,~sine1Out);
	~ret4.set(\amp,0.5);
	~ret4.set(\gate,1);

	~ret5  = Synth("myADSR",addAction: \addToHead);
	~ret5.set(\out,~adsr2Out);
	~myadsr2.setADSR(~ret5);
	~ret5.set(\gate,1);

}, '/mainClock');


~channel0 = {arg num, vel = 1;
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

~channel1 = {arg num, vel = 1;
	var ret;
//	ret = ~midicStrings.value(~string1_firmus,num,1);
	ret = Synth(\stringLow,addAction: \addToTail);
	ret.set(\num,num);
	ret.set(\gate,1);
	ret;
};

~channel1off = {arg num, vel = 1;
	var ret = nil;
	~ret14.set(\gate,0);
	~ret14b.set(\gate,0);
	~ret15.set(\gate,0);
	ret;
};

~channel2 = {arg num, vel = 1;
	var ret;

	ret = Synth(\stringMid);
	ret.set(\num,num);
	ret.set(\gate,1);
	ret;
};

~channel2off = {arg num, vel = 1;
	var ret = nil;
	~ret10.set(\gate,0);
	~ret11.set(\gate,0);
	ret;
};

~channel3 = {arg num, vel = 1;
	var ret;
	ret = Synth(\stringHi);
	ret.set(\num,num);
	ret.set(\gate,1);
	ret;
};

~channel3off = {arg num, vel = 1;
	var ret = nil;
	~ret12.set(\gate,0);
	~ret13.set(\gate,0);
	ret;
};

~channel9 = {arg num, vel = 1;
	var ret;

	ret = Synth(\mainClock);
	ret.set(\num,23);
	ret.set(\gate,1);

	ret;

};

~channel9off = {arg num, vel = 1;
	var ret = nil;

		~ret0.set(\gate,0);
	~ret1.set(\gate,0);
	~ret2.set(\gate,0);
	~ret3.set(\gate,0);
	~ret4.set(\gate,0);
	~ret5.set(\gate,0);

};


~channel10 = {arg num, vel = 1;
	var ret = nil;

	ret = Synth(\cfClock);
	ret.set(\num,num);
	ret.set(\gate,1);

	ret;
};

~channel10off = {arg num, vel = 1;
	var ret = nil;
	~ret6.set(\gate,0);
	ret;
};