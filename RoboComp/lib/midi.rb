require 'Notes.rb'
require 'midilib'
require 'midilib/sequence'
require 'midilib/consts'
require 'Motif.rb'


include Math
include MIDI
include Tools

module Midifile
  
  @timeDivision = 480
  @notesQ = 60
  
  def self.load(mfile = nil)
    return if mfile == nil
    
    motifs = []
    seq = MIDI::Sequence.new()
    seq.read(File.open(mfile, 'rb'))
    
    comp = Composition.new
    comp.seed.title = seq.name
    comp.seed.bpm = seq.beats_per_minute
    comp.seed.time_signiture = seq.numer.to_s + "/" + (2**seq.denom).to_s
    @timeDivision = seq.ppqn
    @notesQ = seq.qnotes
    comp.seed.basetime = seq.numer * seq.ppqn
    
    onNotes = []
    offNotes = []
    notes = []
    
    seq.each_with_index { | track, idx |
      
      puts idx
      
      if idx > 0
        track.each { | e |
          
          e.print_decimal_numbers = true
          
          if e.note_on?
            note = e.time_from_start.to_s + "," + e.channel.to_s + "," + e.note.to_s + "," + e.velocity.to_s
            onNotes.push(note)
          end
          
          if e.note_off?
            note = e.time_from_start.to_s + "," + e.channel.to_s + "," + e.note.to_s + "," + e.velocity.to_s
            offNotes.push(note)
          end
        }
        
        notes.clear
        
        onNotes.each{|x|
          
          offNotes.each_with_index { |y,ldx|
            if x.split(/,/)[2] == y.split(/,/)[2]
              z = Notes.new
              z.fromFile(x,y)
              notes.push(z)
              offNotes.delete_at(ldx)
              break
            end
            
          }
        }
        
        mot = Motif.new(comp.seed,track.name)
        
        if track.instrument == nil then
          mot.instrument = 0
        else
          mot.instrument = track.instrument
        end
        
        if(notes[0].start_time != 0)
          notes.unshift(Notes.new(0,notes[0].start_time))
        end
        
        mot.notes = notes.clone
        motifs.push(mot)
        onNotes.clear
        offNotes.clear
      end
    }
    
    comp.tracks = motifs
    
    return comp
  end
  
  def self.save(trks)
    
    tracks = normalize(trks)
    
    seed = tracks.last.seed
     (num,denum) = seed.time_signiture.split(/\//)
    teq = Sequence.new()
    track = Track.new(teq)
    teq.tracks << track
    teq.time_signature(num.to_i, (Math.log(denum.to_i)/Math.log(2)).to_i, @timeDivision, @notesQ)
    
    track.events << Tempo.new(Tempo.bpm_to_mpq(seed.bpm))
    track.events << MetaEvent.new(META_SEQ_NAME,'My New Track')
    
    tracks.each do |x|
      tk = Track.new(teq)
      teq.tracks << tk
      
      tk.name = x.title
      if x.instrument == nil then
        tk.instrument = MIDI::GM_PATCH_NAMES[0]
      else
        tk.instrument = MIDI::GM_PATCH_NAMES[x.instrument]
      end
      
      
      last = 0
      notes = (x.notes.collect{|y| y.toEvents}).flatten.sort{|x,y| x.start_time <=> y.start_time}
      times = (notes.collect{|x| x.start_time}).uniq
      
      for i in 0...times.size do
        
        tnotes = notes.select{|x| x.start_time == times[i]}
        delta = times[i] - last
        last = times[i]
        
        tnotes.each {|y| 
          if y.notetype == "ON"
            tkk = NoteOnEvent.new(y.channel.to_i,y.note.to_i, y.velocity.to_i,delta)
            
          else
            tkk = NoteOffEvent.new(y.channel.to_i,y.note.to_i, y.velocity.to_i,delta)
          end
          delta = 0
          tkk.time_from_start = y.start_time.to_i
          tk.events << tkk      
          
        }
      end
      
      tk.recalc_times
      
    end
    
    outfile = seed.title.gsub(" ","_")
    tout = outfile  + ".mid"
    File.open(tout, 'wb') { | file |  
      teq.write(file) 
    }
    
    
  end
  
  def self.play(trks)
    see(trks)
    tracks = normalize(trks)
    seed = tracks.last.seed
    outfile = seed.title.gsub(" ","_")
    system("timidity -ia " + outfile + ".mid  > /dev/null 2>&1")
  end
  
  def self.see(trks)
    save(trks)
    tracks = normalize(trks)
    seed = tracks.last.seed
    outfile = seed.title.gsub(" ","_")
    
    system("midi2ly " + outfile + ".mid > /dev/null 2>&1")
    system("lilypond --ps " + outfile + "-midi.ly > /dev/null 2>&1")
    system("evince " + outfile + "-midi.ps > /dev/null 2>&1 &")
  end
  
  def self.normalize(tks)
    
    if tks.instance_of? Array
      tracks = tks
    elsif tks.instance_of? Composition
      tracks = tks.tracks
    elsif tks.instance_of? Motif  
      tracks = []
      tracks.push(tks)
    else
      return nil
    end
    return tracks
  end
  
end
