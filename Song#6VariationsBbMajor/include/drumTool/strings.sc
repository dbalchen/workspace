
~cellosounds.free;
~cellosounds = ~loadSamples.value("/home/dbalchen/Music/Samples/strings/Celli");

~celloTemplate = {
  arg x,num,sounds;
  x.set(\midi,num);
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

~cello = MyEvents.new;
~cello.waits = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.5,0.5,1.0,1.0,3.0,0.5,0.5,2.0,1.0,1.0,8.0]; 
~cello.freqs = [62,60,58,60,56,53,60,58,56,55,56,55,53,56,62,60,58,60,53,60,58];
~cello.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.durations = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.5,0.5,1.0,1.0,3.0,0.5,0.5,2.0,1.0,1.0,8.0];
~cello.init;
~cello.amp = 0.4;
~cello.filter.attack = 0.0;
~cello.filter.release = 3.0;
~cello.filter.cutoff = 20000;
~cello.filter.gain = 1.0;
~cello.filter.sustain = 1.0;
~cello.filter.aoc = 0;
~cello.envelope.attack = 0.50;
~cello.envelope.release = 0.50;
~cello.envelope.decay = 8.0;
~cello.envelope.sustain = 0.15;
~cello.envelope.attacks = [2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.envelope.init;

~channel0 = {arg num;
	     var ret;
     num.postln;
	     ret = ~eSampler.value(~cello,~cellosounds,~celloTemplate,num);
	// ret = ~midiStrings.value(~cello,num);
	     ret;
};


~violinsounds.free;
~violinsounds = ~loadSamples.value("/home/dbalchen/Music/Samples/strings/1stViolins");


~violinTemplate = {
  arg x,num,sounds;
  x.set(\midi,num);
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

~violin = MyEvents.new;
~violin.waits = [32.0];
~violin.freqs = [60];
~violin.probs = [0];
~violin.durations = [32.0];
~violin.init;
~violin.amp = 0.7;
~violin.filter.attack = 0.0;
~violin.filter.release = 3.0;
~violin.filter.cutoff = 20000;
~violin.filter.gain = 1.0;
~violin.filter.sustain = 1.0;
~violin.filter.aoc = 0;
~violin.envelope.attack = 0.5;
~violin.envelope.release = 0.50;
~violin.envelope.decay = 8.0;
~violin.envelope.sustain = 0.15;
~violin.envelope.attacks = [1];
~violin.envelope.release = [1];
~violin.envelope.init;

~channel1 = {arg num;
	     var ret;
     num.postln;
	  ret = ~eSampler.value(~violin,~violinsounds,~violinTemplate,num);
	// ret = ~midiStrings.value(~violin,num);
	     ret;
};

~violasounds.free;
~violasounds = ~loadSamples.value("/home/dbalchen/Music/Samples/strings/Violas");


~violaTemplate = {
  arg x,num,sounds;

  x.set(\midi,num);
  if(num < 48, {x.set(\imp,0.5)},{x.set(\imp,2)});

  if(num < 51,{x.set(\bufnum, sounds.at(0));x.set(\basef,48);}); 
  if((num >= 51) && (num < 54) ,{x.set(\bufnum, sounds.at(1));x.set(\basef,51);});
  if((num >= 54) && (num < 57) ,{x.set(\bufnum, sounds.at(2));x.set(\basef,54);});
  if((num >= 57) && (num < 60) ,{x.set(\bufnum, sounds.at(3));x.set(\basef,57);});
  if((num >= 60) && (num < 63) ,{x.set(\bufnum, sounds.at(4));x.set(\basef,60);});
  if((num >= 63) && (num < 66) ,{x.set(\bufnum, sounds.at(5));x.set(\basef,63);});
  if((num >= 66) && (num < 69) ,{x.set(\bufnum, sounds.at(6));x.set(\basef,66);});
  if((num >= 69) && (num < 72) ,{x.set(\bufnum, sounds.at(7));x.set(\basef,69);});
  if((num >= 72) && (num < 75) ,{x.set(\bufnum, sounds.at(8));x.set(\basef,72);});
  if((num >= 75) && (num < 78) ,{x.set(\bufnum, sounds.at(9));x.set(\basef,75);});
  if((num >= 78) && (num < 81) ,{x.set(\bufnum, sounds.at(10));x.set(\basef,78);});
  if((num >= 81) && (num < 84) ,{x.set(\bufnum, sounds.at(11));x.set(\basef,81);});
  if((num >= 84),{x.set(\bufnum, sounds.at(12));x.set(\basef,84);});

};


~viola = MyEvents.new;
~viola.waits = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0,3.0,0.5,0.5,1.5,0.5,1.0,1.0,8.0];
~viola.freqs = [62,60,58,60,56,53,60,58,62,60,58,63,62,60,67,65];
~viola.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.durations = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0,3.0,0.5,0.5,1.5,0.5,1.0,1.0,8.0];
~viola.init;
~viola.amp = 0.4;
~viola.filter.attack = 0.0;
~viola.filter.release = 3.0;
~viola.filter.cutoff = 20000;
~viola.filter.gain = 1.0;
~viola.filter.sustain = 1.0;
~viola.filter.aoc = 0;
~viola.envelope.attack = 0.5;
~viola.envelope.release = 0.50;
~viola.envelope.decay = 8.0;
~viola.envelope.sustain = 0.15;
~viola.envelope.attacks = [2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.envelope.init;

~channel2 = {arg num;
	     var ret;
     num.postln;
	 ret = ~eSampler.value(~viola,~violasounds,~violaTemplate,num);
	//     ret = ~midiStrings.value(~viola,num);

	     ret;
};

~first = {
~viola.waits = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0,3.0,0.5,0.5,1.5,0.5,1.0,1.0,8.0];
~viola.freqs = [62,60,58,60,56,53,60,58,62,60,58,63,62,60,67,65];
~viola.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.durations = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0,3.0,0.5,0.5,1.5,0.5,1.0,1.0,8.0];
~viola.envelope.attacks =  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2];

