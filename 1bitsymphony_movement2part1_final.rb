#1-Bit Symphony Movement 2 (part 1) - Tristan Perich
#Transcribed for Sonic Pi by Marc St. Pierre

#section1 = [1, 15, 1, 15, 3, 13, 3, 17, 29, 19, 29, 19, 49, 113, 115, 119, 127, 0, 880, 892, 1010
#       2034, 3964, 3840, 3970, 3840, 3852, 3840, 3072, 0]

#interprets numbers from 0-2**12 as binary lists to specify which of the loops are active
flag1 = binary_conv(1)
transition = 1
cue :one

#section2 = [0, 1, 7, 126]
flag2 = binary_conv(0)

##| sequence1 = [0, 4, 3, -1, 2, 6, 5, 4, 3, 1, 2, 7]
n = [0,4,3,-1,2,6,5,4,3,1,2,7]

live_loop :main_control1, sync: :one do
  puts flag1
  puts flag2
  flag1[0] == 1 ? (
    4.times do
      run 4, 2, [16, 25], [1, 0], [0.15], 0.1
      run 2, 2, [14, 32], [-1, 0], [0.15], 0.1
    end
    cue :two
  ) : (
    transition == 1 ? (interrupt; stop) : (cue :two; sleep 6)
  )
end

live_loop :mid1, sync: :two do
  stop if flag1[1] == 0
  run 2, 1, [24, 23], [1], [0.15], 0.1
  sleep 0.75
end


live_loop :left1, sync: :two do
  stop if flag1[2] == 0
  run 2, 1, [23, 22], [-1], [0.15], 0.1
  sleep 0.25
end

live_loop :right1, sync: :two do
  stop if flag1[3] == 0
  run 2, 1, [21, 20], [1], [0.15], 0.1
  sleep 0.5
end

live_loop :mid2, sync: :two do
  stop if flag1[4] == 0
  pat [2, 1, 2, 2, 2, 1], [0.25, 0.25, 0.25, 0.25, 0.5, 0], [14], [0]
end

live_loop :left2, sync: :two do
  stop if flag1[5] == 0
  pat [1, 2, 5, 1, 1], [0.5, 0.25, 0.5, 0.25, 0], [9], [-1]
end

live_loop :right2, sync: :two do
  stop if flag1[6] == 0
  pat [3, 2], [0.25, 0.75, 0.5, 0.75], [10], [1]
end

live_loop :left3, sync: :two do
  stop if flag1[7] == 0
  run 2, 1, [24, 23], [-1], [0.15], 0.1
  sleep 0.5
end

live_loop :lowlong1, sync: :two do
  cue :one
  stop if flag1[8] == 0
  run 3, 1, [6,4,3], [1], [12,13,7], 0
end

live_loop :lowlong2, sync: :two do
  stop if flag1[9] == 0
  run 5, 1, [4,3,2,1,0], [-1], [8,4,6,7,7], 0
end

live_loop :alarm1, sync: :two do
  stop if flag1[10] == 0
  4.times do
    run 2, 1, [17, 13], [0], [0.75], 0
  end
end

live_loop :alarm2, sync: :two do
  stop if flag1[11] == 0
  sleep 1.5
  run 1, 1, [18], [0], [1.25], 0
end

live_loop :sequence1, sync: :two do
  stop if flag2[0] == 0
  
  use_bpm 120
  use_synth :chiplead
  key = scale(:ds3, :dorian, num_octaves: 5)
  
  sleeps = [6, 4, 1, 7, 1, 3, 0.5, 6, 0.5, 2, 7, 2].ring
  
  play key[n.ring.tick(:one) + 7], sustain: (sleeps.tick(:two) - 0.2)
  play key[n.ring.tick(:three) + 14], sustain: (sleeps.tick(:four) - 0.2), amp: 0.5
  sleep sleeps.tick(:five)
end

live_loop :right3, sync: :two do
  stop if flag2[1] == 0
  pat [1, 2], [0.25], [28, 28, 35], [1]
end

live_loop :left4, sync: :two do
  stop if flag2[2] == 0
  pat [2, 1], [0.25], [35, 28, 28, 28], [-1]
end

live_loop :alarm3, sync: :two do
  stop if flag2[3] == 0
  run 2, 1, [18, 14], [0], [1], 0
end

live_loop :alarm4, sync: :two do
  stop if flag2[4] == 0
  run 2, 1, [21, 28], [0], [0.75], 0
end

live_loop :right4, sync: :two do
  stop if flag2[5] == 0
  run 1, 1, [23], [1], [0.15], 0.1
  sleep 2
end

live_loop :left5, sync: :two do
  stop if flag2[6] == 0
  sleep 0.50
  run 1, 1, [22], [-1], [0.15], 0.1
  sleep 1.25
end
