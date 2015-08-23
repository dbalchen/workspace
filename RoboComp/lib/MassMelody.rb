#! /usr/bin/ruby
require 'robo_comp.rb'

puts "Lets start riffing"
clear
load "/home/dbalchen/workspace/RoboComp/lib/wt.mid"
p = Pitch.new("E","MINOR")
$cmp.seed.tones = p
$cmp.seed.bpm = 115
$cmp.normalizeTracks
live false

a = get 1

aa = a.clone
$mel.splinetype = 2

#c = get 3
#c.seed.tones = p

#tmeasures = [1,2,4,8,16]
#infpoints = [2,3]

massMel = aa.clone

#for i in (0..6)
#  puts i
for j in (1..7)
  puts j

zed = aa.ret + aa.inv + (aa.inv).ret + aa.sinv + (aa.sinv).ret
#zed = (aa * 4).clear | $mel 
#c = (aa.rrm * 16).clear
#ss = b.flatten(c)
#zed = ss | $mel
# $mel.splinetype = infpoints[rand(infpoints.size)]
#zed = ((aa * tmeasures[rand(tmeasures.size)]).clear | $mel).transpose(i)
massMel = massMel + zed
aa = aa.transpose(j)
#massMel = massMel + aa
end
#end
play massMel
puts "Bye Bye"


