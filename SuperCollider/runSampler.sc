~runSampler = { 
  arg events, sounds, template, name;
  var myTask,sampler;

  events.calcFreq;
  events.freqs.postln;
  events.calcDur;
  events.calcWait;
  events.calcAttack;
  events.calcDecay;

  myTask = Task({
      var num,sus,rel,atc;

      inf.do({ 
	  num =   events.freq.next;
	  sus =   events.duration.next;
	  rel =   events.decay.next;
	  atc =   events.attack.next;

	  if(num.isMemberOf(Integer),
	    { 
	      {var tt = template; tt.value(name,num,sus,rel,atc,sounds,events.amp,events.out);}.fork;
        
	    }, {["rest"].post}); // false action
	  events.wait.next.wait;
	}); 
    }).start};
