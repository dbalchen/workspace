require 'midi.rb'
require 'Rhythm.rb'
require 'Motif.rb'
require 'Melody.rb'
require 'Composition.rb'
require 'Pitch.rb'
require 'MarcoPolo.rb'
require 'Live.rb'


module RoboComp
  
  def start
    $last = nil
    @composition = Composition.new
    setGlobals
    puts "Start a new Composition"
  end
  
  alias :clear :start
  
  def setGlobals ()
    @live.close if @live != nil
    @live = nil
    live
    $rhy = @composition.rhythm
    $mel = @composition.melody
    $cmp = @composition
    $pitch = @composition.seed().tones
    $startmeasures = 2
    $startbeats = [6,8]
  end
  
  def save (filename)
    
    filename = filename + ".rob"
    dump = Marshal.dump(@composition)
    file = File.new(filename,'w')
    file.write dump
    file.close
    puts "The file #{filename} has been saved."
    
  end
  
  def load (filename)
    # load a midi or Composition file
    
    if filename.index(".mid") != nil then
      @composition = Midifile::load(filename)
    else
      file = File.open(filename, 'r')
      @composition = Marshal.load file.read
      file.close
    end
    
    setGlobals()
    puts "The file #{filename} has been loaded."
    
    return @composition
  end
  
  def get (*parameters)
    
    return $rhy.get if parameters.size == 0
    
    if parameters.size == 1 && parameters[0].is_a?(Numeric) then
      return (@composition.tracks[parameters[0]-1]).clone
    end
    return parameters
    
  end
  
  def set (object = nil) 
    
    object = @composition if object == nil
    object.set
    
  end
  
  def live (switch = true)
    
    if switch == true
      @live = Live.use
      @composition.live = @live
    else
      looper false
      @live.close
      @live = nil
      @composition.live = nil
      @composition.is_running = false 
    end
    
  end
  
  def looper (switch = true)
    
    if switch == true
      $cmp.loop = true
    else
      $cmp.loop = false
      $cmp.is_running = false
    end
    
  end
  
  def see (obj = nil)
    
    obj = @composition if obj == nil
    Midifile::see(obj)
    
  end
  
  def play (trk = nil)  
    
    if trk.instance_of? Composition
      trk.play()
    end
    
    if trk.instance_of? Motif
      
      if @live == nil then
        Midifile::play(trk)
      else
        if $cmp.is_running
          $cmp += trk
        else
          if $cmp.tracks.size == 0 && $cmp.loop
            $cmp += trk
            $cmp.play
          else
            @live = Live.use(trk.seed.bpm)
            @live.play(trk)
          end
        end
      end
      
    end
    
    if trk == nil   
      trk = @composition.rhythm.get($startmeasures) | @composition.rhythm.beats($startbeats[0],$startbeats[1]) | @composition.melody
      
      if @live == nil then
        Midifile::play(trk)
      else
        if $cmp.is_running
          $cmp += trk
        else
          @live.play(trk) 
        end
      end
      
    end 
    
    $last = trk
    return trk
    
  end  
  
  
  def ll (obj = nil)
    
    obj = @composition if obj == nil 
    obj.ll()
  end
  
  def rm (trk = 0)
    $cmp.rm(trk)
  end
end

include RoboComp
puts "Welcome to RoboComp"
start
