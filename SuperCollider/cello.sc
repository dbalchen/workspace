~cellosounds.free;
~cellosounds = ~loadSamples.value("/home/dbalchen/Music/Samples/strings/Celli");


~celloTemplate = {
  arg name,num,sus,rel,atc,sounds,amp,out=0;
  var x;
  x = Synth(name);

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
  x.set(\out, out);
  x.set(\midi,num);
  x.set(\sustain,sus);
  x.set(\release,rel);
  x.set(\attack,atc);
  x.set(\gate,1);
  x.set(\amp,amp);
  x.set(\da,2);
};

