


~stringbass = Buffer.read(s, "/home/dbalchen/Music/Song#6VariationsBbMajor/tracks/Song6c/BestBass.wav");
~stringbassOut = 0;
~bassamp = 0.17;
~playStringbass = { arg out = 0, amp = 0.25;
 var sig;
 sig = PlayBuf.ar(2,~stringbass, BufRateScale.kr(~stringbass)*(1), loop:0);
 sig = Splay.ar(~bassamp*sig,0,1,0);
 Out.ar(~stringbassOut,sig);
};


//~playStringbass.play;

