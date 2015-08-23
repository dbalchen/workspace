~loadSamples = {arg directory;
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

    for(0,qq.size - 1,

      { arg i; 
	qq.put(i,(Buffer.readChannel(s, qq.at(i),channels: [0, 1])));
      }
      );
    qq
      };