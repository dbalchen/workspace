#! /usr/bin/ruby
#1.9.1
require 'Root.rb'

class Pitch < Root
  attr :toneRow, true
  attr :mode, true
  attr :key, true
  attr :prime_form
  attr :normal_form
  attr :base_form
  attr :pitch_class
  attr :inverse
  attr :t_matrix
  attr :ti_matrix
  def initialize
    super
    @toneRow = [0,2,4,5,7,9,11]
    @key = "C"
    @mode = "MAJOR"
    @keys = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
    @modes = ["MAJOR","DORIAN","FRIDGIAN","LYDIAN","MIXOLYDIAN","MINOR","LOCRIAN"]

    setKey(@key,@mode)
  end

  def setKey(key = "C", mode = "MAJOR")
    @key = key
    @mode = mode

    keyIdx = @keys.index(@key)

    key_index =  @keys.index(@keys.at(keyIdx - @toneRow.at(@modes.index(@mode))))
    @pitch_class = @toneRow.collect{|x| (x + key_index)}.sort {|x,y| x <=> y}

    pcSets(@pitch_class)

  end

  def pc(notes = nil)

    @pitch_class = normalForm(notes)
    pcSets(@pitch_class)

    @key = @keys[@pitch_class[0]]
  end

  def pcSets(pc = @pitch_class)

    @pitch_class = pc
    @base_form = @pitch_class.collect{|x| x.modulo(12)}.sort {|x,y| x <=> y}
    @normal_form = normalForm(@base_form)
    @prime_form = primeForm(@normal_form)
    @t_matrix = deriveMatrix(@normal_form,@normal_form)
    @ti_matrix = deriveMatrix(@normal_form,@inverse)

  end

  def deriveMatrix(col = @normal_form,row = @normal_form)

    matrix = []

    for i in 0...row.size do
      newRow = []

      for j in 0...col.size do
        imp = (row[i] + col[j]).modulo(12)
        newRow.push(imp)
      end

      matrix.push(newRow)
    end

    return matrix

  end

  def primeForm(tones = nil)

    tones = tones.clone()
    @inverse = normalForm(tones.map{|x| 12 - x}.sort {|x,y| x <=> y})

    invtone = @inverse.clone

    t0 = tones[0]
    tones.map!{|x| (x - t0).modulo(12)}

    t0 = invtone[0]
    invtone.map!{|x| (x - t0).modulo(12)}

    num = invtone.size
    while(num > 0)

      diff0 = (tones[num - 1] - tones[0])
      diff1 = (invtone[num - 1] - invtone[0])

      if diff0 < diff1 then
        return tones
      end
      if diff1 < diff0 then
        return invtone
      end
      num = num -1
    end

    return tones
  end

  def normalForm(tones = @toneRow)

    @toneRow = (tones.map{|x| x.modulo(12)}).uniq.sort {|x,y| x <=> y}
    normalform = []

    num = @toneRow.size

    diff = 100
    for i in 0...num do
      if (tdiff = (@toneRow.last - @toneRow.first)) <= diff then
        normalform.push(@toneRow.clone)
        diff = tdiff
      end
      @toneRow.push((@toneRow[0] + 12).modulo(12)); @toneRow.shift
    end

    while(num > 0 && normalform.size != 1)
      normalform.sort!{|x,y| (x[num-1] - x.first) <=> (y[num-1] - y.first)}
      diff = normalform[0][num-1] - normalform[0].first
      normalform = normalform.find_all do |x|
        (x[num-1] - x.first) <= diff;
      end
      num = num -1
    end

    nf = normalform[0].map{|x| x.modulo(12)}
    return nf
  end

  def printPitch ()

    puts "Key        : " + @key +"\n"
    puts "Mode       : " + @mode + "\n"
    puts "Pitch class: " + @pitch_class.join(',').to_s() + "\n"
    puts "Base form  : " + @base_form.join(',').to_s() + "\n"
    puts "Normal form: " + @normal_form.join(',').to_s() + "\n"
    puts "Inverse    : " + @inverse.join(',').to_s() + "\n"
    puts "Prime form : " + @prime_form.join(',').to_s() + "\n"
    puts " "

    puts "T-Matrix"
    for i in 0...@t_matrix.size
      puts @t_matrix[i].join(',').to_s()
    end

    puts " "
    puts "Ti-Matrix"
    for i in 0...@ti_matrix.size
      puts @ti_matrix[i].join(',').to_s()
    end

  end
end

if File.identical?(__FILE__, $0)
  require 'Root.rb'
  require 'Pitch.rb'
  require 'Notes.rb'
  require 'Composition.rb'
  require 'Track.rb'
  require 'yaml'

  input = ""
  #input = `cat /home/dbalchen/workspace/RoboComp/lib_0.1/test.yaml`;
  until ARGV.empty? do
    puts "From arguments: #{ARGV.shift}"
  end

  while buff = gets
    input = input + buff
  end

  song = YAML::load(input)

  puts "main pitch\n\n"
  song["pitch"].printPitch

  song["tracks"].each { |x|
    puts "Track Pitch\n\n"
    x.pitch.printPitch
  }

end
