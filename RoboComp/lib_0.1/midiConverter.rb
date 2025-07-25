#! /usr/bin/ruby

require_relative 'Root.rb'
require_relative 'Notes.rb'
require_relative 'Pitch.rb'
require_relative 'Composition.rb'
require_relative 'Track.rb'
require 'yaml'

midi_input = ARGV[0]

hh = "midicsv " + midi_input

file_contents = []
file_contents = `#{hh}`.split("\n");

numberOfTracks  = ((file_contents[0].split(","))[4]).to_i

song = Composition.new

begin
  song.clockPulsesPerQ = ((file_contents[0].split(","))[5]).to_i
rescue
 # puts "Setting clockPulsesPerQ = 480"
end

begin
  song.bpm = (60000000 / ((((file_contents.grep(/Tempo/))[0]).split(",")[3]).to_f)).to_i
rescue
  # puts "Setting bpm = 60"
end

begin
  timeInfo = (file_contents.grep(/Time_signature/))[0]
  song.time_signature = (timeInfo.split(","))[3] + "/" + (2**((timeInfo.split(","))[4]).to_i).to_s
  song.click = ((timeInfo.split(","))[5]).to_i
  song.notesQ = ((timeInfo.split(","))[6]).to_i
rescue
  # puts "setting "
end

allPitches = []
  
for i in 2..numberOfTracks do
  notes = []
  track = Track.new
  trk = []
  pitches = []  

  trk = file_contents.select{|x| (x.split(",")[0]).to_i == i}

  noteOn =  trk.grep(/Note_on/)
  noteOff = trk.grep(/Note_off/)
  title =   ((trk.grep(/Title/)[0]).split(","))[3].tr('"', '').strip
  control =   trk.select{|x| x.index("Control") != nil || x.index("Program") != nil}

  noteOn.each { |x|

    noteOff.each_with_index { |y,ldx|
      if x.split(/,/)[4] == y.split(/,/)[4]
        z = Notes.new

        z.note = (x.split(/,/)[4]).to_i
        pitches.push(z.note)

        z.start_time = ((x.split(/,/)[1]).to_f)
        z.duration = ((((y.split(/,/)[1]).to_f) - z.start_time) / song.clockPulsesPerQ.to_f)
        z.start_time = z.start_time / song.clockPulsesPerQ.to_f
        z.start_velocity = (x.split(/,/)[5]).to_i
        z.end_velocity = (y.split(/,/)[5]).to_i

        notes.push(z)
        noteOff.delete_at(ldx)

        break
      end
    }

  }
  track.title = title
  track.notes = notes.clone
#  track.control = control.clone
 if pitches.size > 0
  track.pitch.pc(pitches)
  allPitches.push(pitches.clone)
 end
 
  song.tracks.push(track)

end

allPitches.flatten!
song.pitch.pc(allPitches)
print YAML::dump(song)
