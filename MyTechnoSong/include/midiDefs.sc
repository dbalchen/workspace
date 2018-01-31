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



~channel0 = {arg num, vel = 1;
	     var ret;
	     num.postln;

	     ret = Synth("stringLow");
	     ret.set(\num,num);
	     ret.set(\gate,1);

	     ret;
};

~channel0off = {arg num, vel = 1;
		var ret = nil;

		~stringLow_env.set(\gate,0);
		~stringLow_fenv.set(\gate,0);
		~string_low_synth.set(\gate,0);
		ret;
};


~channel1 = {arg num, vel = 1;
	     var ret;
	     num.postln;

	     ret = Synth("Esampler");
	     ret.set(\gate,0);

	     ~celloTemplate.value(ret,num,~cellosounds);
	     ret.set(\amp,~cello.amp);
	     ret.set(\balance,~cello.balance);

	     ret.set(\attack,0.5);
	     ret.set(\decay,3);
	     ret.set(\sustain,0.3);
	     ret.set(\release,0.8);
	     ret.set(\gate,1);
	     ret;
};

~channel2 = {arg num, vel = 1;
	     var ret;
	     num.postln;

	     ret = Synth("Esampler");
	     ret.set(\gate,0);

	     ~violaTemplate.value(ret,num,~violasounds);
	     ret.set(\amp,~viola.amp);
	     ret.set(\balance,~viola.balance);

	     ret.set(\attack,0.5);
	     ret.set(\decay,3);
	     ret.set(\sustain,0.3);
	     ret.set(\release,0.8);
	     ret.set(\gate,1);
	     ret;
};


~channel3 = {arg num, vel = 1;
	     var ret;
	     num.postln;

	     ret = Synth("Esampler");
	     ret.set(\gate,0);

	     ~violinTemplate.value(ret,num,~violinsounds);
	     ret.set(\amp,~violin.amp);
	     ret.set(\balance,~violin.balance);

	     ret.set(\attack,0.5);
	     ret.set(\decay,3);
	     ret.set(\sustain,0.3);
	     ret.set(\release,0.8);
	     ret.set(\gate,1);
	     ret;
};


SynthDef(\kickClock, {arg num = 60,gate = 0;
    var env = Env.asr(0,1,0);
    var trig = EnvGen.kr(env, gate,doneAction:2);
    SendReply.kr(trig, '/kickClock', num);
  }).add;

OSCdef(\kickClock, { |m|
      var aa,aa1;

    aa  = Synth("env0",addAction: \addToHead);
    aa.set(\out,~envout0);
    aa.set(\gate,1);

    aa1 = Synth("env1",addAction: \addToHead);
    aa1.set(\out,~envout1);
    aa1.set(\gate,1);

  }, '/kickClock');


~channel9 = {arg num, vel = 1;
	     var ret;

	     ret = Synth(\kickClock);
	     ret.set(\gate,1);

	     ret;

};


~channel10 = {arg num, vel = 1;
	      var ret;

	      num = num.midicps;
	      ~pulseSaw.set(\freq, num);
	      ~pulseSaw.set(\lagLev,0.5);
	      ~pulseSaw2.set(\freq, num);
	      ~noise.set(\freq,num/2);
	      ~sine.set(\freq, num/2);


	      ~ret0 = Synth("env2",addAction: \addToHead);
	      ~ret0.set(\out,~envout2);
	      ~ret0.set(\gate,1);

	      ret  = Synth("myADSR",addAction: \addToHead);
	      ret.set(\out,~adsrout);
	      ~myadsr.setADSR(ret);
	      ret.set(\gate,1);
	      ret;
};

~channel10off = {arg num, vel = 1;
		 var ret = nil;
		 ~ret0.set(\gate,0);
};


~turndown1 = {
  arg vol,cc,chan,src;
  vol = vol/127;
  vol.postln;

  if((chan == 0), {

      ~lowStrings.amp = vol;
    });

  if((chan == 1), {
      ~cello.amp = vol;
    });

  if((chan == 2), {

     ~viola.amp = vol;

    });

  if((chan == 3), {

      ~violin.amp = vol;
    });

  if((chan == 4), {


    });

  if((chan == 5), {


    });

  if((chan == 6), {


    });

  if((chan == 7), {


    });

  if((chan == 8), {


    });
  if((chan == 9), {


    });

  if((chan == 10), {

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

      ~lowStrings.balance = vol;

    });

  if((chan == 1), {
      
      ~cello.balance = vol;
      
    });

  if((chan == 2), {

      ~viola.balance = vol;
      
    });

  if((chan == 3), {
      
      ~violin.balance = vol;
      
    });

  if((chan == 4), {

    });

  if((chan == 5), {


    });

  if((chan == 6), {


    });

  if((chan == 7), {


    });

  if((chan == 8), {


    });
  if((chan == 9), {


    });

  if((chan == 10), {
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


