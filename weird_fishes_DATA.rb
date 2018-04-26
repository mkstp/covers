#Weird Fishes Arpeggi - Radiohead - DATA
#Arranged for Sonic Pi by Marc St. Pierre April 2018


#======================= CONSTANTS ================================

drums_fader = 1
voices_fader = 0.5


#========================= DATA =================================

#beat data represent binary sequences and corresponding list sizes
$beat_data = (map snare: [144,8], hats: [1, 2], bass: [5,32])

#voice data represent indices of a chromatic scale
$voice_data = (map voice1: [[10, 3, 0],
                            [12, 5 ,2],
                            [17, 9, 5],
                            [14, 7, 3]],
               voice2: [[3, 10, 12, 3, 10, 3, 0, 12, 3, 0, 0, 10, 12, 0, 10],
                        [5, 12, 14, 5, 12, 5, 0, 14, 5, 0, 0, 12, 14, 0, 0],
                        [9, 12, 9, 12, 17, 9, 12, 0, 12, 0, 0, 12, 9, 12, 14],
                        [15, 12, 10, 15, 10]],
               voice3: [[12, 15, 0, 15, 19],
                        [14, 17, 21, 14, 17],
                        [14, 17, 21, 14, 17],
                        [14, 19, 22, 19, 22]],
               bridge1: [[17, 9, 5],
                         [7, 3, 14]],
               bridge2: [[9, 12, 9, 12, 17],
                         [15, 12, 10, 15, 10]])


#=================== HELPER FUNCTIONS ==============================

#converts a number to a ring list of binary digits for use in a step sequencer
define :binary_conv do |num, beat_count|
  binList = Array.new
  beat_count.times {|index| binList << num[index]}
  puts binList
  return binList.ring
end

#takes in multiple lists of simultaneous note data streams and collapses to one list via a bitwise union (OR) operator
define :bit_union do |twodlist, beat_count|
  noteList = Array.new
  beat_count.times {|index| u = 0; twodlist.each {|list| u |= (2**list.ring[index])}; noteList << u}
  return noteList.ring
end

#takes in note pattern data for individual voices and runs bit_union on patterns happening at the same time
define :transpose_condense do |name_list, dictionary, beat_count|
  patList = Array.new
  name_list.map {|name_key| patList << dictionary[name_key]}
  patList = patList.transpose.map {|list| bit_union(list, beat_count)}
  puts patList
  return patList.ring
end

#takes in a note name and synth and makes it into something interesting for the lissajous scope
define :visualize do |n, s_name|
  2.times {synth s_name, note: n, pan: [1, -1].ring.tick(:v1), pitch: rrand(-0.15, 0.15), amp: rrand(-0.1, 0.1) + voices_fader}
end

define :hit_drum do |name|
  case name
  when :snare
    with_fx :reverb, room: 0.1, mix: 0.3 do
      sample :drum_snare_hard, rate: [1, 0.99].ring.tick(:d1), sustain: 0.1, amp: [0.3, rrand(0.1, 0.2)].ring.tick(:d2) * drums_fader
    end
    
  when :hats
    sample :drum_cymbal_closed, rate: 4, sustain: 0.03, amp: 0.8 * drums_fader
    
  when :bass
    sample :bd_tek, cutoff: 100, amp: 1.2 * drums_fader
    
  when :sticks
    sample :drum_cymbal_pedal, rate: 20, amp: 0.5
  end
end







