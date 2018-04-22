#We are the Music Makers - Aphex Twin - DATA
#Arranged for Sonic Pi by Marc St. Pierre April 2018


#===================================== GLOBALS ===================================

$music_makers = "/Users/marcstpierre/Desktop/Code Meanderings/music_makers_2.wav"

##| with_fx :reverb, room: 0.999 {sample $music_makers, amp: 8}
drums_fader = 0.1


#========================== HELPER FUNCTIONS ================================

#converts a decimal number to a ring list of ones and zeros to use in a step sequencer
define :binary_conv do |num, beat_count|
  binList = Array.new(beat_count, 0)
  num = num.to_s(2)
  .split(//)
  .map {|i| i.to_i}
  num.each {|i| binList.unshift(i); binList.pop}
  puts binList
  return binList.ring
end


#=========================== NOTE DATA ======================================

$sleeps1 = [0.75, 0.5, 0.25, 0.50, 0.75, 0.25, 0.5, 0.25, 0.5, 0.75, 0.75, 0.75, 0.25, 0.75, 0.5].ring
$notes1 = [0, 3, 3, 3, 2, 1, 0, 2, 2, 0, 0, 0, 2, 0, 0].ring

$sleeps2 = [0.25, 0.5, 0.5, 0.5, 0.25, 0.5, 0.5, 0.5, 0.25, 0.25].ring
$notes2 = [17, 14, 17, 14, 17, 14, 15, 16, 15, 14].ring

$sleeps3 = [0.25, 1, 0.75, 1, 1].ring
$notes3 = [16, 16, 16, 14, 15].ring

$sleeps4 = [0.25, 2.75, 1].ring
$notes4 = [3, 0, nil].ring

$notes5 = [3, 0, 3, 0, 3, 0, 1, 2, 1, 0, 2, 0, 3, 0, 3, 0, 1, 2, 1, 0].ring

$sleeps6 = [0.25, 0.25, 0.5, 0.25, 0.5, 0.25, 0.5, 0.25, 0.25, 0.25, 0.5, 0.5, 0.25, 0.5, 0.25, 0.5, 0.5, 0.25, 0.5, 0.5, 0.5].ring
$notes6 = [27, 25, 27, 25, 27, 25, 27, 25, 27, 25, 27, 27, 25, 27, 25, 28, 29, 26, 31, 28, nil].ring

$sleeps7 = [0.25, 0.25, 0.5, 0.25, 0.5, 0.25, 0.5, 0.25, 0.75, 0.25, 0.5, 0.25, 0.5, 0.25, 0.5, 0.25, 0.5, 0.25, 0.25, 0.5, 0.5].ring
$notes7 = [30, 28, 30, 28, 30, 28, 30, 31, 30, 28, 30, 28, 30, 28, 30, 28, 30, 31, 30, 28, nil].ring

$beat_data = (map note1: [2435392658,32],
              note2: [2435392658,32],
              snare: [32,8],
              snare_fill: [2692876321, 32],
              snare_alt: [2304, 16],
              hats: [148, 8],
              bass: [1246382674,32],
              bass_fill: [302580882,32],
              cymbal: [16843017,32],
              cymbal_fill: [70287621,32])

$control_sequence = [nil, 127, 126, 110, 96, 65, 78, 94, 78, 94, 30, 38, 32, 1, 0]


#================================== SOUNDS ================================

#preset sounds and parameters that play when triggered by a key word
define :make_music do |name|
  if name == :note1
    with_synth_defaults cutoff: 45, release: 0.4 do
      synth :saw, note: :as3, amp: 0.2
    end
  end
  
  if name == :note2
    with_synth_defaults cutoff: 80, release: 0.4, pitch: -0.75 do
      synth :sine, note: :bs5 + rrand(-0.1, 0.1), amp: 0.1, pan: -1
      synth :sine, note: :bs5 + rrand(-0.1, 0.1), amp: 0.1, pan: 1
    end
  end
  
  if name == :snare || name == :snare_fill
    with_fx :reverb, room: 0.6 do
      sample :drum_snare_hard, rate: 1.1, sustain: 0.1, amp: 0.4 * drums_fader
    end
  end
  
  if name == :snare_alt
    with_fx :reverb, room: 0.9 do
      sample :sn_dolf, rate: 1.2, sustain: 0.1, amp: 0.35 * drums_fader
    end
  end
  
  if name == :hats
    sample :drum_cymbal_closed, rate: 4, sustain: 0.03, amp: 0.8 * drums_fader
  end
  
  if name == :bass || name == :bass_fill
    sample :bd_ada, cutoff: 100, amp: 1.2 * drums_fader
  end
  
  if name == :cymbal || name == :cymbal_fill
    sample :drum_cymbal_open, sustain: 0.05, release: 0.1, rate: 1.7, amp: 0.3 * drums_fader
  end
end










