(
 ~mchannels = nil;
 ~mnotes = Array.newClear(128);

for(0, ~mnotes.size - 1,

   { arg i; 
      ~mchannels = Array.newClear(16);
      ~mnotes.put(i,~mchannels); 
   }
   );


 MIDIIn.noteOn = {arg src, chan, num, vel;
	 var x,a;

   if((chan == 0), {

      x = Synth("Oboe");
      x.set(\gate,0);
      x.set(\ss,~oboe);
      x.set(\freq,num.midicps);
      ~ds0.filter.setFilter(x);
      ~ds0.envelope.setEnvelope(x);
      x.set(\wrange,0);
      x.set(\amp,~ds0.amp);
      x.set(\da,2);
      x.set(\gate,1);
     });

   if((chan == 1), {

      x = Synth("Oboe");
      x.set(\gate,0);
      x.set(\ss,~oboe);
      x.set(\freq,num.midicps);
      ~ds1.filter.setFilter(x);
      ~ds1.envelope.setEnvelope(x);
      x.set(\wrange,0);
      x.set(\amp,~ds1.amp);
      x.set(\da,2);
      x.set(\gate,1);
     });

   if((chan == 2), {

      x = Synth("Oboe");
      x.set(\gate,0);
      x.set(\ss,~clar);
      x.set(\freq,num.midicps);
      ~vv.filter.setFilter(x);
      ~vv.envelope.setEnvelope(x);
      x.set(\wrange,0);
      x.set(\da,2);
      x.set(\amp,~vv.amp);
      x.set(\gate,1);
     });

   if((chan == 3), {

      x = Synth("Oboe");
      x.set(\gate,0);
      x.set(\ss,~oboe);
      x.set(\freq,num.midicps);
      ~ds1.filter.setFilter(x);
      ~ds1.envelope.setEnvelope(x);
      x.set(\wrange,0);
      x.set(\amp,~ds2.amp);
      x.set(\da,2);
      x.set(\gate,1);
     });
   a = ~mnotes.at(num);
   a.put(chan,x);
   ~mnotes.put(num,a);
 };


 MIDIIn.bend = { arg src,chan,val;


 };


 MIDIIn.noteOff = { arg src,chan,num,vel;
   var a;
   a = ~mnotes.at(num);
   b = a.at(chan);
   b.set(\gate, 0); 

 };


 MIDIIn.polytouch = { arg src, chan, num, vel;


 };

 MIDIIn.control = { arg src, chan, num, val; 


 };

)