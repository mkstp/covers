#aegisopolis - Aphex Twin part 2
#arr by Marc St. Pierre

use_bpm 102
key = scale(:es3, :minor, num_octaves: 4)

live_loop :aegis do
  use_synth :tri
  with_fx :reverb, room: 0.99999 do
    with_fx :distortion, distort: 0.99 do
      play key[$notes1.tick(:one)], release: 0.15, amp: 0.01
    end
  end
  sleep $sleeps1.tick(:two)
end

live_loop :opolis do
  use_synth :beep
  key2 = scale(:es1, :minor, num_octaves: 3)
  play key2[$notes2.tick(:four)], sustain: ($sleeps2.tick(:five) - 0.2), amp: 3
  sleep $sleeps2.tick(:six)
end

live_loop :pads do
  use_synth :tb303
  use_synth_defaults sustain: 5, release: 2.5, amp: 0.5, cutoff: 70
  play chord(:es5, :m); play chord(:es4, :m)
  sleep 8
  play chord(:es4, :m6); play chord(:es3, :m6)
  sleep 8
end

live_loop :ambient do
  use_synth :pnoise
  play 40, attack: 4, sustain: 8, release: 6, amp: 0.3
  sleep rrand(14, 18)
end

live_loop :bass do
  use_sample_defaults amp: 7
  3.times {sample :bd_boom; sleep 0.75}
  sleep 0.25; sample :bd_boom; sleep 1.5
end

live_loop :hats do
  10.times {sample :drum_cymbal_closed, rate: 1.75, amp: 2; sleep 0.25}
  sample :drum_cymbal_open, sustain: 0.45, rate: 1.88
  6.times {sample :drum_cymbal_closed, rate: 1.75, amp: 2; sleep 0.25}
end

live_loop :snare do
  sleep 1
  sample :drum_snare_hard, amp: 0.8, rate: 1.05, sustain: 0.1
  sleep 1
end
