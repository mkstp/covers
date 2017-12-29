key = scale(:ds2, :dorian, num_octaves: 8)

#main sound generation
define :run do |iterations,voices,notes,position,time,decay|
  use_bpm 120
  use_synth :chiplead
  
  with_fx :distortion, distort: 0.2 do
    iterations.times do
      voices.times do
        play key[notes.ring.tick(:two)], sustain: time.ring.tick(:one), release: decay, pan: position.ring.tick(:three)
      end
      sleep (time.ring.tick(:four) + decay)
    end
  end
end

#makes use of run to make patterns
define :pat do |numList, sleepList, notes, position|
  numVal = numList.length
  numVal.times do
    run numList.ring.tick(:five), 1, notes, position, [0.15], 0.1
    sleep sleepList.ring.tick(:six)
  end
end

#this function takes in a number, interprets it as binary, then creates a list of those binary digits
define :binary_conv do |num|
  binList = [0]*12
  num = num.to_s(2).split(//)
  list = num.map {|i| i.to_i}
  for i in list
    binList.unshift(i); binList.pop
  end
  return binList
end

define :interrupt do
  run 12, 1, [21], [0], [0.15], 0.1
  cue :two
end



