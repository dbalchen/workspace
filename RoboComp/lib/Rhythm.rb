require 'Tools.rb'
require 'Motif.rb'

include Math

class Rhythm
  include Tools
  
  attr :time_split, true
  attr :qpm, true
  attr :maxSize, true
  attr :moreBeats, true
  attr :basenote, true
  
  def initialize(seed = nil)
    
    if seed == nil
      @seed = Seed.new
    else
      @seed = seed
    end
    
    @time_split = 2
    @basenote = 60
    
     (@qpm,ugh) = @seed.time_signiture.split(/\//)
    @seed.basetime = 480
    @measureBase = @qpm.to_i * @seed.basetime
    @maxSize = nil
    
    @pattern = basicBeat()
  end
  
  def ll
    puts "Object Type: Rhythm"
    puts " Time Split = #{@time_split}"
    puts " Max Size = #{@maxSize}"
    puts " Base Note = #{@basenote}"
    puts " Masure Base = #{@measureBase}"
  end
  
  def beats(add_beats = 0,max = nil)
    @moreBeats = add_beats
    @maxSize = max
    return self
  end
  
  def basicBeat(bb = 1)
    tpattern = []
    tpattern.push(createNote(0))
    return fixEndT(tpattern,@measureBase)
  end
  
  def get (size = 1)
    motif = Motif.new(@seed)
    motif.notes = fixEndT(clone(@pattern),size * @measureBase)
    motif.setChannel(9)
    return motif
  end
  
  def addBeats(addBeat = 1, motif = nil)
    
    if motif == nil
      tpattern = clone(@pattern)
      sed = @seed.clone
    else
      tpattern = clone(motif.notes)
      sed = motif.seed.clone
    end
    
    pattern_size = tpattern.size
    last_end = tpattern.last.end_time
    
    tmp_pat = clone(tpattern)
    tpat = []
    
    if pattern_size == 1 && addBeat == 1
      multiplier = 3
    else
      multiplier = 4
    end
    
    while tpat.size < multiplier*addBeat
      
      tmp_pat.each {|x|
        noteDis = x.end_time - x.start_time
        tpat.push(createNote(((noteDis)/@time_split) + x.start_time,noteDis))
      }
      
      tmp_pat = clone(tpattern)
      tmp_pat.push(clone(tpat))
      tmp_pat = fixEndT(tmp_pat.flatten,last_end)
    end
    
    if @maxSize == nil || @maxSize > multiplier*addBeat || @maxSize < addBeat
      @maxSize = multiplier*addBeat
      
    elsif @maxSize == -1
      
      @maxSize = addBeat
    end
    
    tpat.sort! do |x,y|
      y.note_distance <=> x.note_distance
    end
    
    tpattern.push(pickFrom(tpat[0,@maxSize],addBeat))
    
    tpattern = fixEndT(tpattern.flatten,last_end)
    
    motif = Motif.new(sed)
    motif.notes = tpattern
    @maxSize = nil
    return motif
    
  end
  
  alias :ab :beats
  private
  
  def createNote(time_start = 0, distance = 0)
    note = Notes.new
    note.start_time = time_start
    note.note = 60
    note.note_distance = distance
    return note
  end
  
end
