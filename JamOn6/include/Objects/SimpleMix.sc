SimpleMix {
  var <>balance=0, <>mixer = nil, name = "mixer";

  gui {
    var envWin, nb1, sl1;

    envWin = Window.new(name,Rect(200,200,305,55)).front;
    StaticText( envWin, Rect(4, 4, 50, 25 )).align_( \left ).string_( "Bal:" );

    nb1 = NumberBox(envWin, Rect(240, 4, 53, 25)).value_(balance);
    nb1.action_({
	sl1.value_((nb1.value/2) + 0.5);
	balance = nb1.value;
    this.setMixer.value;

      });

    sl1 = Slider(envWin, Rect(35, 9, 200, 15))
      .value_(((nb1.value/2)+0.5))
      .action_({
	  nb1.value_((sl1.value*2)-1);
	  balance = nb1.value;
	  this.setMixer.value;
	});
  }
  setMixer
    { 
      arg mix;
	  balance.postln;
	  	  if(mixer != nil,
	    {mix = mixer;});
      mix.set(\bal,balance);
    }
}
