require 'dl/import'
require 'rubygems'

class Live
  
  ON  = 0x90
  OFF = 0x80
  PC  = 0xC0
  
  attr_reader :interval
  
  @@singleton = nil
  
  
  def self.use(bpm=120)
    return @@singleton = self.new if @@singleton.nil?
    @@singleton.bpm = bpm
    return @@singleton
  end
  
  def initialize(bpm=120)
    @switch = true
    self.bpm = bpm
    @timer = Timer.get(@interval/10)
    open
  end
  
  def bpm=(bpm)
    @interval = 60.0 / bpm
  end
  
  
  def play (trks, start = 0)
    return if @switch == false 
    program_change(trks.channel,trks.instrument) if trks.channel != 9
    
    m = ((trks.seed.bpm.to_f/60.to_f)).to_f * (trks.seed.basetime).to_f
    
    start = Time.now.to_f if start == 0
    
    trks.notes.each {|x|
      on_time = start + (x.start_time.to_f/m.to_f)
      
      @timer.at(on_time) { note_on(x.channel, x.note, x.start_velocity) }
      off_time = on_time + ((x.duration.to_f)/m.to_f).to_f
      
      @timer.at(off_time) { note_off(x.channel, x.note, x.end_velocity) }
    }
    
    if trks.loop == true
      trks.next_start = (trks.find_end(trks.notes,1)).to_f/m.to_f + start
      @timer.at(trks.next_start - @interval) { play(trks,trks.next_start) }
    end
    
  end
  
  def note_on(channel, note, velocity=64)
    #    puts "NOTE ON  (#{Time.now.to_f}) #{channel} #{note} #{velocity}"
    message(ON | channel, note, velocity)
  end
  
  def note_off(channel, note, velocity=64)
    #    puts "NOTE OFF (#{Time.now.to_f}) #{channel} #{note} #{velocity}"
    message(OFF | channel, note, velocity)
  end
  
  def program_change(channel, preset)
    message(PC | channel, preset)
  end
  
  module C
    extend DL::Importable
    dlload 'libasound.so'
    
    extern "int snd_rawmidi_open(void*, void*, char*, int)"
    extern "int snd_rawmidi_close(void*)"
    extern "int snd_rawmidi_write(void*, void*, int)"
    extern "int snd_rawmidi_drain(void*)"
  end
  
  def open
    @output = DL::PtrData.new(nil)
    C.snd_rawmidi_open(nil, @output.ref, "virtual", 0)
  end
  
  def close
    @switch = false
    C.snd_rawmidi_close(@output)
    @@singleton = nil
  end
  
  def message(*args)
    return if @switch == false
    format = "C" * args.size
    bytes = args.pack(format).to_ptr
    C.snd_rawmidi_write(@output, bytes, args.size)
    C.snd_rawmidi_drain(@output)
  end
end


class Timer
  def self.get(interval)
    @timers ||= {}
    return @timers[interval] if @timers[interval]
    return @timers[interval] = self.new(interval)
  end
  
  def initialize(resolution)
    @resolution = resolution
    @queue = []
    
    Thread.new do
      while true
        dispatch
        sleep(@resolution)
      end
    end
  end
  
  def at(time, &block)
    time = time.to_f if time.kind_of?(Time)
    @queue.push [time, block]
  end
  
  private
  def dispatch
    now = Time.now.to_f
    ready, @queue = @queue.partition{|time, proc|  time <= now }
    ready.each {|time, proc| proc.call(time) }
  end
end
