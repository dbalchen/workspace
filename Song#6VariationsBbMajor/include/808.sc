 "/home/dbalchen/workspace/SuperCollider/loadSamples.sc".loadPath;
 "/home/dbalchen/workspace/SuperCollider/runSampler.sc".loadPath;

SynthDef(\808, {arg out = 0, bufnum = 0, gate = 1, da = 2, rate = 1.0, amp = 1.0, attack = 0, sustain = 1, release = 0 ;
     var x,z,q;
     q = EnvGen.kr( Env.asr(attack,sustain,release),gate,doneAction:da);
     x = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*rate*gate,gate,0,0,doneAction:da)*amp;
     z = x * q;
     Out.ar(out,z)}).store;

~tr808sounds.free;
~tr808sounds = ~loadSamples.value("/home/dbalchen/Music/Song#6VariationsBbMajor/samples/808");


~tr808Template = {
  arg name,num,sus,rel,atc,sounds,amp,out=0;
  var x;

  x = Synth(name);
  if(num == 1,{x.set(\bufnum, sounds.at(0));}); 
  x.set(\out, out);
  x.set(\midi,num);
  x.set(\sustain,sus);
  x.set(\release,rel);
  x.set(\attack,atc);
  x.set(\gate,1);
  x.set(\amp,amp);
  x.set(\da,2);
};





