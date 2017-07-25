
~string_low_vca_control_out = Bus.control(s, 1);
~string_low_vcf_control_out = Bus.control(s, 1);
~string_low_synth = Synth("mono_eStrings",addAction: \addToTail);
~string_low_synth.set(\fenvIn,~string_low_vcf_control_out);
~string_low_synth.set(\vcaIn,~string_low_vca_control_out);
~string_low_synth.set(\amp,2);
~string_low_synth.set(\lagtime,0.66);

~myadsr = MyADSR.new;
~myadsr.init;
~myadsr.attack = 2.0;
~myadsr.decay = 4.0;
~myadsr.sustain = 0.4;
~myadsr.release = 1.0;

~myasr = MyADSR.new;
~myasr.init;
~myasr.attack = 1.0;
~myasr.decay = 4;
~myasr.sustain = 0.8;
~myasr.release = 1.0;

SynthDef(\stringLow, {arg num = 60,gate = 1;
    var env = Env.asr(0,1,0);
    var trig = EnvGen.kr(env, gate,doneAction:2);
    SendReply.kr(trig, '/stringLow', num);
  }).add;

OSCdef(\stringLow, { |m|

      var num = m[3].asInteger;

    ~string_low_synth.set(\freq,num.midicps);
    ~stringLow_env  = Synth("myADSR",addAction: \addToHead);
    ~stringLow_env.set(\out,~string_low_vca_control_out);
    ~myadsr.setADSR(~stringLow_env);

    ~stringLow_fenv = Synth("myADSR",addAction: \addToHead);
    ~stringLow_fenv.set(\out,~string_low_vcf_control_out);
    ~myasr.setADSR(~stringLow_fenv);

    ~stringLow_fenv.set(\gate,1);
    ~stringLow_env.set(\gate,1);
  }, '/stringLow');

~channel0 = {arg num, vel = 1;
	     var ret;
	     num.postln;
	     ret = Synth("FMPiano");
	     ret.set(\freq,num.midicps);
	     ret.set(\gate,1);
	     ret.set(\amp,0.8);
	     //      ret.set(\dur,0.45);
	     ret;
};

~channel1 = {arg num, vel = 1;
	     var ret;
	     num.postln;
	     ret = Synth("vangelis");
	     ret.set(\freq,num.midicps);
	     ret.set(\gate,1);
	     ret.set(\amp,0.20);
	     ret;
};

~channel2 = {arg num, vel = 1;
	     var ret;
	     num.postln;
	     ret = Synth("stringLow");
	     ret.set(\num,num);
	     ret.set(\gate,1);
	     ret;
};

~channel2off = {arg num, vel = 1;
		var ret = nil;
		~stringLow_fenv.set(\gate,0);
		~stringLow_env.set(\gate,0);
		ret;
};

~channel3 = {arg num, vel = 1;
	     var ret;
	     // num.postln;
	     ret = Synth("eStrings");
	     ret.set(\freq,num.midicps);
	     ret.set(\gate,1);
	     ret.set(\amp,2.5);
	     ret.set(\attack,2);

	     ret;
};

~channel4 = {arg num, vel = 1;
	     var ret;
	     num.postln;
	     ret = Synth("eStrings");
	     ret.set(\freq,num.midicps);
	     ret.set(\gate,1);
	     ret.set(\amp,2.5);
	     ret.set(\attack,2);
	     ret.set(\decay,3);
	     ret.set(\sustain,0.3);
	     ret.set(\release,0.40);
	     ret;
};



~channel5 = {arg num, vel = 1;

	     var ret;
	     num.postln;
	     ret = Synth("vangelis");
	     ret.set(\freq,num.midicps);
	     ret.set(\gate,1);
	     ret.set(\amp,0.12);
	     ret;
};

~channel6 = {arg num, vel = 1;

	     var ret;
	     num.postln;
	     ret = Synth("FMdarkpad");
	     ret.set(\freq,num.midicps);
	     ret.set(\gate,1);
	     ret.set(\amp,0.25);
	     ret.set(\attack,2);
	     ret;
};
