SimpleMix {
  var <>balance=0, <>mixer = nil, name = "mixer";

  gui {
    var envWin, nb1, sl1;

    envWin = Window.new(name,Rect(200,200,305,155)).front;
    StaticText( envWin, Rect(4, 4, 50, 25 )).align_( \left ).string_( "Bal:" );

    balance = 0.5;

    nb1 = NumberBox(envWin, Rect(240, 4, 53, 25)).value_((2*balance)-1);
    nb1.action_({
	sl1.value_(1/((nb1.value*2)-1));
	balance = sl1.value;
        if(mixer != nil,
          {mixer.set(\bal,balance);});

      });

    sl1 = Slider(envWin, Rect(35, 9, 200, 15))
      .value_(1/((nb1.value*2)-1))
      .action_({
	  nb1.value_((sl1.value*2)-1);
	  balance = nb1.value;
	  if(mixer != nil,
	    {mixer.set(\bal,balance);});
	});

    setMixer
      { 
	arg mix;
	mix.set(\bal,balance);
      }

  }
}
