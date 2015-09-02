// =====================================================================
// Oboe
// =====================================================================

"/home/dbalchen/workspace/SuperCollider/makeWaveTable.sc".loadPath;

~oboe = ~makeWav.value("/home/dbalchen/Music/Samples/wavetables/AKWF_oboe/AKWF_oboe_0012.wav");
~oboe2 = ~makeWav.value("/home/dbalchen/Music/Samples/wavetables/AKWF_oboe/AKWF_oboe_0010.wav");
~clar = ~makeWav.value("/home/dbalchen/Music/Samples/wavetables/AKWF_clarinett/AKWF_clarinett_0024.wav");
~cello = ~makeWav.value("/home/dbalchen/Music/Samples/wavetables/AKWF_cello/AKWF_cello_0001.wav");
~saw = ~makeWav.value("/home/dbalchen/Music/Samples/wavetables/AKWF_bw_saw/AKWF_saw_0017.wav");

SynthDef("Oboe", {
    arg ss, freq = 110, out = 0, amp = 0.5, lagt = 0, wrange = 1.5, wfreq = 8, da = 0, gate = 1,
      attack = 0, decay = 0, sustain = 1, release = 0.5, spread = 7,
      fattack = 0.5, fsustain = 1, frelease = 0.5, aoc = 1, gain = 2, cutoff = 5000.00;

    var sig, env, fenv,  wiggle, cent1, cent2;

    cent1 = 2**((spread*0.3333)/1200);
    cent2 = 2**((spread*0.25)/1200);

    env = Env.adsr(attack,decay,sustain,release);

    fenv = Env.asr(fattack,fsustain,frelease, 1,curve: 'sine');
    fenv = EnvGen.kr(fenv, gate,doneAction:da);
    fenv = aoc*(fenv - 1) + 1;

    wiggle = SinOsc.kr(wfreq,mul: wrange);



    //    freq = { freq * LFNoise2.kr(1,0.01,1) }!3; 
    freq = freq + wiggle;

    freq = Lag.kr(freq,lagt);

    sig = Osc.ar(ss,[freq,freq*cent1,freq/cent2],[0,0.1,0.2],mul: EnvGen.kr(env, gate: gate, doneAction:da)) * amp;

    sig = MoogFF.ar
      (
       sig,
       cutoff*fenv,
       gain
       );

    sig = Splay.ar(sig);
 
    Out.ar(out,sig);
	 
  }).store;


SynthDef("multiSaw", {
    arg ss, freq = 110, out = 0, amp = 0.5, lagt = 0, wrange = 1.5, wfreq = 8, da = 0, gate = 1,
      attack = 0, decay = 0, sustain = 1, release = 0.5, spread = 7,
      fattack = 0.5, fsustain = 1, frelease = 0.5, aoc = 1, gain = 2, cutoff = 5000.00;

    var sig, env, fenv,  wiggle, cent1, cent2;

    cent1 = 2**((spread*0.3333)/1200);
    cent2 = 2**((spread*0.25)/1200);

    env = Env.adsr(attack,decay,sustain,release);

    fenv = Env.asr(fattack,fsustain,frelease, 1,curve: 'sine');
    fenv = EnvGen.kr(fenv, gate,doneAction:da);
    fenv = aoc*(fenv - 1) + 1;

    wiggle = SinOsc.kr(wfreq,mul: wrange);

    freq = freq + wiggle;

    freq = Lag.kr(freq,lagt);

    sig = Saw.ar([freq,freq*cent1,freq/cent2],[0,0.1,0.2],mul: EnvGen.kr(env, gate: gate, doneAction:da)) * amp;

    sig = MoogFF.ar
      (
       sig,
       cutoff*fenv,
       gain
       );

    sig = Splay.ar(sig);
 
    Out.ar(out,sig);
	 
  }).store;







