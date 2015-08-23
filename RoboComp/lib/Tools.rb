module Tools
  
  def invArray(ary)
    h = {}
    ary.each_with_index{|x,idx| h[x] = idx}
    return h
  end
  
  def fixEndT(line_pattern,final_end)
    return line_pattern if line_pattern.size == 0
    
    line_pattern.sort! { |x,y|
      x.start_time <=> y.start_time
    }
    
    tmp = []
    xx = line_pattern.collect{|x| x.start_time}
    xx.uniq!
    
    xx.each {|x|
      yy = line_pattern.select{|y| y.start_time == x }
      tmp.push(yy)     
    }
    
    for i in 0...(tmp.size - 1)
      tmp[i].each { |x|
        x.end_time = tmp[i+1][0].start_time
        
      }
    end
    
    tmp.last.each{|x| x.end_time = final_end}
    line_pattern = tmp.flatten
    
    return line_pattern
  end
  
  def calcDis (a = 0,b = 0)
    
    if a > b
      b = a + (a - b)     
    else
      b = a - (b - a)
    end
    
    return b
  end
  
  def clone (obj = nil)
    if obj == nil
      return Marshal::load(Marshal.dump(self))
    else
      return Marshal::load(Marshal.dump(obj))
    end
  end
  
  def pickNumbers(start,final,howmany = 1)
    
    return nil if howmany == 0
    range = (start..final).to_a 
    howmany = range.size if howmany > range.size
    
    numFromRange = []
    
    while numFromRange.size < howmany
      randy = rand(range.size)
      numFromRange.push(range[randy])
      numFromRange.uniq!    
    end
    numFromRange.sort!{|x,y| x <=> y }
    
    return numFromRange
  end
  
  def pickFrom(collection,howmany = 0)
    
    prbs = []
    answers = []
    sum = 0
    weights = collection.size
    
    for i in 0...weights   
      prbs[i] = 10000*((weights.to_f - i.to_f)/weights.to_f**2)
      sum += prbs[i]
    end
    
    inc = (10000 - sum.to_f)/weights.to_f
    
    prbs[0] += inc.ceil
    
    for i in 1...weights
      prbs[i] += inc.to_i
    end
    
    while answers.size < howmany     
      randy = rand(10000)
      interval = 0
      
      for i in 0...prbs.size
        
        if randy > interval && randy < (prbs[i] + interval)
          answers.push(collection[i])
          break
        end     
        interval = interval + prbs[i]
      end
      answers.uniq!
    end  
    
    return answers
  end
  
end