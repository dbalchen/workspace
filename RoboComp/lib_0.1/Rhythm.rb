#! /usr/bin/ruby

module Rhythm
  def self.define (over = 6,under = 8)

    on = Array.new(over); on.fill("1")
    
    for i in 0...(under - over).abs
      on[i%over] = on[i%over] + "0"
    end

    while (on.select{|x| x == on.last}.size) >= 2 && on.size > 2
      mod = on.size - 2
      for i in 0...2
        on[i%mod] = on[i%mod] + on.last
        on.pop
      end

    end
    on = on.join.split("").map { |s| s.to_i }
      
    notes = []  
    for i in 0...under
      z = Notes.new      
      z.start_time = (i.to_f/under)
      z.note = on[i]
      notes.push(z)
    end
    notes.reject!{|x| x.note == 0}
    return notes
  end
  

  
end


if File.identical?(__FILE__, $0)
  require 'Root.rb'
  require 'Pitch.rb'
  require 'Notes.rb'
  require 'Composition.rb'
  require 'Track.rb'
 # require 'Rhythm.rb'
  require 'yaml'

  until ARGV.empty? do
    @myarg = "#{ARGV.shift}"
    
    if @myarg == "-f"
      
#      input = `cat /home/dbalchen/workspace/RoboComp/lib_0.1/tmp.yaml`;
      
      input = ""

      while buff = gets
        input = input + buff
      end
      
      song = YAML::load(input)
      input = ""
      song.tracks.each { |x|
        
        @buzz = x.notes
        x.notes = x.fixEndT(@buzz)      
      }
      
      print YAML::dump(song)
      
    end
    
    if @myarg == "-e"
      
      song = Composition.new
      
      a = Rhythm::define(4,4);
      track = Track.new
      track.clear(a,35)
      track.streach(4)
      song.tracks.push(track.clone) 
      
      a = Rhythm::define(7,16);
      track = Track.new
      track.clear(a,37)
      track.streach(4)
      song.tracks.push(track.clone) 
    
      a = Rhythm::define(5,16);
      track = Track.new
      track.clear(a,37)
      track.streach(4)
      song.tracks.push(track.clone)
      
    end
    
  end
   
  print YAML::dump(song)

end
