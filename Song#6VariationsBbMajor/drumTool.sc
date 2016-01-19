Help.gui
Quarks.gui
GUI.qt

(
 o = Server.local.options;
 o.numOutputBusChannels = 24; // The next time it boots, this will take effect
// o.memSize = 2097152;
 )

 "/home/dbalchen/Music/Song#6VariationsBbMajor/setup.sc".loadPath;



(
 "/home/dbalchen/workspace/SuperCollider/loadSamples.sc".loadPath;
 "/home/dbalchen/workspace/SuperCollider/eSampler.sc".loadPath;
~allTimes = [1.0,0.5,0.25,0.25,0.5,0.5,0.5,0.5,1.0,0.5,0.25,0.25,0.5,0.5,0.5,0.5,1.0,0.5,0.25,0.25,0.5,0.5,0.5,0.5,1.0,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.5,0.5]; 
~drumSound.free;
~drumSound = ~loadSamples.value("/home/dbalchen/Music/Song#6VariationsBbMajor/samples/808");


~c7 = MyEvents.new;
~c7.waits = ~allTimes.deepCopy;
~c7.freqs = [59,59,59,0,59,59,59,59,59,59,59,0,59,59,59,59,59,59,59,0,59,59,59,59,59,59,59,0,59,0,59,0,59,59];
~c7.probs = [1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,0,1,0,1,1];
~c7.durations = [1.0,0.5,0.5,0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0,0.5,0,0.5,0,0.5,0.5] * 4;
~c7.init;
~c7.amp = 3.0;


~bassdrum = MyEvents.new;
~bassdrum.waits = ~allTimes.deepCopy;
~bassdrum.freqs = [35,0,0,35,0,35,0,0,35,0,0,35,0,35,0,35,35,0,0,35,0,35,0,35,35,0,0,35,0,35,0,0,35,0];
~bassdrum.probs = [1,0,0,1,0,1,0,0,1,0,0,1,0,1,0,1,1,0,0,1,0,1,0,1,1,0,0,1,0,1,0,0,1,0];
~bassdrum.durations = [1.75,0,0,0.75,0,1.5,0,0,1.75,0,0,0.75,0,1.0,0,0.5,1.75,0,0,0.75,0,1.0,0,0.5,1.75,0,0,0.5,0,0.75,0,0,1.0,0];
~bassdrum.init;
~bassdrum.amp = 2.0;



~snare = MyEvents.new;
~snare.waits = ~allTimes.deepCopy ;
~snare.freqs = [0,40,0,0,0,0,40,0,0,40,0,0,0,0,40,0,0,40,0,0,0,0,40,0,0,40,0,0,0,0,0,40,0,40];
~snare.probs = [0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,1];
~snare.durations = [0,2.0,0,0,0,0,2.0,0,0,2.0,0,0,0,0,2.0,0,0,2.0,0,0,0,0,2.0,0,0,1.75,0,0,0,0,0,0.75,0,0.5];
~snare.init;
~snare.amp = 3.0;


~setMods = {

~c7.filter.attack = 0.1;
~c7.filter.release = 0.2;
~c7.filter.cutoff = 5000;
~c7.filter.sustain = 1.0;
~c7.filter.gain = 3.4;
~c7.filter.aoc = 1.00;

~c7.envelope.attack = 0.0;
~c7.envelope.decay= 0.1;
~c7.envelope.sustain = 0.01;
~c7.envelope.release = 0.0;

~bassdrum.filter.attack = 0.05;
~bassdrum.filter.release = 0.5;
~bassdrum.filter.cutoff = 7445;
~bassdrum.filter.sustain = 1.0;
~bassdrum.filter.gain = 2.0;
~bassdrum.filter.aoc = 1.00;

~bassdrum.envelope.attack = 0.0;
~bassdrum.envelope.decay= 0.15;
~bassdrum.envelope.sustain = 0.3;
~bassdrum.envelope.release = 0.0;

~snare.filter.attack = 0.05;
~snare.filter.release = 0.0;
~snare.filter.cutoff = 5000;
~snare.filter.sustain = 0.75;
~snare.filter.gain = 2.0;
~snare.filter.aoc = 1.00;

~snare.envelope.attack = 0.0;
~snare.envelope.decay= 0.2;
~snare.envelope.sustain = 0.0;
~snare.envelope.release = 0.0;
};


~clicks = {
~snare.envelope.decay= 0.0;
~snare.filter.cutoff = 9000;
~snare.filter.gain = 3.5;
~bassdrum.envelope.decay= 0.0;
~bassdrum.envelope.sustain = 0.0;
~bassdrum.filter.attack = 0.0;
~bassdrum.filter.release = 0.0;
~bassdrum.filter.cutoff = 8000;
~bassdrum.filter.sustain = 0.6;
~bassdrum.filter.gain = 0.0;
~c7.envelope.decay= 0.0;
~c7.envelope.sustain = 0.0;
~c7.filter.attack = 0.0;
~c7.filter.release = 0.0;
~c7.filter.cutoff = 10000;
~c7.filter.sustain = 1.0;
~c7.filter.gain = 3.9;
};

~haunting = {

~snare.filter.attack = 0.6;
~snare.filter.release = 0.0;
~snare.filter.cutoff = 8000;
~snare.filter.sustain = 1.0;
~snare.filter.gain = 0.0;
~snare.filter.aoc = 1.00;
~snare.envelope.attack = 0.6;
~snare.envelope.decay= 10.0;
~snare.envelope.sustain = 1.0;
~snare.envelope.release = 0.0;

~bassdrum.filter.attack = 0.6;
~bassdrum.filter.release = 10.0;
~bassdrum.filter.cutoff = 1120;
~bassdrum.filter.sustain = 1.0;
~bassdrum.filter.gain = 0.0;
~bassdrum.filter.aoc = 1.00;
~bassdrum.envelope.attack = 0.3;
~bassdrum.envelope.decay= 10.0;
~bassdrum.envelope.sustain = 1.0;
~bassdrum.envelope.release = 10.0;

~c7.envelope.decay= 0.0;
~c7.envelope.sustain = 0.0;
~c7.filter.attack = 0.0;
~c7.filter.release = 0.0;
~c7.filter.cutoff = 10000;
~c7.filter.sustain = 1.0;
~c7.filter.gain = 3.9;
};


~setMods.value;
~clicks.value;
~haunting.value;

~tr808Template = {
  arg x,num,sounds;
   if(num == 35,{x.set(\bufnum, sounds.at(0));}); 
   if(num == 40,{x.set(\bufnum, sounds.at(1));}); 
   if(num == 59,{x.set(\bufnum, sounds.at(2));}); 
};


)