~violin.waits = [32.0];
~violin.freqs = [60];
~violin.probs = [0];
~violin.durations = [32.0];
~violin.envelope.attacks = [1];
~violin.envelope.release = [1];

~cello.waits = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.5,0.5,1.0,1.0,3.0,0.5,0.5,2.0,1.0,1.0,8.0]; 
~cello.freqs = [62,60,58,60,56,53,60,58,56,55,56,55,53,56,62,60,58,60,53,60,58];
~cello.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.durations = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.5,0.5,1.0,1.0,3.0,0.5,0.5,2.0,1.0,1.0,8.0];
~cello.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
};



~firstMiddle = {
~violin.waits = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,5.5,0.5,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0]; 
~violin.freqs = [82,77,82,80,79,72,75,74,79,77,75,77,72,70,72,68,72,72,70];
~violin.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~violin.durations = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,5.5,0.5,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0];
~violin.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~violin.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];


~viola.waits = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,3.5,0.5,1.5,0.5,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0]; 
~viola.freqs = [70,72,65,68,67,65,67,65,67,68,67,68,67,65,63,65,63,63,65,63,62];
~viola.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.durations = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,3.5,0.5,1.5,0.5,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0];
~viola.envelope.attacks  = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];


~cello.waits = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,1.5,0.5,1.5,0.5,1.5,0.5,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0]; 
~cello.freqs = [58,65,58,56,55,53,51,50,51,53,55,56,55,53,51,62,60,58,60,56,53,60,58];
~cello.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.durations = [3.0,0.5,0.5,1.0,1.0,1.0,1.0,1.5,0.5,1.5,0.5,1.5,0.5,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,8.0];
~cello.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

};


~second = {
~violin.waits = [32.0];
~violin.freqs = [60];
~violin.probs = [0];
~violin.durations = [32.0];
~violin.envelope.attacks = [1];
~violin.envelope.releases = [1];


~viola.waits = [1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0]; 
~viola.freqs = [62,63,65,62,68,67,68,65,62,63,65,62,68,67,68,65];
~viola.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.durations = [1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0] * 1.05;
~viola.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] * 1;
~viola.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] * 1.25;

~cello.waits = [1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0] ; 
~cello.freqs = [62,63,65,62,60,58,56,58,62,63,65,62,56,58,60,62];
~cello.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.durations = [1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0] * 1.05;
~cello.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] * 1;
~cello.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] * 1.25 ;

};


~secMiddle = {
~cello.waits = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,4.0,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0]; 
~cello.freqs = [58,65,62,58,60,62,56,55,53,53,58,51,55,62,60,58,60,56,53,60];
~cello.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.durations = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,4.0,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0];
~cello.envelope.attacks =  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

~violin.waits = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,4.0,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0]; 
~violin.freqs = [82,77,77,82,80,79,72,75,74,77,79,72,77,74,72,70,72,68,65,72];
~violin.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~violin.durations = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,4.0,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0];
~violin.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~violin.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

~viola.waits = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0]; 
~viola.freqs = [70,68,65,70,68,67,65,63,62,63,65,62,65,67,68,67,65,63,65,63,63,65,63];
~viola.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.durations = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0];
~viola.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
};


~secMiddle2 = {
~violin.waits = [6.0,1.0,1.0]; 
~violin.freqs = [70,77,82];
~violin.probs = [1,1,1];
~violin.durations = [6.0,1.0,1.0];
~violin.envelope.attacks = [1,1,1];
~violin.envelope.releases =  [1,1,1];

~viola.waits = [6.0,1.0,1.0]; 
~viola.freqs = [62,65,70];
~viola.probs = [1,1,1];
~viola.durations = [6.0,1.0,1.0];
~viola.envelope.attacks =  [1,1,1];
~viola.envelope.releases =  [1,1,1];


~cello.waits = [6.0,1.0,1.0]; 
~cello.freqs = [58,53,58];
~cello.probs = [1,1,1];
~cello.durations = [6.0,1.0,1.0];
~cello.envelope.attacks =  [1,1,1];
~cello.envelope.releases =  [1,1,1];
};

