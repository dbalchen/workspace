class Properties < Root
  attr :blank, true
  attr :time_signiture, true
  attr :title, true
  attr :pitch, true
  attr :control, true
 
  def initialize
    super
    @blank = nil
    @title = "UNKNOWN"
    @time_signiture = "4/4"
    @pitch = Pitch.new
    @control = nil
  end
end

class Composition < Properties 
  attr :clockPulsesPerQ, true
  attr :tracks, true
  attr :bpm, true
  attr :click, true
  attr :notesQ, true
  
  def initialize
    super
    @clockPulsesPerQ = 480
    @bpm = 60
    @click = 24
    @notesQ = 8
    @tracks = []
  end
end