/*
  x = Synth("Oboe");
  x = Synth("sosc");
  x = Synth("multiSaw");

  x.set(\ss,~oboe);
  x.set(\ss,~saw);
  x.set(\wfreq,8);
  x.set(\wrange,0.5);

  ~myenv = MyEnv.new;
  ~myenv.init;
  ~myenv.envGui;

  ~myenv.attack = 0.5;
  ~myenv.release = 0.5;
  ~myenv.decay = 1;
  ~myenv.sustain = 0;
  ~myenv.setEnvelope(x);
  x.set(\gate,0);
  x.set(\gate,1);
*/

SynthDef("sosc", {
    arg ss, freq = 110, out = 0, amp = 0.5, lagt = 0, wrange = 1.5, wfreq = 8, da = 0, gate = 1,
      attack = 0, decay = 0, sustain = 1, release = 0.5,
      fattack = 0.5, fsustain = 1, frelease = 0.5, aoc = 1, gain = 2, cutoff = 5000.00;

    var sig, env, fenv,  wiggle;

    env = Env.adsr(attack,decay,sustain,release);

    fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
    fenv = EnvGen.kr(fenv, gate,doneAction:da);
    fenv = aoc*(fenv - 1) + 1;

    wiggle = SinOsc.kr(wfreq,mul: wrange);



    //    freq = { freq * LFNoise2.kr(1,0.01,1) }!3; 
    freq = freq + wiggle;

    freq = Lag.kr(freq,lagt);

    sig = Osc.ar(ss,freq,0,mul: EnvGen.kr(env, gate: gate, levelScale: Rand(0.1,1.0),doneAction:da)) * amp;

    sig = MoogFF.ar
      (
       sig,
       cutoff*fenv,
       gain
       );

	   sig = Splay.ar(sig);
 
    Out.ar(out,sig);
	 
  }).store;





~polySynth = {arg myevents,name,sound;
	      var myTask,x,y, flt, env, poly = 4;

	      myTask = Task({
		  var num,dur,amp,synths,si = 0;
		  synths = Array.newClear(poly);
		  for(0, synths.size - 1,
		    { arg i; 
              var tt;
              tt = Synth(name);
			  tt.set(\gate,0);
			  tt.set(\da,0);
		      synths.put(i,tt); 
		    }
		    );

		  inf.do({ 
		      num = myevents.freq.next;
		      dur = myevents.duration.next;
		      amp = myevents.amp;
		      flt = myevents.filter;
		      env = myevents.envelope;

		      if(num.isMemberOf(Integer),
			{ 
			  {var tt = synths[si % poly];
                si = si + 1;
			    tt.set(\gate,0);
			    flt.setFilter(tt);
			    env.setEnvelope(tt);
			    tt.set(\ss,sound);
			    tt.set(\freq,num.midicps);
				  //                tt.set(\lagt,4);
			    tt.set(\wrange,0);
			    tt.set(\da,0);
			    tt.set(\amp,amp);
			    tt.set(\gate,1);
                tt.set(\out,myevents.out);
			    dur.wait;
			    tt.set(\gate,0);
			  }.fork;

			}, {["rest"].post}); // false action
		      myevents.wait.next.wait;
		    }); 
		}).start};


~monoSynth = {arg myevents,name,sound = nil;
	      var myTask,x,y,flt,env;

	      myTask = Task({
		  var num,dur,amp,lag,wt;
		  var tt = Synth(name);
		  tt.set(\ss,sound);
		  tt.set(\da,0);
		  tt.set(\gate,0);
		  wt = 0;

		  inf.do({ 
		      num = myevents.freq.next;
		      dur = myevents.duration.next;
		      amp = myevents.amp;
		      flt = myevents.filter;
		      env = myevents.envelope;
		      lag = myevents.lag;

		      if(num.isMemberOf(Integer),
			{ 
			  env.setEnvelope(tt);
			  flt.setFilter(tt);
			  tt.set(\freq,num.midicps);
			  tt.set(\amp,amp);
			  tt.set(\lagt,lag);
              tt.set(\out,myevents.out);
			  { tt.set(\gate,1);
			    (dur-0.1).wait;
			    tt.set(\gate,0);
			    0.1.wait;
			  }.fork;

			}, {["rest"].post}); // false action

		      (myevents.wait.next).wait;
		      //		wt = 0.0;

		      //		  tt.set(\gate,0);
		      //   wt.wait;
		    });
		}).start;
};
  




