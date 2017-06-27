~violinsounds.free;
~violinsounds = ~loadSamples.value("/home/dbalchen/Music/Samples/strings/1stViolins");


~violinTemplate = {
  arg name,num,sus,rel,atc,sounds,amp,out=0;
  var x;
  x = Synth(name);
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
 
  x.set(\out, out);
  x.set(\midi,num);
  x.set(\sustain,sus);
  x.set(\release,rel);
  x.set(\attack,atc);
  x.set(\gate,1);
  x.set(\amp,amp);
  x.set(\da,2);
};


