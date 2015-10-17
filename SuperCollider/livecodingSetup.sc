// =====================================================================
// Nature CallS
// =====================================================================

Help.gui
Quarks.gui

(
o = Server.local.options;
o.numOutputBusChannels = 24; // The next time it boots, this will take effect
o.memSize = 65536; 
)

(

 var inPorts = 1;
 var outPorts = 1;

 MIDIClient.disposeClient;
 MIDIClient.init(inPorts,outPorts); // explicitly intialize the client
 inPorts.do({ arg i; 
       MIDIIn.connect(i, MIDIClient.sources.at(i));
   });
 )


(
// Attach to MIDI Destinations
i = MIDIClient.destinations[7];  // <-- fix to suit your needs
m = MIDIOut(0,i.uid); 

)

(
// Load all Intruments
)


// Timer code
(
 ~startTimer = {

   t = nil;
   t = TempoClock.default.tempo = 60 / 60;


   t.clear;

   ~onbeat = 4;

   ~rp = {};

   a = {
     arg beat;

     if(beat % ~onbeat == 0, {
	 Routine.run({
	     s.sync;
	     ~rp.value;
	     ~rp={};
         ~onbeat = 4;
	   });
       });
   };

   t.schedAbs(
	      0, //evaluate this immediately
	      {
		arg args;
		a.value(args[0]); // pass the beat number to our function
		1.0               // do it all again on the next beat
		  }
	      );
 };
 )
