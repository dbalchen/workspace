~cellosounds.free;
~cellosounds = ~loadSamples.value("/home/dbalchen/Music/Samples/string2/cellos");


~celloTemplate = {
  arg name,num,sus,rel,atc,sounds,amp,out=0;
  var x;
  x = Synth(name);

  if(num < 36, {x.set(\imp,0.5)},{x.set(\imp,2)});

  if(num < 39,{x.set(\bufnum, sounds.at(0));x.set(\basef,36);}); 
  if((num >= 39) && (num < 42) ,{x.set(\bufnum, sounds.at(1));x.set(\basef,40);});
  if((num >= 42) && (num < 46) ,{x.set(\bufnum, sounds.at(2));x.set(\basef,43);});
  if((num >= 46) && (num < 49) ,{x.set(\bufnum, sounds.at(3));x.set(\basef,47);});
  if((num >= 49) && (num < 52) ,{x.set(\bufnum, sounds.at(4));x.set(\basef,50);});
  if((num >= 52) && (num < 56) ,{x.set(\bufnum, sounds.at(5));x.set(\basef,53);});
  if((num >= 56) && (num < 59) ,{x.set(\bufnum, sounds.at(6));x.set(\basef,57);});
  if((num >= 59) && (num < 63) ,{x.set(\bufnum, sounds.at(7));x.set(\basef,60);});
  if((num >= 65) && (num < 66) ,{x.set(\bufnum, sounds.at(8));x.set(\basef,64);});
  if((num >= 66) && (num < 70) ,{x.set(\bufnum, sounds.at(9));x.set(\basef,67);});
  if((num >= 70) && (num < 73) ,{x.set(\bufnum, sounds.at(10));x.set(\basef,71);});
  if((num >= 72) && (num < 76) ,{x.set(\bufnum, sounds.at(11));x.set(\basef,74);});
  if((num >= 76),{x.set(\bufnum, sounds.at(12));x.set(\basef,77);});
  x.set(\out, out);
  x.set(\midi,num);
  x.set(\sustain,sus);
  x.set(\release,rel);
  x.set(\attack,atc);
  x.set(\gate,1);
  x.set(\amp,amp);
  x.set(\da,2);
};

