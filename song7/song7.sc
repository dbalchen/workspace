Help.gui
Quarks.gui

s.boot;
s.plotTree;
s.meter;
s.quit;

FreqScope.new(400, 200, 0, server: s);
Server.default.makeGui


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
    ~scale = Scale.majorPentatonic.degrees.collect({ arg item, i; item; item}) + 72;
		
    ~clock = MyTrack.new(~synth2,0);
    ~clock.notes.probs = Bjorklund(15, 32);
    ~clock.notes.freqs = ~clock.notes.probs.collect({ arg item, i; item; item*~scale.choose});

	   
    ~clock.notes.waits = [ 1, 1, 1, 1, 1, 1, 1, 1 ] * 0.250;


    ~ms = MarkovSet([
		     [69,[73,76]],
		     [73,[74]],
		     [74,[69]],
		     [76,[81]],
		     [81,[78]],
		     [78,[74]]
		     ]);

    ~ms = MarkovSet([
		     [67,[69]],
		     [69,[73,76,71,74]],
		     [70,[77]],
		     [71,[74,76,67,73,69,73,79]],
		     [72,[69,77]],
		     [73,[69,74,71,76,73,78]],
		     [74,[76,69,70,79]],
		     [76,[72,73,71,81,77,69]],
		     [77,[81,72,74]],
		     [78,[73,74]],
		     [79,[71,78]],
		     [80,[76]],
		     [81,[76,82,80]],
		     [82,[77]]
		     ]);

    ~ms.makeSeeds;
    ~xS = ~ms.asStream;

    ~clock.notes.freqs = Array.fill(8, {~xS.next(76).postln});
		
    ~mels = Array.new(128);
    ~mels.add([69,73,74,69,76,81,78,74]);
    ~mels.add([69,73,76,71,76,81,80,76]);
    ~mels.add([73,74,76,73,71,69,71,73]);
    ~mels.add([73,69,74,76,71,67,69,74]);
    ~mels.add([76,72,69,74,69,76,77,81]);//
    ~mels.add([77,81,82,77,72,77,74,70]);
    ~mels.add([79,71,74,79,71,79,78,74]);
    ~mels.add([80,76,73,78,73,69,73,76]);
    ~clock.notes.freqs =  ~mels.at(7);

	   
    ~clock.notes.freqs =  (~mels.choose ++ ~mels.choose);
    ~clock.notes.freqs =  ~mels.at(4) ++ ~mels.at(3);
    ~clock.notes.freqs = ~mels.at(0) ++ ~mels.choose;


    ~clock.notes.freqs = [69,73,74,69,76,81,78,74,80,76,73,78,73,69,73,76,69,73,74,69,76,81,78,74,80,76,73,78,73,69,73,76,80,76,73,78,73,69,73,76,80,76,73,71,69,71,73,76,80,76,73,78,73,69,73,76,80,76,73,71,69,71,73,76,74,76,74,73,71,68,69,71,74,76,74,73,71,68,69,71,73,71,69,71,73,69,71,66,69,64,66,68,69,66,64,68];
 
    
    ~clock.notes.probs = [1.00,1,0,1,1.00,0,1,0] * 1.00;
    ~clock.notes.probs = [1.00,1,0.5,1,1.00,0.5,1,0.33] * 1.00;  
    ~clock.notes.probs = [1.00,1,0,0,1.00,0,0,0] * 1.00;
    ~clock.notes.probs = [1.00,1,0,0,0,0,0,0] * 1.00;
    ~clock.notes.probs = [1,0,0,0,1,0,0,0];
    ~clock.notes.probs = [1.00,0.66,0.5,0.50,1.00,0.50,0.66,0.33] * 5.00;
    
    ~clock.notes.durations = [0.25];

		
    ~clock2 = MyTrack.new(~synth1,9);
    ~clock2.notes.freqs = [35,35,35,35,35,35,35,35];
    ~clock2.notes.freqs = [35,38,35,38,35,38,35,38];
    ~clock2.notes.probs = [1,0,1,0,1,0,0,0];
    ~clock2.notes.probs = [ 1, 0, 0, 0, 0, 0, 0, 0 ];
    ~clock2.notes.probs =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];
	
    ~clock3 = MyTrack.new(~synth2,1);
    ~clock3.notes.waits =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];
    ~clock3.notes.probs = [ 1, 0, 0, 0, 0, 0, 0, 0 ];
    ~clock3.notes.probs = [1,0,1,0,1,0,0,0];
    ~clock3.notes.probs = [1,0,1,0,1,0,1,0];
    ~clock3.notes.probs = [1.00,1,0,1,1.00,0,1,0] * 1.00;
    ~clock3.notes.probs = [1.00,1,0.5,1,1.00,0.5,1,0.33] * 1.00;  
    ~clock3.notes.probs =  [ 1, 1, 1, 1, 1, 1, 1, 1 ];

    ~clock3.notes.freqs = [45,41,40,45,38,33,36,40];

    ~clock3.notes.freqs = [45,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,45,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,57,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,57,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,52,0,0,0,0,0,0,0,49,0,0,0,0,0,0,0,45,0,0,0,0,0,0,0];

    ~clock3.notes.durations = [8];
    ~clock3.notes.durations = [1];




    ~channel0 = {arg num, vel = 1;
      var ret;
      num.postln;
      ret = Synth("FMPiano");
      ret.set(\freq,num.midicps);
      ret.set(\gate,1);
      ret.set(\amp,0.3);
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
      ret = Synth("eStrings");
      ret.set(\freq,num.midicps);
      ret.set(\gate,1);
      ret.set(\amp,2.5);
      ret;
    };

    )

     };
 )



~startup.value;
~startTimer.value(120);

~rp = {~start.value;};

~rp = {~clock.transport.play;~clock2.transport.play;~clock3.transport.play};
~rp = {~clock.transport.play;};
~rp = {~clock2.transport.play;};
~rp = {~clock3.transport.play;};

~clock3.amp= 0.25;
~clock3.setup
~clock3.transport.stop;;
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
		   ~clock2.notes.init;
		   ~clock3.notes.init;
		   ~rp = {~clock.transport.play;~clock2.transport.play;~clock3.transport.play};
		   16.wait;
		   ~rp = {~clock.transport.stop;~clock2.transport.stop;~clock3.transport.stop;};

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
