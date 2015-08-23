class Nevent
  attr :notetype, true
  attr :note, true
  attr :start_time, true
  attr :channel, true 
  attr :velocity, true 
  attr :duration, true
  
  def initialize (notetype, note, start_time, channel, velocity, duration)
    @notetype = notetype
    @note = note
    @channel = channel
    @velocity = velocity
    @start_time = start_time
    @duration = duration
  end
  
end


class Notes
  attr :note, true
  attr :start_time, true
  attr :end_time, true 
  attr :channel, true 
  attr :start_velocity, true 
  attr :end_velocity, true
  attr :note_distance, true
  
  def initialize (note = 0,endTime = 480*4,channel = 9)
    @note = note
    @channel = channel
    @start_velocity = 101
    @end_velocity = 127
    @start_time = 0
    @end_time = endTime
    @note_distance
    
  end
  
  def duration
    return (@end_time.to_i - @start_time.to_i)
  end
  
  def fromFile (on = nil,off = nil)
    
   return if on == nil || off == nil
    
    (tstart_time,tchannel,tnote,tstart_velocity) = on.split(",")  
     @start_time = tstart_time.to_i
     @channel = tchannel.to_i
     @note = tnote.to_i
     @start_velocity = tstart_velocity.to_i
    
    (tend_time,crap,crap,tend_velocity) = off.split(",")
     @end_time = tend_time.to_i   
     @end_velocity = tend_velocity.to_i
    
  end  
  
  def toEvents
    
    out = []
    
    out[0] = Nevent.new("ON",@note,@start_time,@channel,@start_velocity,0)   
    out[1] = Nevent.new("OFF",@note,@end_time,@channel,@end_velocity,self.duration)
    
    return out
  end
  
  def clone
    return Marshal::load(Marshal.dump(self))  
  end
  
end
