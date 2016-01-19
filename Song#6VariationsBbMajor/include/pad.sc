"/home/dbalchen/workspace/SuperCollider/makeWaveTable.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/makeFilter.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/makeEstring.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/makeOsc.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/makeEnv.sc".loadPath;


~pad = MyLive.new;
~pad.waits = [0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.5];

~pad.amp = 2;

~pad.freqs = [65,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

~pad.probs = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

~pad.durations = [8.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

~pad.calcWait;
~pad.calcFreq;
~pad.calcDur;

~ssaw = ~makeWav.value("/home/dbalchen/Music/Samples/wavetables/AKWF_bw_saw/AKWF_saw_0023.wav");
~ssine = ~makeWav.value("/home/dbalchen/workspace/SuperCollider/Moogy/Samples/Arpsin.aiff");

//~makeEstring.value("Osc2",2);
//~makeOsc.value("Osc2",1);


SynthDef("Osc2",{arg freq = 59,out = 0, lagt = 0.4, spread = 7.00, da = 0,ss,amp = 1;
    var sig, sig2, sig3, sig4,sig5,sigb,cent1, cent2, cent3, cent4,x;

    cent1 = 2**(spread/1200);
    cent2 = 2**((spread*0.76543)/1200);
    cent3 = 2**((spread*0.3333)/1200);
    cent4 = 2**((spread*0.25)/1200);

    freq =  Lag.kr(freq,lagt);

    sig =   Osc.ar(ss,freq);
    sigb =  Osc.ar(ss,(2*freq),0.5);
    sig2 =  Osc.ar(ss,(freq*cent1),1);
    sig3 =  Osc.ar(ss,(freq/(cent2)),1.5);
    sig4 =  Osc.ar(ss,(2*(freq*(cent3))),2);
    sig5 =  Osc.ar(ss,(2*(freq/cent4)),2.5);

    x = Mix.new([sig/6,sig2/6,sig3/6,sig4/6,sig5/6,sigb/6]);
	x = Integrator.ar(x, 0.7);
    Out.ar ( out,amp*x.dup);
  }
  ).store;






~makeFilter.value("padFilter",32);
~synthPad = Group.new;

~cosc = Synth.head(~synthPad,"Osc2");
~cosc.set(\ss,~ssaw);
~cosc.set(\wiggler,~ssine);
~cosc.set(\out,34);
~cosc.set(\da,0);
~cosc.set(\amp,0.05);
~cosc.set(\wrange,0.5);
~cosc.set(\wfreq,10);
~cosc.set(\lagt,0.5);
~cosc.set(\spread,7);


~cfiltr = Synth.tail(~synthPad,"padFilter");
~cfiltr.set(\filterBus,34);
~cfiltr.set(\filterOut,0);
~cfiltr.set(\da,0);
~cfiltr.set(\cutoff,2500);
~cfiltr.set(\attack,0.2);
~cfiltr.set(\release,3.5);
~cfiltr.set(\gain,2.0);

~padPat = {
  var myTask,x,y;

  myTask = Task({
      var num,sus;

      inf.do({ 
	  num =   ~pad.freq.next;
		  sus =   3;//~pad.duration.next;

	  if(num.isMemberOf(Integer),
	    { 

	      ~cosc.set(\freq,num.midicps);
          ~cosc.set(\amp,~pad.amp); 
           ~cosc.set(\dur,sus);
	      ~synthPad.set(\gate,1);

	    }, {["rest"].post}); // false action
	  (~pad.wait.next - 0.1).wait;
	  ~synthPad.set(\gate,0);
          0.1.wait;
	}); 
    }).start};



~pad2 = MyLive.new;
~pad2.waits = [8.0,4.0,4.0,8.0,4.0,4.0]; 
~pad2.freqs = [73,79,75,73,72,75];
~pad2.probs = [1,1,1,1,1,1];
~pad2.durations = [8.0,4.0,4.0,8.0,4.0,3.9375];
~pad2.amp = 0.5;
~pad2.calcWait;
~pad2.calcFreq;
~pad2.calcDur;

~makeFilter.value("pad2Filter",36);
~synth2Pad = Group.new;

~cosc2 = Synth.head(~synth2Pad,"Osc2");
~cosc2.set(\ss,~ssaw);
~cosc2.set(\wiggler,~ssine);
~cosc2.set(\out,36);
~cosc2.set(\da,0);
~cosc2.set(\amp,0.05);
~cosc2.set(\wrange,0.25);
~cosc2.set(\wfreq,10);
~cosc2.set(\lagt,0.5);
~cosc2.set(\spread,7);


~cfiltr2 = Synth.tail(~synth2Pad,"pad2Filter");
~cfiltr2.set(\filterBus,36);
~cfiltr2.set(\filterOut,0);
~cfiltr2.set(\da,0);
~cfiltr2.set(\cutoff,2500);
~cfiltr2.set(\attack,0.2);
~cfiltr2.set(\release,3.5);
~cfiltr2.set(\gain,2.0);

~padPat2 = {
  var myTask,x,y;

  myTask = Task({
      var num,sus;

      inf.do({ 
	  num =   ~pad2.freq.next;
		  sus =   3;//~pad.duration.next;

	  if(num.isMemberOf(Integer),
	    { 

	      ~cosc2.set(\freq,num.midicps);
          ~cosc2.set(\amp,~pad2.amp); 
           ~cosc2.set(\dur,sus);
	      ~cfiltr2.set(\gate,1);

	    }, {["rest"].post}); // false action
	  (~pad2.wait.next - 0.1).wait;
	  ~cfiltr2.set(\gate,0);
          0.1.wait;
	}); 
    }).start};






/*
~padPat.value;
~filterWindow.value("Synth Filter", ~cfiltr2);
*/