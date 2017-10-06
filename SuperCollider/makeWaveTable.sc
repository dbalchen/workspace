
~convert2Table = { arg floatArray;

		   var a;

		   a = floatArray.resamp1(8192); 
		   a = a.as(Signal); 
		   a = a.asWavetable; 
		   Buffer.loadCollection(s, a);

};

~makeWav = {
  arg wavefile;
  var f, a;
  f = SoundFile.openRead(wavefile.standardizePath);
  a = FloatArray.newClear(f.numFrames); 
  f.readData(a);
  ~convert2Table.value(a);
};


~fileList = {arg directory;
	     var p,qq, l,dir;

	     dir = "ls " ++ directory ++ "/*wav";
	     qq = Array.new(128);
	     p = Pipe.new(dir, "r"); // list directory contents in long format

	     l = p.getLine; // get the first line
	     while({l.notNil}, {

		 l.postln;
		 qq.add(l); 
		 l = p.getLine; 

	       }
	       ); // post until l = nil

	     p.close; // close the pipe to avoid that nasty buildup
	     qq
};


~loadWaveTables = {arg tables;

		   var prime;

		   prime =  ~makeWav.value(tables.at(0));

		   for(1,tables.size - 1,

		     { arg i; 
		       ~makeWav.value(tables.at(i));  
		     }
		     );
		   prime;
};




~loadSerumWaveTable = {arg ff;

   var prime, f, a, frames;

   frames = ff.numFrames/2048;

   a = FloatArray.newClear(2048); 
   ff.readData(a);
   prime = ~convert2Table.value(a);
	
   (frames-1).do( {
	 a = FloatArray.newClear(2048); 
	 ff.readData(a);
	 ~convert2Table.value(a);
   });
	  
	prime;
};
