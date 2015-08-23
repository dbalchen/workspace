// =====================================================================
// MyEvents Class
// =====================================================================


MyEvents {
  var  <>freqs = nil,     <>freq = nil,
       <>probs = nil,     <>prob = nil,
       <>waits = nil,     <>wait = nil,
       <>durations = nil, <>duration = nil,
       <>out = 0,         <>amp = 0.2,  
       <>filter = nil,    <>envelope = nil,
       <>lag = 0.5,       <>osc = nil;
  init {

	filter = MyFilter.new;
        envelope = MyEnv.new;

   	if(freqs == nil,
	    {freqs = [60,60,60,60]; });

   	if(probs == nil,
	    {probs = freqs.deepCopy.collect{|x| if(x == 0,{x = 0;},{x = 1;})}});

   	if(waits == nil,
	    {waits = Array.newClear(freqs.size).fill(1); });

	if(durations == nil,
	    {durations = waits.deepCopy; }); 

    this.calcFreq.value;
    this.calcDur.value;
    this.calcWait.value;
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


  
}