~secMiddle2E = {

~violin.waits = [4.0]; 
~violin.freqs = [70];
~violin.probs = [1];
~violin.durations = [4.0];
~violin.envelope.attacks = [1];
~violin.envelope.releases =  [1];

~viola.waits = [4.0]; 
~viola.freqs = [62];
~viola.probs = [1];
~viola.durations = [4.0];
~viola.envelope.attacks =  [1];
~viola.envelope.releases =  [1];

~cello.waits = [4.0]; 
~cello.freqs = [58];
~cello.probs = [1];
~cello.durations = [4.0];
~cello.envelope.attacks =  [1];
~cello.envelope.releases =  [1];

};

~middle8 = {

~violin.waits = [3.0,0.5,0.5,3.0,0.5,0.5,1.5,0.5,0.5,0.5,0.5,0.5,4.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,2.0,2.0,8.0]; 
~violin.freqs = [80,79,80,77,77,79,80,79,75,77,72,70,72,78,75,78,77,73,70,65,68,72,70];
~violin.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~violin.durations = [3.0,0.5,0.5,3.0,0.5,0.5,1.5,0.5,0.5,0.5,0.5,0.5,4.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,2.0,2.0,8.0];
~violin.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~violin.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4];

~viola.waits = [3.0,0.5,0.5,3.0,0.5,0.5,1.5,0.5,0.5,0.5,0.5,0.5,4.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,2.0,2.0,8.0]; 
~viola.freqs = [68,67,68,65,65,67,68,70,72,70,68,67,65,66,63,66,65,61,65,60,60,63,65];
~viola.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.durations = [3.0,0.5,0.5,3.0,0.5,0.5,1.5,0.5,0.5,0.5,0.5,0.5,4.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,2.0,2.0,8.0];
~viola.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4];

~cello.waits = [3.0,0.5,0.5,3.0,0.5,0.5,1.5,0.5,0.5,0.5,0.5,0.5,4.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,2.0,2.0,8.0]; 
~cello.freqs = [56,58,51,53,60,55,56,58,55,58,56,55,53,54,54,58,56,58,53,56,56,60,58];
~cello.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.durations = [3.0,0.5,0.5,3.0,0.5,0.5,1.5,0.5,0.5,0.5,0.5,0.5,4.0,3.0,0.5,0.5,1.0,1.0,1.0,1.0,2.0,2.0,8.0];
~cello.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4];

};


~melEnd = {
~violin.waits = [2.0,1.0,1.0,1.0,1.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0]; 
~violin.freqs = [77,74,82,80,79,77,75,74,77,74,70,65,68,70,72,74];
~violin.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~violin.durations = [2.0,1.0,1.0,1.0,1.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0];
~violin.envelope.attacks =  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~violin.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

~viola.waits = [2.0,1.0,1.0,1.0,1.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0]; 
~viola.freqs = [65,62,70,68,67,65,67,62,65,65,62,65,60,62,63,62];
~viola.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.durations = [2.0,1.0,1.0,1.0,1.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0];
~viola.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~viola.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

~cello.waits = [2.0,1.0,1.0,1.0,1.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0]; 
~cello.freqs = [62,58,65,56,58,56,55,53,60,62,58,62,56,58,60,58];
~cello.probs = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.durations = [2.0,1.0,1.0,1.0,1.0,1.0,1.0,8.0,1.0,1.0,1.0,1.0,2.0,1.0,1.0,8.0];
~cello.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
};

~end = {
~violin.waits = [2.0,1.0,1.0,4.0,2.0,1.0,1.0,4.0]; 
~violin.freqs = [72,68,72,74,75,77,75,74];
~violin.probs = [1,1,1,1,1,1,1,1];
~violin.durations = [2.0,1.0,1.0,4.0,2.0,1.0,1.0,4.0];
~violin.envelope.attacks =  [1,1,1,1,1,1,1,1];
~violin.envelope.releases = [1,1,1,1,1,1,1,1];


~viola.waits = [2.0,1.0,1.0,4.0,2.0,1.0,1.0,4.0]; 
~viola.freqs = [68,65,72,70,68,65,68,70];
~viola.probs = [1,1,1,1,1,1,1,1];
~viola.durations = [2.0,1.0,1.0,4.0,2.0,1.0,1.0,4.0];
~viola.envelope.attacks = [1,1,1,1,1,1,1,1];
~viola.envelope.releases = [1,1,1,1,1,1,1,1];

~cello.waits = [2.0,1.0,1.0,4.0,2.0,1.0,1.0,4.0]; 
~cello.freqs = [56,53,60,58,56,53,56,58];
~cello.probs = [1,1,1,1,1,1,1,1];
~cello.durations = [2.0,1.0,1.0,4.0,2.0,1.0,1.0,4.0];
~cello.envelope.attacks = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
~cello.envelope.releases = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

};


~null = { arg events;

events.waits = [4.0];
events.freqs = [0];
events.probs = [0];
events.durations = [4.0];
events.envelope.attacks = [0];
events.envelope.releases = [0];
};