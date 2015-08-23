require 'Tools.rb'
require 'MarcoPolo.rb'

class Motif
  include Tools
  
  attr :title, true
  attr :instrument, true
  attr :notes, true
  attr :seed, true
  attr :loop, true
  attr :next_start, true
  attr :channel, true
  
  def initialize (seed = nil,title = "Unknown")
    
    if seed == nil
      @seed = Seed.new
    else
      @seed = seed.clone
    end
    
    @title = title
    @instrument = 0
    
     (num,ugh) = @seed.time_signiture.split(/\//)
    @seed.basetime = 480
    @measureBase = num.to_i * @seed.basetime
    @channel = 0
    
  end
  
  def calcLength()
    @motif_length = find_end(self.notes)
  end
  
  def ll ()
    puts "Object Type: Motif"
    puts " Title = #{@title}"
    puts " Instrument = #{@instrument}"
    @seed.ll
  end
  
  def set
    
    selection = nil
    while selection != ""
      
      puts "Set the Motif object"
      puts " 1. Set Title"
      puts " 2. Set Instrument"
      puts " 3. Set Seed"
      puts " 4. Set Channel"
      
      print "Make a selection ==> "
      selection = gets.chomp
      
      if selection == "1" then
        print " Enter in the Title ==> "
        @title = gets.chomp
        
      elsif selection == "2" then
        if @channel == 9
          system "cat /home/dbalchen/workspace/RoboComp/extras/DrumInst.txt"
        else
          system "cat /home/dbalchen/workspace/RoboComp/extras/midiInst.txt"
        end
        print " Enter in the Instrument ==> "
        @instrument = gets.chomp.to_i
        @instrument += -1 if @channel != 9
        @notes.each {|x| x.note = @instrument} if @channel == 9
        
      elsif selection == "3" then
        @seed.set
        
      elsif selection == "4" then
        print " Enter channel number ==> "
        setChannel(gets.chomp.to_i)
        
      else
        return
      end
    end
  end
  
  def setChannel(channel)
    @channel = channel
    @notes.each{|x| x.channel = @channel}
  end
  
  def + (section)
    add(section,0)
  end
  
  def  % (section)
    add(section,1)
  end
  
  def add (section, endT =0)
    motif = Motif.new(@seed)
    if section.instance_of? Motif
      
      tnotes = clone(@notes)
      
      lastM = find_end(tnotes,endT)
      
      section.notes.each{|x|
        lnote = x.clone
        lnote.start_time = x.start_time + lastM
        lnote.end_time = x.end_time + lastM
        tnotes.push(lnote)
      }
      
    end
    
    motif.notes = tnotes
    return setChanInst(motif)
  end
  
  def * (num)
    
    motif = Motif.new(@seed)
    motif.notes = clone(@notes)
    
     (num - 1).times do
      motif = motif + self
    end
    
    return setChanInst(motif)
  end
  
  def ch
    return self.tr(2,-5) & self.tr(4,-3)
  end
  
  def ch7
    return self.tr(2,-5) & self.tr(4,-3) & self.tr(6,-1)
  end
  
  def | (section)
    motif = Motif.new(@seed)
    
    if section.instance_of? Rhythm
      motif = section.addBeats(section.moreBeats,self)
    end
    
    if section.instance_of? Melody
      motif = section.addTones(self)
    end
    
    motif.instrument = @instrument
    return motif
  end
  
  def merge(section = self, setChan = true)
    tmp = []
    if section.instance_of? Motif
      motif = Motif.new(@seed)
      pt = clone(section.notes)
      
      tmp.push(self.notes)
      tmp.push(pt)
      
      tmp.flatten!
      
      tmp.sort! do |x,y|
        x.start_time <=> y.start_time
      end
      motif.notes = tmp
      
      return fixDur(motif,setChan)
    end
  end

  def & (section)
    merge(section)
  end
  
  def keepr(*clr)
    b = []
    xx = @notes.collect{|x| x.start_time}
    xx.uniq!
    
    if clr.size == 0 then
      clr[0] = 1
      clr[1] = xx.length
    end
    
    for i in 1..xx.length
      if !clr.include?(i)
        b.push(i)
      end
    end
    
    rm(*b)
  end
  
  def keep(*clr)
    
    
    b = []
    xx = @notes.collect{|x| x.start_time}
    xx.uniq!
    
    if clr.size == 0 then
      clr[0] = 1
      clr[1] = xx.length
    end
    
    for i in 1..xx.length
      if !clr.include?(i)
        b.push(i)
      end
    end
    
    clear(*b)
  end
  
  def clear(*clr)
    
    motif = Motif.new(@seed)
    tnotes = clone(@notes)
    
    if clr.size == 0 then
      tnotes.each {|x| x.channel = 9}
    else
      
      xx = tnotes.collect{|x| x.start_time}
      xx.uniq!
      
      clr.each  do |x|
        
        tnotes.each{ |y| y.channel = 9 if y.start_time == xx[x-1]}
        
      end
      
    end
    
    motif.notes = tnotes
    motif.instrument = @instrument
    return motif
  end
  
  def subtract(section, setChan = true)
    motif = Motif.new(@seed)
    n1 = clone(@notes)
    
    xx = n1.collect{|x| x.start_time}
    xx.uniq!
    
    n2 = clone(section.notes)
    
    yy = n2.collect{|x| x.start_time}
    yy.uniq!
    
    xx.each {|x|
      n2.delete_if{|z| z.start_time ==  x} 
    }
    
    yy.each {|y| 
      n1.delete_if{|z| z.start_time ==  y}
      
    }
    tmp = []
    tmp.push(n1)
    tmp.push(n2)
    
    tmp.flatten!
    
    tmp.sort! do |x,y|
      x.start_time <=> y.start_time
    end
    motif.notes = tmp
    return fixDur(motif,setChan)
  end
  
  def - (section)
    return subtract(section)
  end
  
  def rrm(numr = 0)
    
    if numr == 0 then
      
      if @notes == 3 then 
        return rm(1)
      else
        numr = rand(@notes.size - 2)
        numr = 1 if numr == 0
      end
    end
    
    numr = @notes.size-2 if numr > (@notes.size-2)
    return self if numr < 1
    
    
    picks = []
    picks = pickNumbers(1,@notes.size-1,numr)
    return rm(*picks)
    
  end
  
  def flatten(selection)
    flat = subtract(selection,false)
    return merge(flat,false)
  end
  
  def rm(*clr)
    
    return self if clr.size == 0
    tmpNotes = clone(@notes)
    
    xx = tmpNotes.collect{|x| x.start_time}
    xx.uniq!
    
    clr.each  do |x|
      tmpNotes.delete_if {|y| y.start_time == xx[x-1]}
    end
    
    return fixDur(tmpNotes)
  end
  
  def fixDur(section = self, setChan = true)
    
    if section.instance_of? Motif
      section = section.notes
    end
    
    motif = Motif.new(@seed)
    last_end = find_end(section)
    motif.notes = fixEndT(clone(section), last_end)
    
    return setChanInst(motif) if setChan == true
    return motif
  end
  
  def get (*ess)
    
    ess[0] = 1 if ess.size == 0
    
    ess.each_with_index{ |x,i| ess[i] = x.to_a if x.instance_of? Range}
    
    ess.flatten!
    
    motif = Motif.new(@seed)
    tNotes = []
    
    ess.each {|x|
      tstart = (x -1) * @measureBase
      tend = x * @measureBase
      
      lastM = find_end(tNotes)
      
      @notes.each {|y|
        if y.start_time >= tstart && y.start_time < tend
          lnote = y.clone
          lnote.start_time = (y.start_time - tstart) + lastM
          lnote.end_time = (y.end_time - tstart) + lastM
          tNotes.push(lnote)
        end
      }
      
    }
    
    motif.notes = tNotes
    
    return setChanInst(motif)
  end
  
  def find_end (tNotes,endt = 0)
    
    if tNotes.last == nil
      lastM = 0
    else
      lastM = 0
      if endt == 1
        until lastM >= tNotes.last.end_time do
          lastM += @measureBase
        end
      else
        until lastM > tNotes.last.start_time do
          lastM += @measureBase
        end
      end
    end
    
    return lastM
  end
  
  def rperm()
    perm("rhythm")
  end
  
  def perm (permType = "tone")
    
    permutation = Motif.new(@seed)
    
    notes = clone(@notes)
    
    beat_start = notes.first.start_time
    endTime = notes.last.end_time
    
    tmpTones = []
    
    while notes.size > 0
      random = rand(notes.size)
      tmpNote = clone(notes[0])
      if permType == "tone"
        tmpNote = clone(notes[0])
        tmpNote.note = notes[random].note
        notes[random].note = notes[0].note
      else
        tmpNote.start_time = beat_start
        tmpNote.end_time = beat_start + notes[random].duration
        beat_start = tmpNote.end_time
        notes[random].end_time =  notes[random].start_time + notes[0].duration
      end
      
      tmpTones.push(tmpNote)
      notes.delete_at(0)
    end
    
    tmpTones.last.end_time = endTime
    
    permutation.notes = tmpTones
    
    return setChanInst(permutation)
  end
  
  def rmarkov(order = 1)
    markov(order,"rhythm")
  end
  
  def markov(order = 1,aspect = "tone")
    
    marko = Motif.new(@seed)
    
    notes = clone(@notes)
    
    tmpTones = []
    
    if aspect == "tone"
      notes.each {|x| tmpTones.push(x.note)}
    else
      notes.each {|x| tmpTones.push(x.duration)}
    end
    
    marcopolo = MarcoPolo.new(order)
    marcopolo.marco(tmpTones)
    polo = marcopolo.polo
    
    if aspect == "tone"
     (polo).each_with_index {|x,idx| notes[idx].note = x}
    else
      endTime = notes.last.end_time
      polo.each_with_index {|x,idx|
        break unless (idx+1) < notes.size && notes[idx].start_time < endTime
        notes[idx].end_time = notes[idx].start_time + x
        notes[idx + 1] .start_time  = notes[idx].end_time
      }
      notes.last.end_time = endTime
    end
    
    marko.notes = notes
    return setChanInst(marko)
    
  end
  
  def rhythm_retrograde(type = "rhythm")
    retrograde(type)
  end
  
  def retrograde(type = "tones")
    
    retr = Motif.new(@seed)
    notes = clone(@notes)
    
    tmpTones = []
    
    if type == "tones"
      notes.each {|x| tmpTones.push(x.note)}
    else
      tmp = []
      xx = notes.collect{|x| x.start_time}
      xx.uniq!
      
      xx.each {|x|
        yy = notes.select{|y| y.start_time == x }
        tmp.push(yy)
        tmpTones.push(yy[0].duration)      
      }
    end
    
    tmpTones.reverse!
    
    if type == "tones"
      notes.each_with_index {|x,idx| x.note = tmpTones[idx]}
    else
      
      yy = tmp[0]
      yy.each {|x| x.end_time = tmpTones[0] + x.start_time}
      
      for i in 1...tmpTones.size
        
        yy = tmp[i]
        yy.each {|y|
          
          y.start_time = tmp[i-1][0].end_time
          y.end_time = tmpTones[i] + y.start_time
          
        }
        
      end
      
      notes = tmp.flatten
    end
    
    retr.notes = notes
    
    return setChanInst(retr)
    
  end
  
  def strict_invert(type = "strict")
    invert(type)
  end
  
  def invert (type = "melodic")
    
    invc = Motif.new(@seed)
    notes = clone(@notes)
    tmpTones = []
    
    for i in 1...notes.length
      
      if type == "melodic"
        trange = @seed.tones.pitchrange
        trangeInv = invArray(trange)
        tmpTones.push(trange[calcDis(trangeInv[notes[0].note],trangeInv[notes[i].note])])
      else
        tmpTones.push(calcDis(notes[0].note,notes[i].note))
      end
      
    end
    
    for i in 1...notes.length
      notes[i].note = tmpTones[i-1]
    end
    
    invc.notes = notes
    return setChanInst(invc)
  end
  
  def transpose (*distances)
    
    tran = Motif.new(@seed)
    notes = clone(@notes)
    invRange = invArray(@seed.tones.pitchrange)
    
    notes.each do|x|
    begin
      
      if distances.empty?
        dis = 1
      else
        dis = distances[rand(distances.length) - 1]
      end
      
      t = invRange[x.note] + dis
      x.note = @seed.tones.pitchrange[t]
    rescue
      x.note = x.note + dis
    end
  end
  
  tran.notes = notes
  return setChanInst(tran)
end

def strict_transpose (*distances)
  
  tran = Motif.new(@seed)
  notes = clone(@notes)
  
  notes.each  do |x|
    if distances.empty?
      dis = 1
    else
      dis = distances[rand(distances.length) - 1]
    end
    x.note = x.note + dis
  end
  
  tran.notes = notes
  return setChanInst(tran)
end

def setChanInst(p)
  p.setChannel(@channel)
  p.instrument = @instrument
  return p
end


def split(motif = self)
  motif_array = []
  
  notes  = (motif.notes.collect{|x| x.note}).uniq
  
  notes.each { |x|
    
    tmpArray =  motif.notes.select{|y| y.note == x}
    
    motif_array.push(fixDur(tmpArray))
    
  }
  
  return motif_array
end

def union (motif = self)

end

def pitchSet ()
  seed.tones = seed.tones.noteBuild(self)
end

alias :tr :transpose
alias :str :strict_transpose
alias :ret :retrograde
alias :rret :rhythm_retrograde
alias :inv :invert
alias :sinv :strict_invert
alias :marco :markov
alias :rmarco :rmarkov
alias :per :perm
alias :rper :rperm
end

