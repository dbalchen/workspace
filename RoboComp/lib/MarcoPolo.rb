class MarcoPolo
  def initialize(order = 1)
    @order = order
    @beginnings = []
    @freq = {}
    @total 
  end
  
  def marco(words) 
    return unless words.size > @order # ignore short sentences
    buf = []
    words.each { |w|
      buf << w
      if buf.size == @order + 1
       (@freq[buf[0..-2]] ||= []) << buf[-1]
        buf.shift
      end
    }
    @total = words.length
    
    @beginnings << words[0, @order]
  end
  
        def polo
          res = @beginnings[rand(@beginnings.size)]
          
          while res.size < @total
            res << next_word_for(res[-@order, @order])
          end
          return res
        end
  
  private 
  def next_word_for(words)
    arr = @freq[words]
    arr && arr[rand(arr.size)]
  end
end
