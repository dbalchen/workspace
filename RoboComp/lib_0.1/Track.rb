class Track < Properties
  attr :instrument, true
  attr :notes, true
  attr :channel, true
  def initialize
    super
    @instrument = "piano"
    @notes = []
    @channel = 0
  end

  def clear(notes = @notes,dnote =0)

    notes.each{|x| x.note = dnote}
    last = normalize(notes)

    for i in 0...(notes.size - 1)
      notes[i].duration = notes[i+1].start_time - notes[i].start_time
    end

    notes.last.duration = 1.0 - notes.last.start_time

    notes = streach(last.to_f,notes)
    @notes = notes

  end

  def normalize(notes = @notes)
    last = (notes.last.start_time + notes.last.duration).ceil
 #   notes = streach((1/last).to_f,notes)
    return last
  end

  def streach (amt = 1,notes = @notes)
    notes.each{|x| x.start_time = x.start_time*amt; x.duration = x.duration*amt}
    return notes
  end

  def fixEndT(notes = @notes)
    return notes if notes.size == 0

    final_end = normalize(notes.clone)

    notes.sort! { |x,y|
      x.start_time <=> y.start_time
    }

    tmp = []
    xx = []
    xx = notes.collect{|x| x.start_time}
    xx.uniq!

    xx.each {|x|
      yy = notes.select{|y| y.start_time == x }
      tmp.push(yy)
    }

    for i in 0...(tmp.size - 1)
      tmp[i].each { |x|
        x.duration = (tmp[i+1][0].start_time - x.start_time)
      }
    end

    tmp.last.each{|x| x.duration = (final_end - x.start_time)}
    notes = tmp.flatten

    return notes

  end
end