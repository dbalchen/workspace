require 'Tools.rb'
require 'gsl'
include GSL

class Melody
  include Tools 
  
  attr :gap, true
  attr :rangeS, true
  attr :rangeE, true
  attr :noteStart, true
  attr :noteMid, true
  attr :noteEnd, true
  attr :splinetype, true

  def initialize ()
   defaults
  end

  def defaults ()
    @gap = 1;
    @intervalDistance = 4
    @rangeS = 56
    @rangeE = 72
    @noteStart = [0,2,4]
    @noteMid =  [0,2,4,5]
    @noteEnd = [0,4,2,6]
    @splinetype = 3
  end

   def set

    selection = nil
    while selection != ""

      puts "Set the Seed object"
      puts " 1. Set Gap"
      puts " 2. Set Interval Distance"
      puts " 3. Set Start Range"
      puts " 4. Set End Range"
      puts " 5. Set start notes"
      puts " 6. Set middle notes"
      puts " 7. Set end notes"
      puts " 8. Set spline"
      puts " 9. Reset to defaults"

      print "Make a selection ==> "
      selection = gets.chomp

      if selection == "1" then
        print " Set gap 1 or 0 ==> "
        @gap = gets.chomp.to_i

      elsif selection == "2" then
        print " Set the interval distance ==> "
        @intervalDistance = gets.chomp.to_i

      elsif selection == "3" then
        print " Set the start range  ==> "
        @rangeS = gets.chomp.to_i

      elsif selection == "4" then
        print " Set the end range ==> "
        @rangeE = gets.chomp.to_i

      elsif selection == "5" then
        print " Set the probable start notes ==> "
        tmp = (gets.chomp).split(/,/)
        @noteStart = tmp.collect{|x| x.to_i}

      elsif selection == "6" then
        print " Set the probable middle notes ==> "
        tmp = (gets.chomp).split(/,/)
        @noteMid = tmp.collect{|x| x.to_i}

      elsif selection == "7" then
        print " Set the probable end notes ==> "
        tmp = (gets.chomp).split(/,/)
        @noteEnd = tmp.collect{|x| x.to_i}

      elsif selection == "8" then
        print " Set the spline type ==> "
        @splinetype = gets.chomp.to_i

      elsif selection == "9" then
        defaults()

      else
        return
      end
    end

  end
  
  def ll
    puts "Object Type: Melody"
    puts " gap = #{@gap}"
    puts " Range Start = #{@rangeS}"
    puts " Range End = #{@rangeE}"
    puts " Interval Distance = #{@intervalDistance}"
    puts " Start Notes = #{@noteStart}"
    puts " Middle Notes = #{@noteMid}"
    puts " End Notes = #{@noteEnd}"
    puts " Spline type = #{@splinetype}"
  end
  
  def makeSpline(pats = nil)
    
    
    pats[0].note = pickTone @noteStart if pats[0].note == 0
    pats.last.note = pickTone @noteEnd if pats.last.note == 0 && pats.size > 1 
    findTones(pats)
    
    if @x.size < @splinetype then
      
      
      if @splinetype > 2 && pats.size >= @splinetype then
        tmp = pats[1...(pats.size - 1)].select {|x| x.note != 0}
        
        if tmp.size == 0 then
          picknums = pickNumbers(1,pats.size - 2,@splinetype - 2)
          
          if picknums != nil
            picknums.each{|z| 
              pats[z].note = pickTone @noteMid
            } 
          end
        end
      end
      findTones(pats)
    end

    @x = Vector.alloc(@x) 
    @y = Vector.alloc(@y)
    spline = Spline.alloc(@x, @y)
#    spline = Interpolation::Spline.new(Interpolation::LINEAR, @x.size)
        
#    ret = spline.init(@x,@y)
#    STDERR.puts strerror(ret) if ret != GSL_SUCCESS
    
    return spline
  end
  
  def addTones(omotif)    
    motif = clone(omotif)
    
    @channel = motif.notes[0].channel
    if @channel == 9 then
     (motif.notes).each {|x| x.note = 0; x.channel = 0}
      @channel = 0
    else
      motif.notes.each do |x|
        if x.channel == 9 then
          x.note = 0
          x.channel = @channel
        end
      end
      
    end
    
    pats = motif.notes
    @tones = motif.seed.tones
    
    spline = makeSpline(pats)
#    acc = Interpolation::Accel.new
    
    pats.reverse!
    
    pats.each_with_index do |z,i|  
      if z.note == 0
 #       yi = (spline.eval(z.start_time, acc)).round
        yi = (spline.eval(z.start_time)).round
        plt = pats[i - 1].note
        pl = @tones.invpitchrange[plt]
        
        tnotes = [] 
        
         (1..@intervalDistance).each do |q|
          if plt < yi
            tnotes.push(@tones.pitchrange[pl + q])
          end
          
          if plt > yi
            tnotes.push(@tones.pitchrange[pl - q])
          end
          
          if plt == yi
            tnotes.push(@tones.pitchrange[pl + (q - 2)])
          end        
          
        end
        
        tnotes = sortFrom(tnotes,yi)
        if plt == yi
          tnotes.push(@tones.pitchrange[pl + 2])
        else
          tnotes.push(plt)
        end
        
        tnotes.uniq!
        pats[i].note = pickFrom(tnotes,1)[0]
        pats[i].channel = @channel
      end
      
    end
    
    pats.reverse!
    
    motif.notes = pats
    return motif
  end
  
  def sortFrom(numbers,fromdist)
    numbers.sort! do |x,y|
      
      if @gap == 0 then
       (x - fromdist).abs <=> (y - fromdist).abs
      else
       (y - fromdist).abs <=> (x - fromdist).abs
      end      
    end 
    return numbers
  end
  
  def pickTone(*ess)
    ess[0] = 0 if ess.size == 0
    
    ess.each_with_index{ |x,i| ess[i] = x.to_a if x.instance_of? Range}
    
    ess.flatten!
    y1 = []
    ess.each {|x| y1.push((@tones.randomPitch(@tones.pitchroots[x], @rangeS, @rangeE))) }
    
    return pickFrom(y1,1)[0]
    
  end
  
  def findTones(pats)
    @x = []
    @y = []
    
    pats.each do |z|   
      if z.note != 0 then
        @x.push(z.start_time.to_f)
        @y.push(z.note.to_f)
      end
    end
  end
  
end
