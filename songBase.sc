Help.gui
Quarks.gui
GUI.qt

(
 o = Server.local.options;
 o.numOutputBusChannels = 24; // The next time it boots, this will take effect
 o.memSize = 2097152;
 )

"/home/dbalchen/Music/setup.sc".loadPath;

(
 ~startup = {

   (
    // Put stuff here...........
   )

     };
)

~startup.value;
~startTimer.value(60);

~rp = {}; // Example

(
 ~start = {

   var num = 60,timeNow;
   t = TempoClock.default.tempo = num / 60;

   Routine.run({
       s.sync;
       timeNow = TempoClock.default.beats;

       t.schedAbs(timeNow + 00,{ // 00 = Time in beats 
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