~runEsampler = {arg myevents,sounds,template;
	      var myTask,x,y, flt, env, poly = 4;

	      myTask = Task({
		  var num,dur,amp,synths,si = 0;
		  synths = Array.newClear(poly);
		  for(0, synths.size - 1,
		    { arg i; 
              var tt;
              tt = Synth("Esampler");
			  tt.set(\gate,0);
			  tt.set(\da,0);
		      synths.put(i,tt); 
		    }
		    );

		  inf.do({ 
		      num = myevents.freq.next;
		      dur = myevents.duration.next;
		      amp = myevents.amp;
		      flt = myevents.filter;
		      env = myevents.envelope;

		      if(num.isMemberOf(Integer),
			{ 
			  {var tt = synths[si % poly];
                si = si + 1;
			    tt.set(\gate,0);
			    flt.setFilter(tt);
			    env.setEnvelope(tt);
                template.value(tt,num,sounds);
                tt.set(\midi,num);
			    tt.set(\da,0);
			    tt.set(\amp,amp);
			    tt.set(\gate,1);
                tt.set(\out,myevents.out);
			    dur.wait;
			    tt.set(\gate,0);
			  }.fork;

			}, {["rest"].post}); // false action
		      myevents.wait.next.wait;
		    }); 
		}).start};


 SynthDef(\Esampler, {arg bufnum = 0, out = 0, amp = 0.5, da = 0, gate = 1, rate = 1.0, midi = 33, basef = 60,
      attack = 0, decay = 0, sustain = 1, release = 0.5, fattack = 0.0, fsustain = 1, frelease = 0.0, aoc = 0, gain = 2, cutoff = 10000.00;
  
    var sig, env, fenv,i;

    i = midi.midicps/basef.midicps;

    env  = Env.adsr(attack,decay,sustain,release);
    env = EnvGen.kr(env, gate: gate, doneAction:da);
    fenv = Env.asr(fattack,fsustain,frelease,1,'sine');
    fenv = EnvGen.kr(fenv, gate,doneAction:da);
    fenv = aoc*(fenv - 1) + 1;
    sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate*i,gate,0,0, doneAction:da)*amp;
    sig = sig * env;


    sig = MoogFF.ar
      (
       sig,
       cutoff*fenv,
       gain
       );
    sig = Splay.ar(sig);
 
    Out.ar(out,sig);
	 
  }).store;


~oboesounds.free;
~oboesounds = ~loadSamples.value("/home/dbalchen/Music/Samples/SonatinaSymphonicOrchestra/Samples/Oboes");


~oboeTemplate = {
  arg x,num,sounds;

  if(num <= 59,{x.set(\bufnum, sounds.at(0));x.set(\basef,58);}); 
  if((num >= 60) && (num < 63) ,{x.set(\bufnum, sounds.at(1));x.set(\basef,61);});
  if((num >= 63) && (num < 66) ,{x.set(\bufnum, sounds.at(2));x.set(\basef,64);});
  if((num >= 66) && (num < 69) ,{x.set(\bufnum, sounds.at(3));x.set(\basef,67);});
  if((num >= 69) && (num < 72) ,{x.set(\bufnum, sounds.at(4));x.set(\basef,70);});
  if((num >= 72) && (num < 75) ,{x.set(\bufnum, sounds.at(5));x.set(\basef,73);});
  if((num >= 75) && (num < 78) ,{x.set(\bufnum, sounds.at(6));x.set(\basef,76);});
  if((num >= 78) && (num < 81) ,{x.set(\bufnum, sounds.at(7));x.set(\basef,79);});
  if((num >= 81) && (num < 84) ,{x.set(\bufnum, sounds.at(8));x.set(\basef,82);});
  if((num >= 85) && (num < 88) ,{x.set(\bufnum, sounds.at(9));x.set(\basef,86);});
  if((num >= 88),{x.set(\bufnum, sounds.at(10));x.set(\basef,89);});
};

