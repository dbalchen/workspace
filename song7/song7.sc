Help.gui
Quarks.gui

s.boot;
s.plotTree;
s.meter;
s.quit;

FreqScope.new(400, 200, 0, server: s);
Server.default.makeGui

play{Impulse.ar(2)!2}

(
o = Server.local.options;
o.numOutputBusChannels = 24; // The next time it boots, this will take effect
o.memSize = 2097152;
)

"/home/dbalchen/Music/setup.sc".load;

(
~startup = {

	(
		// Put stuff here...........
		"/home/dbalchen/Music/song7/include/synths/FMPiano.sc".load;
		"/home/dbalchen/Music/song7/include/synths/eStrings.sc".load;
		"/home/dbalchen/Music/song7/include/synths/vangelis.sc".load;
		"/home/dbalchen/Music/song7/include/synths/FMpad.sc".load;
		"/home/dbalchen/Music/song7/include/synths/basicControlEnv.sc".load;
		~mels = Array.new(128);
		~mels.add([69,73,74,69,76,81,78,74]);
		~mels.add([69,73,76,71,76,81,80,76]);
		~mels.add([73,74,76,73,71,69,71,73]);
		~mels.add([73,69,74,76,71,67,69,74]);
		~mels.add([76,72,69,74,69,76,77,81]);
		~mels.add([77,81,82,77,72,77,74,70]);
		~mels.add([79,71,74,79,71,79,78,74]);
		~mels.add([80,76,73,78,73,69,73,76]);

		~probs = Array.new(128);
		~probs.add([1,1,1,1,1,1,1,1]);
		~probs.add([1,1,0,1,1,0,1,0]);
		~probs.add([1,0,0,0,1,0,1,0]);
		~probs.add([1,0,0,0,1,0,0,0]);
		~probs.add([1,0,0,0,0,0,0,0]);
		~probs.add([1,0,1,0,1,0,1,1]);
		~probs.add([1,1,1,1,1,1,1,0]);
		~probs.add([1,0,1,0,1,1,1,0]);
		~probs.add([1,1,0,1,1,1,0,1]);
		~probs.add([1,1,1,0,1,1,1,0]);
		~probs.add([1,1,0,1,1,1,1,0]);
		~probs.add([1,1,1,1,1,0,1,1]);
		~probs.add([1,1,1,0,1,0,1,0]);
		~probs.add([1,0,1,0,1,0,0,0]);
		~probs.add([1,1,1,0,1,0,1,1]);
		~probs.add([1,0,1,1,1,0,0,1]);
		~probs.add([1,1,0,0,1,0,1,0]);
		~probs.add([1,1,1,1,1,1,0,0]);
		~probs.add([1.00,0.66,0.5,0.50,1.00,0.50,0.66,0.33]);


		~clock = MyTrack.new(~synth2,0);

		~clock.notes.waits = [ 1, 1, 1, 1, 1, 1, 1, 1 ] * 0.5;// 0.250;
		~clock.notes.probs = ~probs.at(6);
		~clock.notes.freqs =  (~mels.choose ++ ~mels.choose);
		~clock.notes.freqs =  ~mels.at(7) - 24;
		~clock.notes.durations = [0.5];


		~clock2 = MyTrack.new(~synth1,1);
		~clock2.notes.waits =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];
		~clock2.notes.freqs = [33,37,38,33,40,45,42,38,44,40,37,42,37,33,37,40,33,37,38,33,40,45,42,38,44,40,37,42,37,33,37,40,44,40,37,42,37,33,37,40,44,40,37,35,33,35,37,40,44,40,37,42,37,33,37,40,44,40,37,35,33,35,37,40,38,40,38,37,35,32,33,35,38,40,38,37,35,32,33,35,37,35,33,35,37,33,35,30,33,28,30,32,33,30,28,32];
		~clock2.notes.durations = [1];

		~clock3 = MyTrack.new(~synth2,2);
		~clock3.notes.waits =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];
		~clock3.notes.freqs =  [57,0,0,0,0,0,0,0,59,0,0,0,0,0,0,0,57,0,0,0,0,0,0,0,59,0,0,0,0,0,0,0,57,0,0,0,0,0,0,0,59,0,0,0,0,0,0,0,61,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,62,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,61,0,0,0,0,0,0,0,57,0,0,0,0,0,0,0];
		~clock3.notes.durations = [8];


		~clock4 = MyTrack.new(~synth2,3);
		~clock4.notes.waits =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];
		~clock4.notes.freqs = 	[69,0,0,0,0,0,0,0,71,0,0,0,0,0,0,0,69,0,0,0,0,0,0,0,71,0,0,0,0,0,0,0,73,0,0,0,0,0,0,0,74,0,0,0,0,0,0,0,76,0,0,0,0,0,0,0,78,0,0,0,0,0,0,0,74,0,0,0,0,0,0,0,76,0,0,0,0,0,0,0,73,0,0,0,0,0,0,0,69,0,0,0,0,0,0,0];

		~clock4.notes.durations = [8];


		~clock5 = MyTrack.new(~synth2,4);
		~clock5.notes.waits =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];
		~clock5.notes.freqs = [76,0,0,0,0,0,0,0,78,0,0,0,0,0,0,0,76,0,0,0,0,0,0,0,78,0,0,0,0,0,0,0,76,0,0,0,0,0,0,0,78,0,0,0,0,0,0,0,81,0,0,0,0,0,0,0,83,0,0,0,0,0,0,0,78,0,0,0,0,0,0,0,80,0,0,0,0,0,0,0,76,0,0,0,0,0,0,0,73,0,0,0,0,0,0,0];
		~clock5.notes.durations = [8];


		~clock6 = MyTrack.new(~synth2,5);
		~clock6.notes.waits =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];
		~clock6.notes.probs =  ~probs.at(3);
		~clock6.notes.freqs = [69,73,74,69,76,81,78,74,80,76,73,78,73,69,73,76,69,73,74,69,76,81,78,74,80,76,73,78,73,69,73,76,80,76,73,78,73,69,73,76,80,76,73,71,69,71,73,76,80,76,73,78,73,69,73,76,80,76,73,71,69,71,73,76,74,76,74,73,71,68,69,71,74,76,74,73,71,68,69,71,73,71,69,71,73,69,71,66,69,64,66,68,69,66,64,68] -12;

		~clock6.notes.durations = [4];

		~clock9 = MyTrack.new(~synth1,9);
		~clock9.notes.freqs = [35,38,35,38,35,38,35,38];
		~clock9.notes.freqs = [35,35,35,35,35,35,35,35];


		~kc = Bus.control(s, 1);
		~kd = Bus.control(s, 1);
		~sy = Synth("mono_eStrings",addAction: \addToTail);
		~sy.set(\fenvIn,~kd);
		~sy.set(\vcaIn,~kc);
		~sy.set(\amp,2);
		~sy.set(\lagtime,0.66);

		~myadsr = MyADSR.new;
		~myadsr.init;
		~myadsr.attack = 2.0;
		~myadsr.decay = 4.0;
		~myadsr.sustain = 0.4;
		~myadsr.release = 1.0;

		~myasr = MyADSR.new;
		~myasr.init;
		~myasr.attack = 1.0;
		~myasr.decay = 4;
		~myasr.sustain = 0.8;
		~myasr.release = 1.0;

		SynthDef(\stringLow, {arg num = 60,gate = 1;
			var env = Env.asr(0,1,0);
			var trig = EnvGen.kr(env, gate,doneAction:2);
			SendReply.kr(trig, '/stringLow', num);
		}).add;

		OSCdef(\stringLow, { |m|

			var num = m[3].asInteger;

			~sy.set(\freq,num.midicps);
			~stringLow_env  = Synth("myADSR",addAction: \addToHead);
			~stringLow_env.set(\out,~kc);
			~myadsr.setADSR(~stringLow_env);

			~stringLow_fenv = Synth("myADSR",addAction: \addToHead);
			~stringLow_fenv.set(\out,~kd);
			~myasr.setADSR(~stringLow_fenv);

			~stringLow_fenv.set(\gate,1);
			~stringLow_env.set(\gate,1);
		}, '/stringLow');



		~channel0 = {arg num, vel = 1;
			var ret;
			num.postln;
			ret = Synth("FMPiano");
			ret.set(\freq,num.midicps);
			ret.set(\gate,1);
			ret.set(\amp,0.8);
			//      ret.set(\dur,0.45);
			ret;
		};


		~channel1 = {arg num, vel = 1;
			var ret;
			num.postln;
			ret = Synth("vangelis");
			ret.set(\freq,num.midicps);
			ret.set(\gate,1);
			ret.set(\amp,0.20);
			ret;
		};


		~channel2 = {arg num, vel = 1;
			var ret;
			num.postln;
			// ret = Synth("eStrings");
			// //	ret = Synth("FMdarkpad");
			// ret.set(\freq,num.midicps);
			// ret.set(\gate,1);
			// ret.set(\amp,1.5);
			// ret.set(\attack,2);
			ret = Synth(\stringLow);
			ret.set(\num,num);
			ret.set(\gate,1);
			ret;
		};

		~channel2off = {arg num, vel = 1;
			var ret = nil;
			~stringLow_fenv.set(\gate,0);
			~stringLow_env.set(\gate,0);
			ret;
		};

		~channel3 = {arg num, vel = 1;
			var ret;
			// num.postln;
			ret = Synth("eStrings");
			ret.set(\freq,num.midicps);
			ret.set(\gate,1);
			ret.set(\amp,2.5);
			ret.set(\attack,2);

			ret;
		};


		~channel4 = {arg num, vel = 1;
			var ret;
			num.postln;
			ret = Synth("eStrings");
			ret.set(\freq,num.midicps);
			ret.set(\gate,1);
			ret.set(\amp,2.5);
			ret.set(\attack,2);
			ret.set(\decay,3);
			ret.set(\sustain,0.3);
			ret.set(\release,0.40);
			ret;
		};



		~channel5 = {arg num, vel = 1;

			var ret;
			num.postln;
			ret = Synth("vangelis");
			ret.set(\freq,num.midicps);
			ret.set(\gate,1);
			ret.set(\amp,0.12);
			ret;
		};

		~channel6 = {arg num, vel = 1;

			var ret;
			num.postln;
			ret = Synth("FMdarkpad");
			ret.set(\freq,num.midicps);
			ret.set(\gate,1);
			ret.set(\amp,0.25);
			ret.set(\attack,2);
			ret;
		};

	)

};
)



