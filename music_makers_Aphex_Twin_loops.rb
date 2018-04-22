#We are the Music Makers - Aphex Twin
#Arranged for Sonic Pi by Marc St. Pierre April 2018

use_bpm 103
key = scale(:cs2, :minor, num_octaves: 5)

fill = 0

track_names = [
  fill == 0 ? :bass : :bass_fill,
  fill == 0 ? :snare : :snare_fill,
  fill == 0 ? :cymbal : :cymbal_fill,
  :hats,
  :snare_alt,
  :note1,
  :note2
].ring

section = 1

main_control = binary_conv($control_sequence[section],7)

beat_patterns = track_names.map {|track| b = $beat_data[track]; binary_conv(b[0], b[1])}

live_loop :sequencer do
  32.times do
    beat_patterns.each {|pattern| t = track_names.tick; make_music(t) if pattern.tick(track_names.look) == 1}
    sleep 0.25
  end
  tick_reset_all
end

live_loop :bassline1, sync: :sequencer do
  stop if main_control[0] == 0
  sleep $sleeps1.tick; synth :blade, note: key[$notes1.look], release: 0.5, cutoff: 50, pitch: -0.2, amp: 4
end

live_loop :riff1_main, sync: :sequencer do
  stop if main_control[1] == 0
  sleep $sleeps2.tick; synth :blade, note: key[$notes2.look], cutoff: 60
end

live_loop :riff1_alt, sync: :sequencer do
  stop if main_control[2] == 0
  sleep $sleeps3.tick; synth :blade, note: key[$notes3.look], cutoff: 60
end

live_loop :bassline2, sync: :sequencer do
  stop if main_control[3] == 0
  sleep $sleeps4.tick(:one); synth :blade, note: key[$notes4.tick(:two)], cutoff: 50, sustain: $sleeps4[look(:one) + 1] - 0.1, amp: 3
end

live_loop :riff2_main, sync: :sequencer do
  stop if main_control[4] == 0
  sleep $sleeps6.tick; synth :tb303, note: key[$notes6.look], cutoff: 70, release: 0.5, amp: 1,    pitch: 0.2
end

live_loop :bassline3, sync: :sequencer do
  stop if main_control[5] == 0
  sleep $sleeps2.tick; synth :blade, note: key[$notes5.look], cutoff: 60, release: 0.65, amp: 2.5
end

live_loop :riff2_alt, sync: :sequencer do
  stop if main_control[6] == 0
  sleep $sleeps7.tick; synth :tb303, note: key[$notes7.look], cutoff: 75, release: 0.5, amp: 1, pitch: 0.2
end
