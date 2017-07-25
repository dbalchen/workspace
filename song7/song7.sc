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
    "/home/dbalchen/Music/song7/include/synths/tbell.sc".load;
    "/home/dbalchen/Music/song7/include/midiDefs.sc".load;

    // Piano
    ~clock = MyTrack.new(~synth2,0);

    // Bass
    ~clock2 = MyTrack.new(~synth1,1);

    // Low Strings
    ~clock3 = MyTrack.new(~synth2,2);

    // Mid Strings
    ~clock4 = MyTrack.new(~synth2,3);

    // High Strings
    ~clock5 = MyTrack.new(~synth2,4);

    // Vangelis
    ~clock6 = MyTrack.new(~synth2,5);

    // Dark Pad
    ~clock7 = MyTrack.new(~synth2,6);
    
    // Drums
    ~clock9 = MyTrack.new(~synth1,9);

    // Trumpet
    ~clock10 = MyTrack.new(~synth1,10);
		
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

~rp = {~clock10.transport.play;};

~rp =  {~clock10.transport.play;~clock9.transport.play;~clock.transport.play;};

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
 
       t.schedAbs(timeNow + 8,{ // 00 = Time in beats
	   (
	    
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
