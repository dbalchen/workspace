require 'Rhythm.rb'
require 'Melody.rb'
require 'Pitch.rb'

class Seed
  attr :bpm, true
  attr :time_signiture, true
  attr :basetime, true
  attr :title, true
  attr :tones, true
  def initialize
    
    @title = "UNKNOWN"
    @bpm = 60
    @time_signiture = "4/4"
    @key = "C"
    @mode = "MAJOR"
    @basetime = 480
    @tones = Pitch.new(@key,@mode)
    
  end
  
  def clone
    return Marshal::load(Marshal.dump(self))
  end
  
  def set
    
    selection = nil
    while selection != ""
      
      puts "Set the Seed object"
      puts " 1. Set Title"
      puts " 2. Set BPM"
      puts " 3. Set Time Signiture"
      puts " 4. Set Basetime"
      puts " 5. Set Pitch object"
      
      print "Make a selection ==> "
      selection = gets.chomp
      
      if selection == "1" then
        print " Enter in a Title ==> "
        @title = gets.chomp
        
      elsif selection == "2" then
        print " Enter the BPM ==> "
        @bpm = gets.chomp.to_i
        
      elsif selection == "3" then
        print " Enter in the Time Signiture ==> "
        @time_signiture = gets.chomp
        
      elsif selection == "4" then
        print " Enter in the basetime ==> "
        @basetime = gets.chomp.to_i
        
      elsif selection == "5" then
        @tones.set
        @tones = Pitch.new(@tones.key,@tones.mode,@tones.toneRow)
        
      else
        return
      end
    end
    
  end
  
  def ll
    
    puts "Object Type: Seed"
    puts " Title = #{@title}"
    puts " BPM = #{@bpm}"
    puts " Time Signiture = #{@time_signiture}"
    puts " Basetime = #{@basetime}"
    @tones.ll
  end
  
end

class Composition
  attr :seed, true
  attr :tracks, true
  attr :rhythm, true
  attr :melody, true
  attr :live, true
  attr :is_running, true
  attr_reader :loop
  
  def initialize (seed = nil)
    
    @tracks = []
    if seed == nil
      @seed = Seed.new
    else
      @seed = seed
    end
    
    @live = nil
    @loop = nil
    @is_running = false
    
    @seed.title = "My Song"
    @rhythm = Rhythm.new(@seed)
    @melody = Melody.new()
    
  end
  
  def rm (trk = 0)
    
    if trk == 0 then
      for i in 0...@tracks.size
        @tracks.delete_at(1)
      end
    end
    
    if @loop == true
      @tracks[trk - 1].loop = false
    end
    @tracks.delete_at(trk - 1)
  end
  
  def loop=(looper = true)
    @tracks.each{|x| x.loop = looper} if @is_running
    @loop = looper
  end
  
  def + (section)
    
    if section.instance_of? Motif
      if @loop == true && @is_running
        section.loop = true
        @tracks.sort! {|x,y|
          x.next_start <=> y.next_start
          
        }
        
        while (((start = @tracks.last.next_start) - Time.now.to_f) < 1); end
        
        @live.play(section,start)
      end
      @tracks.push(section)
    end
    
    return self
  end
  
  def play(start = 0)
    
    if @live == nil
      Midifile::play(@tracks)
    else
      @is_running = true
      @tracks.each{|x|
        
        if @loop == true
          x.loop = true
        end        
        @live.play(x)
      }
      
    end
    
  end
  
  def set
    ll
    
    selection = nil
    while selection != ""
      puts ""
      puts "Set the Composition object"
      puts " 1. Set Seed"
      puts " 2. Set Rhythm"
      puts " 3. Set Melody"
      
      print "Make a selection ==> "
      selection = (gets).chomp
      
      if selection == "1" then
        @seed.set
        normalizeTracks()
 #      @tracks.each{|x| x.seed = @seed.clone}
        
      elsif selection == "2" then
        @rhythm.set
        
      elsif selection == "3" then
        @melody.set
        
      else
        return
      end
    end
    
  end
  
  def normalizeTracks()
    @tracks.each{|x| x.seed = @seed.clone}
  end
  
  def ll
    puts "Object Type: Composition"
    puts "Number of Tracks = #{@tracks.size}"
    @seed.ll
    @rhythm.ll
    @melody.ll
    
  end
  
end 
