#Six Pianos - Steve Reich - DATA
#Arranged for Sonic Pi by Marc St. Pierre May 2018


# ========================== DATA ===========================

$secn1 = [
  [:fs4, :b4, :cs5, :b4, :cs5, :fs4, :b4, :cs5], #player 1a
  [:r, :d5, :e5, :d5, :fs5, :r, :d5, :e5], #player 1b
  [:b3, :e4, :fs4, :e4, :fs4, :b3, :e4, :fs4], #player 2a
  [:r, :g4, :a4, :g4, :b4, :r, :g4, :a4], #player 2b
  [:d3, :a3, :cs4, :a3, :cs4, :d3, :a3, :cs4], #player 3a
  [:r, :d4, :e4, :d4, :fs4, :r, :d4, :e4], #player 3b
]

$sol1 = [
  [:r, :d4, :cs4, :d4, :fs4, :r, :d5, [:cs5, :fs4]],
  [:fs4, :g4, :fs4, :g4, :fs4, :fs4, :g4, :fs4],
  [:fs4, :g4, :a4, :b4, :cs5, :fs4, :d5, :cs5],
  [:fs4, :d5, :cs5, :d5, :cs5, :fs4, :d5, :cs5],
  [[:cs5, :e5], [:b4, :d5], [:cs5, :fs5], [:cs5, :e5], [:b4, :d5], [:cs5, :e5]],
  [:e5, :d5, :cs5, :fs4, :fs4, :e5, :d5, :cs5]
]

$secn2 = [
  [:e4, :a4, :cs5, :a4, :b4, :e4, :a4, :cs5], #player 1a
  [:r, :d5, :e5, :d5, :e5, :r, :d5, :e5], #player 1b
  [:b3, :e4, :fs4, :e4, :fs4, :b3, :e4, :fs4], #player 2a
  [:r, :g4, :a4, :g4, :b4, :r, :g4, :a4], #player 2b
  [:e3, :b3, :d4, :b3, :d4, :e3, :b3, :d4], #player 3a
  [:r, :e4, :a4, :e4, :g4, :r, :e4, :a4], #player 3b
]

$sol2 = [
  [:fs4, :b3, :e4, :fs4, :g4, :fs4, :b3, :fs4],
  [:a4, :d5, :e5, :d5, :e5, :b4, :d5, :e5],
  [:r, :d5, :cs5, :d5, :b4, :r, :r, [:cs5, :e5]],
  [:fs4, :d5, :fs4, :r, :r, :fs4, :d5, :fs4],
  [:r, :r, [:cs5, :a4], [:a4, :e4], [:b4, :g4], :r, [:d5, :b3], [:cs5, :a4],
   :r, :r, [:cs5, :a4], [:a4, :e4], [:b4, :g4], :r, [:d5, :b3], :r],
  [:e4, :e5, :e4, :e5, :e4, :d5, :e5, :e4],
  [:e3, :b3, :fs4, :b3, :d4, :e3, :b3, :e4],
  [[:cs3, :fs3], :e3, [:cs3, :fs3], :d3, :d3, [:cs3, :fs3], :e3, :e3]
]

$secn3 = [
  [:fs4, :b4, :cs5, :b4, :d5, :fs4, :b4, :cs5], #player 1a
  [:r, :e5, :fs5, :e5, :fs5, :r, :e5, :fs5], #player 1b
  [:b3, :e4, :fs4, :e4, :g4, :b3, :e4, :fs4], #player 2a
  [:r, :a4, :b4, :a4, :b4, :r, :a4, :b4], #player 2b
  [:b4, :b5, :e5, :b5, :d5, :b4, :fs4, :g4], #player 3a
  [:r, :fs5, :a4, :fs5, :a4, :r, :fs5, :a4], #player 3b
]


# ========================== HELPER FUNCTIONS ===========================

define :loud_soft do |list, nbars|
  sync :seq
  in_thread do
    y = 0.1
    nbars.times do |x|
      8.times {play list.ring.tick, release: 0.5, amp: y; sleep 0.5}
      y = -1*Math.cos(((Math::PI * 2.0)/nbars.to_f) * (x + 1.0)) + 1.2
    end
  end
end

define :from_player do |num, section, offset|
  section[2*num - 2]
  .zip(section[2*num - 1])
  .rotate(offset)
  .ring
end

define :sub_rests do |list|
  temp_num = 0
  list.each {|num| temp_num |= 2**(num - 1)}
  temp_num
end