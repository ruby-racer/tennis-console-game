class Player
  attr_accessor :points

  def initialize
    @points = 0
    @advantage = false
  end

  def advantage?
    @advantage
  end

  def add_advantage
    @advantage = true
  end

  def remove_advantage
    @advantage = false
  end
end
