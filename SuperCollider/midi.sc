
Help.gui

s = JStethoscope.defaultServer.boot;
JFreqScope.new( 400, 200, 0 );

MIDIClient.disposeClient;

(
 var inPorts = 1;
 var outPorts = 1;

 MIDIClient.init(inPorts,outPorts); // explicitly intialize the client
 inPorts.do({ arg i; 
       MIDIIn.connect(i, MIDIClient.sources.at(i));
   });
 )



(
 var zz;
 zz=Array.newClear(128);

 MIDIIn.noteOn = {arg src, chan, num, vel;
	 var x;

   if((chan == 0), {

	   ~start.value;
	   /*
       x = Synth("spaceySynth");
       num.postln;
       x.set(\da,1);
       x.set(\freq,num.midicps);
	   */
	   x = 0;
     });

   zz.put(num,x);
 };


 MIDIIn.bend = { arg src,chan,val;


 };


 MIDIIn.noteOff = { arg src,chan,num,vel;
   var a;
   a = zz.at(num);
   a.set(\gate, 0);

 };


 MIDIIn.polytouch = { arg src, chan, num, vel;


 };

 MIDIIn.control = { arg src, chan, num, val; 


 };

 MIDIIn.program = { arg src, chan, prog;


 };

 )
