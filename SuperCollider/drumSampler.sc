"/home/dbalchen/workspace/SuperCollider/eSampler.sc".loadPath;
"/home/dbalchen/workspace/SuperCollider/loadSamples.sc".loadPath;

~drumSound.free;
~drumSound = ~loadSamples.value("/home/dbalchen/Music/Samples/midiDrums/");

~drumTemplate = {
  arg x,num,sounds;
  x.set(\bufnum, sounds.at(num - 36));
};


~midiDrum = {arg myevents,sounds,num, rate = 1.0, template = ~drumTemplate ;
	     var myTask,x,y, flt, env,amp,tt;
	     amp = myevents.amp;
	     flt = myevents.filter;
	     env = myevents.envelope;

	     if(num.isMemberOf(Integer),
	       { 
		 tt = Synth("Esampler");
		 tt.set(\gate,0);
		 flt.setFilter(tt);
		 env.setEnvelope(tt);
		 template.value(tt,num,sounds);
         tt.set(\rate,rate);
		 tt.set(\da,2);
		 tt.set(\amp,amp);
		 tt.set(\gate,1);
		 tt.set(\out,myevents.out);
	       }, {["rest"].post}); // false action
             tt;
};

