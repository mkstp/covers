use_bpm 150
beat_count  = 32
key = scale(:e3, :chromatic, num_octaves: 2)

track_names = [
  :bass,
  :hats,
  :snare,
].ring

beat_patterns = track_names.map {|track| b = $beat_data[track]; binary_conv(b[0], b[1])}

live_loop :drums, sync: :down_beat do
  beat_count.times do
    beat_patterns.each {|p| t = track_names.tick; on (p.tick(t)) {hit_drum(t)}};
    sleep 0.25
  end
  tick_reset
end

live_loop :count_in do
  4.times {hit_drum(:sticks); sleep 1}
  cue :down_beat
end

voice_names = [
  :voice1,
  :voice2,
  :voice3,
  ##| :bridge1,
  ##| :bridge2,
].ring

arpeggi_patterns = transpose_condense(voice_names, $voice_data, beat_count)

live_loop :arpeggi, sync: :drums do
  melody = arpeggi_patterns.tick(:one)
  beat_count.times do
    voice = melody.tick(:two); key.each {|notes| on voice[tick(:three)%key.size] {visualize(notes, :chipbass)}}
    binary_conv(voice, key.size)
    sleep 0.5
  end
end











