#Six Pianos - Steve Reich - LOOPS
#Arranged for Sonic Pi by Marc St. Pierre May 2018

use_bpm 192
use_synth :piano

live_loop :seq do
  8.times do
    tick
    $secn1.each {|list| play list.ring[look], release: 0.5}
    sleep 0.5
  end
end

v = 4
for_notesA = [7, 3, 5, 4, 2, 8, 6, 1]

live_loop :p4, sync: :seq do
  on (sub_rests(for_notesA)[tick%8]) {play from_player(3, $secn1, -2).look, amp: v}
  sleep 0.5
end

loud_soft($sol1[0], rrand(15, 20))

f = 4
for_notesB = [ ]

live_loop :p5, sync: :seq do
  on (sub_rests(for_notesB)[tick%8]) {play from_player(1, $secn1, 2).look, amp: f}
  sleep 0.5
end

m = 4
for_notesC = [ ]

live_loop :p6, sync: :seq do
  on (sub_rests(for_notesC)[tick%8]) {play from_player(2, $secn3, 4).look, amp: m}
  sleep 0.5
end