~startTimer.value(60);


~rp = {~runEsampler.value(~bassdrum,~drumSound,~tr808Template,)};
~rp = {~runEsampler.value(~snare,~drumSound,~tr808Template,)};
~rp = {~runEsampler.value(~c7,~drumSound,~tr808Template,)};

~rp = {1.01.wait;~runEsampler.value(~bassdrum,~drumSound,~tr808Template,);~runEsampler.value(~snare,~drumSound,~tr808Template,);~runEsampler.value(~c7,~drumSound,~tr808Template,)};


~bassdrum.filter.makeGui;~bassdrum.envelope.envGui;
~snare.filter.makeGui;~snare.envelope.envGui;
~c7.filter.makeGui;~c7.envelope.envGui;


~clicks.value;
~setMods.value;
~haunting.value;


~rp = {
fork{loop{h=([44,34].choose.midicps)*(2**((0 .. 3).choose));play{Splay.ar({LFSaw.ar(exprand(h-(h/256),h+(h/256)),0,0.1)}!32)*0.1*LFGauss.ar(19,1/4,0,0,2)};4.wait}};

fork{loop{h=([44,41,34,39].choose.midicps)*(2**((3 .. 5).choose));play{Splay.ar({SinOsc.ar(exprand(h-(h/256),h+(h/256)),0,0.1)}!32)*0.1*LFGauss.ar(19,1/4,0,0,2)};8.wait}};
};


~start = {
   var timeNow;
   t = TempoClock.default.tempo = 60 / 60;
   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;
	   //0.2.wait;
t.schedAbs(timeNow + 0.0063,{(
~runEsampler.value(~bassdrum,~drumSound,~tr808Template,);~runEsampler.value(~snare,~drumSound,~tr808Template,);~runEsampler.value(~c7,~drumSound,~tr808Template,)
			    );nil});
   };)
};