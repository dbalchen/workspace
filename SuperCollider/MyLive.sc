// =====================================================================
// MyLive Class
// =====================================================================


MyLive {
  var  <>freqs = nil,     <>freq = nil,
       <>probs = nil,     <>prob = nil,
       <>waits = nil,     <>wait = nil,
       <>durations = nil, <>duration = nil,
       <>attacks = nil,   <>attack = nil,
       <>decays = nil,    <>decay = nil, 
       <>out = 0,         <>amp = 1;

  init {

    freqs = [1];
    probs = [1];
    waits = [1];
    durations = [1];
    attacks = [0];
    decays = [0];

  }
  calcFreq {
    var lazy;

    lazy = Plazy({
	var ary,flip,fre;

	if(freqs.size >= probs.size,{ary = Array.newClear(freqs.size);},{ary = Array.newClear(probs.size);});

	probs.do({ arg item, i;
	    flip =  rrand(0.0, 1.0);
	    if(item >= flip,{ary.put(i,1);},{ary.put(i,0);})
	      });

	fre = freqs*ary;

		
	fre.do({ arg item, i;
	 if(item.isKindOf(Array),{
		if(item.at(0) == 0,{fre.put(i,\rest)};)});
	    if(item == 0,{fre.put(i,\rest);});
	  });
		
	Pseq(fre,1);
      });

    freq = Pn(lazy,inf).asStream;
  }

  calcDur {
    var lazy;

    lazy = Plazy({
	Pseq(durations,1);
      });

    duration = Pn(lazy,inf).asStream;
  }

  calcWait {
    var lazy;

	lazy = Plazy({
    Pseq(waits,1);
	}); 

	wait =Pn(lazy,inf).asStream;
    
  }

  calcAttack {
    var lazy;

    lazy = Plazy({
	Pseq(attacks,1);
      });

    attack = Pn(lazy,inf).asStream;
  }

  calcDecay {
    var lazy;

    lazy = Plazy({
	Pseq(decays,1);
      });

    decay = Pn(lazy,inf).asStream;
  }
  
}