~startup.value;
~startTimer.value(120);

~rp = {~start.value;};

~rp = {~clock.transport.play;~clock9.transport.play;~clock2.transport.play};

~myadsr.gui;
~myasr.gui;

~rp = {~clock.transport.play;~clock2.transport.play;~clock3.transport.play;~clock4.transport.play;~clock5.transport.play;~clock6.transport.play;~clock9.transport.play;};

~rp = {~clock.transport.stop;~clock2.transport.stop;~clock3.transport.stop;~clock4.transport.stop;~clock5.transport.stop;~clock6.transport.stop;~clock9.transport.stop;};

~rp = {~clock.transport.play;};
~rp = {~clock9.transport.play;};
~rp = {~clock3.transport.play;};
~rp = {~clock4.transport.play;};
~rp = {~clock5.transport.play;};
~rp = {~clock6.transport.play;};

~rp = {~clock3.transport.play;~clock4.transport.play;~clock5.transport.play;};



~clock2.amp= 0.25;
~clock6.transport.stop;
~clock6.setup
~clock2.transport.stop;;
~rp = {}; // Example

(
~start = {

	var num = 120,timeNow;
	t = TempoClock.default.tempo = num / 60;

	Routine.run({
		s.sync;
		timeNow = TempoClock.default.beats;
		r = Task({
			for (0, 0, { arg i;

				for (0, 7, { arg j;
					~clock.notes.freqs =  ~mels.at(i) ++ ~mels.at(j);
					~clock.notes.init;
					~clock9.notes.init;
					~clock2.notes.init;
					~rp = {~clock.transport.play;~clock9.transport.play;~clock2.transport.play};
					16.wait;
					~rp = {~clock.transport.stop;~clock9.transport.stop;~clock2.transport.stop;};

					4.wait;

				});

			});
		});
		t.schedAbs(timeNow + 8,{ // 00 = Time in beats
			(
				~clock.notes.probs = [1.00,1,0,1,1.00,0,1,0];

				r.play;

				// If yes put stuff Here
			);

			(
				// If No put stuff here otherwise nil
				nil
			);
		};	 // End of if statement

		); // End of t.schedAbs


		//Add more

	}); // End of Routine

}; //End of Start

)


~rp = {~start.value;};