/*
~violinsounds.free;
~violinsounds = ~loadSamples.value("/home/dbalchen/Music/Samples/strings/1stViolins");


~violinTemplate = {
  arg x,num,sounds;
	      if(num < 55, {x.set(\imp,0.5)},{x.set(\imp,3)});

	      if(num < 58,{x.set(\bufnum, sounds.at(0));x.set(\basef,55);}); 
	      if((num >= 58) && (num < 61) ,{x.set(\bufnum,  sounds.at(1));x.set(\basef,58);});
	      if((num >= 61) && (num < 64) ,{x.set(\bufnum,  sounds.at(2));x.set(\basef,61);});
	      if((num >= 64) && (num < 67) ,{x.set(\bufnum,  sounds.at(3));x.set(\basef,64);});
	      if((num >= 67) && (num < 70) ,{x.set(\bufnum,  sounds.at(4));x.set(\basef,67);});
	      if((num >= 70) && (num < 73) ,{x.set(\bufnum,  sounds.at(5));x.set(\basef,70);});
	      if((num >= 73) && (num < 76) ,{x.set(\bufnum,  sounds.at(6));x.set(\basef,73);});
	      if((num >= 76) && (num < 79) ,{x.set(\bufnum,  sounds.at(7));x.set(\basef,76);});
	      if((num >= 79) && (num < 82) ,{x.set(\bufnum,  sounds.at(8));x.set(\basef,79);});
	      if((num >= 82) && (num < 85) ,{x.set(\bufnum,  sounds.at(9));x.set(\basef,82);});
	      if((num >= 85) && (num < 88) ,{x.set(\bufnum,  sounds.at(10));x.set(\basef,85);});
	      if((num >= 88) && (num < 91) ,{x.set(\bufnum,  sounds.at(11));x.set(\basef,88);});
	      if((num >= 91) && (num < 94) ,{x.set(\bufnum,  sounds.at(12));x.set(\basef,91);});
	      if((num >= 94),{x.set(\bufnum, sounds.at(13));x.set(\basef,94);});
 };

*/

~cellosounds.free;
~cellosounds = ~loadSamples.value("/home/dbalchen/Music/Samples/strings/Celli");

~celloTemplate = {
  arg x,num,sounds;
  if(num < 36, {x.set(\imp,0.5)},{x.set(\imp,2)});

  if(num < 39,{x.set(\bufnum, sounds.at(0));x.set(\basef,36);}); 
  if((num >= 39) && (num < 42) ,{x.set(\bufnum, sounds.at(1));x.set(\basef,39);});
  if((num >= 42) && (num < 45) ,{x.set(\bufnum, sounds.at(2));x.set(\basef,42);});
  if((num >= 45) && (num < 48) ,{x.set(\bufnum, sounds.at(3));x.set(\basef,45);});
  if((num >= 48) && (num < 51) ,{x.set(\bufnum, sounds.at(4));x.set(\basef,48);});
  if((num >= 51) && (num < 54) ,{x.set(\bufnum, sounds.at(5));x.set(\basef,51);});
  if((num >= 54) && (num < 57) ,{x.set(\bufnum, sounds.at(6));x.set(\basef,54);});
  if((num >= 57) && (num < 60) ,{x.set(\bufnum, sounds.at(7));x.set(\basef,57);});
  if((num >= 60) && (num < 63) ,{x.set(\bufnum, sounds.at(8));x.set(\basef,60);});
  if((num >= 63) && (num < 66) ,{x.set(\bufnum, sounds.at(9));x.set(\basef,63);});
  if((num >= 66) && (num < 69) ,{x.set(\bufnum, sounds.at(10));x.set(\basef,66);});
  if((num >= 69) && (num < 72) ,{x.set(\bufnum, sounds.at(11));x.set(\basef,69);});
  if((num >= 72),{x.set(\bufnum, sounds.at(12));x.set(\basef,72);});
};
