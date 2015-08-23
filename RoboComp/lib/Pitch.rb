require 'Tools.rb'

class Pitch
  # Contains all Pitch information
  include Tools
  attr :pitchrange, true
  attr :toneRow
  @keys
  @modes
  attr :mode
  attr :key
  attr :pitchroots, true
  attr :invpitchrange, true
  
  def initialize (key = "C", mode = "MAJOR",toneRow = [0,2,4,5,7,9,11])
    
    @keys = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
    @modes = ["MAJOR","DORIAN","FRIDGIAN","LYDIAN","MIXOLYDIAN","MINOR","LOCRIAN"]
    setProps(key,mode,toneRow)
    
  end
  
  def ll
    puts "Object Type: Pitch"
    puts " Key = #{@key}"
    puts " Mode = #{@mode}"
    puts " Tone row = #{@toneRow}"
  end
  
  def setProps(key = "C", mode = "MAJOR",toneRow = [0,2,4,5,7,9,11])
    @key = key
    @mode = mode
    @toneRow = toneRow
    
    mode_index = @modes.index(mode)
    key_index =  @keys.index(@keys.at(@keys.index(key) - @toneRow.at(mode_index)))
    
    @toneRow.each_with_index {|x,ii| @toneRow[ii] = x + key_index}
    
    @pitchrange = pitchRange  @toneRow
    
    for i in 0...mode_index
      @pitchroots.push(@pitchroots.shift)
    end
  end
  
  def noteBuild (tones = nil)
    
    if tones.instance_of? Motif
      tones = tones.notes
      tones = tones.map{|x| x.note }
    end
    
    tones = clone(tones)

    tones = (tones.map{|x| x.modulo(12)}).uniq.sort {|x,y| x <=> y}
    #    tones.sort! {|x,y| x <=> y}
    
    normalForm = []
    #    normalForm.push(tones[-1] - tones[0])
    num = tones.size
    diff = 100
    for i in 0...num do  
      if (tdiff = (tones.last - tones.first)) <= diff then
        normalForm.push(tones.clone)  
        diff = tdiff
      end    
      tones.push(tones[0] + 12); tones.shift    
    end
    
    while(num > 0 && normalForm.size != 1)
      
      normalForm.sort!{|x,y| (x[num-1] - x.first) <=> (y[num-1] - y.first)}
      diff = normalForm[0][num-1] - normalForm[0].first
      normalForm = normalForm.find_all do |x| 
        (x[num-1] - x.first) <= diff;
      end
      num = num -1
    end
    #   tones.sort! {|x,y| x <=> y}
    #   low = tones.first
    relKey = @keys[normalForm[0].first]
    
    tones = normalForm[0].collect{|x| (x - normalForm[0].first)}
    return Pitch.new(relKey,"MAJOR",tones)
  end
  
  def set
    
    selection = nil
    while selection != ""
      
      puts "Set the Pitch object"
      puts " 1. Set Key"
      puts " 2. Set Mode"
      puts " 3. Set Tone Row"
      
      print "Make a selection ==> "
      selection = gets.chomp
      
      if selection == "1" then
        print " Enter in the Key ==> "
        @key = gets.chomp
        
      elsif selection == "2" then
        print " Enter in the Mode ==> "
        @mode = gets.chomp
        
      elsif selection == "3" then
        print " Enter in the Tone Row ==> "
        @toneRow = gets.chomp.to_a
      else
        return
      end
    end
    setProps(@key,@mode,@toneRow)
  end
  
  def randomPitch(rList,low = 0, high = 120)
    random = -1
    while random < low || random > high
      random = rList[rand(rList.length)]
    end
    random
  end
  
  def quantizeNotes(noteList, trange = nil)
    
    if trange == nil
      trange = @pitchrange
    end
    
    for i in 0...noteList.length
      min = 1000
      otone = 0
      trange.each do |y|
        diff = (y.to_i - noteList[i].note.to_i).abs
        if diff < min
          otone = y
          min = diff
        end
      end
      noteList[i].note = otone
    end
    
    return noteList
  end
  
  def pitchRange(trow)
    
    @pitchroots = pitchRoots(trow)
    
    trange = clone(@pitchroots)
    trange.flatten!
    trange.sort! do |x,y|
      x <=> y
    end
    
    @invpitchrange = invArray(trange)
    
    return trange
  end
  
  def pitchRoots(trow)
    
    toneroots = []
    trow.each { |x|
      toneroots.push(findroots(x))
    }
    
    return toneroots
  end
  
  private
  
  def findroots(r = 0)
    
    roots = []
    fx = r - 12*(r.to_f/12.00).ceil
    
    while fx <= 120
      if fx >= 0
        roots.push(fx)
      end
      fx = fx + 12
    end
    
    return roots
  end
  
end
