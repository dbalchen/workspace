
//Figure 4: Onsets

Help.gui;

MIDIClient.disposeClient;

(
 var inPorts = 1;
 var outPorts = 1;

 MIDIClient.init(inPorts,outPorts); // explicitly intialize the client
 inPorts.do({ arg i; 
       MIDIIn.connect(i, MIDIClient.sources.at(i));
   });
 )


MIDIClient.list.destinations.collect(_.name);

//i = MIDIClient.destinations[0];  // <-- fix to suit your needs
//m = MIDIOut(0,i.uid); 

m = MIDIOut(0);

// Prepare the buffer
d = Buffer.read(s,"/home/dbalchen/Music/BaBmix/soloTemp.wav");
b = Buffer.alloc(s, 2048);


// Check Sensitivity

(
 ~xx = ({
     var sig, chain, onsets, pips, trigger, sensitivity;
     sensitivity = 0.1;	
	 //     sig = PlayBuf.ar(1,d.bufnum,BufRateScale.kr(d.bufnum),1,0,1);

    sig = SoundIn.ar(0);
     chain = FFT(b, sig);
     onsets = Onsets.kr(chain, sensitivity, \complex);
	 trigger= SendTrig.kr(onsets);
     pips = SinOsc.ar(880, 0, EnvGen.kr(Env.perc(0.001, 0.1, 0.2), onsets));
     Out.ar(0, ((sig * 0.3) + pips).dup);
   
   });
 )

(
 // register to receive message
 a= OSCresponder(s.addr,'/tr',{ arg time,responder,msg;
     fork{m.noteOn(0, 60, 100); (0.09).wait; m.noteOff(0, 60, 60);};
   }).add;
 )


~xx.play;

