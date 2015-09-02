
~midiSetup = {
  var inPorts = 2;
  var outPorts = 4;

  MIDIClient.disposeClient;
  MIDIClient.init(inPorts,outPorts); // explicitly intialize the client
  inPorts.do({ arg i; 
	MIDIIn.connect(i, MIDIClient.sources.at(i));
    });
};

~midiSetup.value;

~synth1 = MIDIOut(0);
~synth2 = MIDIOut(1);
~synth3 = MIDIOut(2);
~synth4 = MIDIOut(3);

// Timer code

~startTimer = {arg num;

  t = TempoClock.default.tempo = num / 60;

  ~onbeat = 4;
  ~rp = {};

  a = {
    arg beat;
    beat.postln;
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
	     0.00, // evaluate this immediately
  {
    arg ...args;
    a.value(args[0]); // pass the beat number to our function
    1.0               // do it all again on the next beat
      }
	     );
};


 ~channel0 = {arg num;^nil;};
 ~channel1 = {arg num;^nil;};
 ~channel2 = {arg num;^nil;};
 ~channel3 = {arg num;^nil;};
 ~channel4 = {arg num;^nil;};
 ~channel5 = {arg num;^nil;};
 ~channel6 = {arg num;^nil;};
 ~channel7 = {arg num;^nil;};
 ~channel8 = {arg num;^nil;};
 ~channel9 = {arg num;^nil;};
 ~channel10 = {arg num;^nil;};
 ~channel11 = {arg num;^nil;};
 ~channel12 = {arg num;^nil;};
 ~channel13 = {arg num;^nil;};
 ~channel14 = {arg num;^nil;};
 ~start = {^nil;};

 ~zz=Array.newClear(128);

 for(0,~zz.size - 1,

   { arg i; 
     var za;
     za = Array.newClear(16);
     ~zz.put(i,za); 
   }
   );

 MIDIIn.noteOn = {arg src, chan, num, vel;
	 var x,a;

   src.postln;

   if((chan == 0), {
       x = ~channel0.value(num);

     });

   if((chan == 1), {
       x = ~channel1.value(num);

     });
   if((chan == 2), {
       x = ~channel2.value(num);

     });

   if((chan == 3), {
       x = ~channel3.value(num);

     });

   if((chan == 4), {
       x = ~channel4.value(num);

     });

   if((chan == 5), {
       x = ~channel5.value(num);

     });

   if((chan == 6), {
       x = ~channel6.value(num);

     });

   if((chan == 7), {
       x = ~channel7.value(num);

     });

   if((chan == 8), {
       x = ~channel8.value(num);

     });
   if((chan == 9), {
       x = ~channel9.value(num);

     });

   if((chan == 10), {
       x = ~channel10.value(num);

     });

   if((chan == 11), {
       x = ~channel11.value(num);

     });

   if((chan == 12), {
       x = ~channel12.value(num);

     });

   if((chan == 13), {
       x = ~channel13.value(num);

     });

   if((chan == 14), {
       x = ~channel14.value(num);

     });

   if((chan == 15), {

	   ~start.value;
	   x = 15;

     });

   a = ~zz.at(num);
   a.put(chan,x);
   ~zz.put(num,a);
 };


 MIDIIn.bend = { arg src,chan,val;


 };


 MIDIIn.noteOff = { arg src,chan,num,vel;
   var a,b;
   a = ~zz.at(num);
   b = a.at(chan);
	 /*
   if((chan == 0), {
       ~pulseLeadMono.set(\gate,0);

		 });*/
   
   if(b != nil,{ b.set(\gate, 0);});

 };


 MIDIIn.polytouch = { arg src, chan, num, vel;


 };

 MIDIIn.control = { arg src, chan, num, val; 


 };

 MIDIIn.program = { arg src, chan, prog;


 };

 
