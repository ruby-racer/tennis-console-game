class Game
  POINTS_FOR_DEUCE = 30
  POINTS_TO_STOP_COUNTING = 40

  attr_reader :winner

  def point_won_by(player_index)
    players[player_index].points
  end

  def score(player_index)
    player = players[player_index]

    if deuce?
      if player.advantage?
        @winner = player_index
      else
        update_advantages_by_scored player
      end
      return
    end

    if player.points == POINTS_TO_STOP_COUNTING
      @winner = player_index
    else
      add_points_to_player player
    end
  end

  private

  attr_writer :winner

  def players
    @players ||= 2.times.map { Player.new }
  end

  def deuce?
    first_player.points > POINTS_FOR_DEUCE && second_player.points > POINTS_FOR_DEUCE &&
        first_player.points == second_player.points
  end

  def first_player
    @first_player ||= players[0]
  end

  def second_player
    @second_player ||= players[1]
  end

  def opponent_for_player(player)
    player == first_player ? second_player : first_player
  end

  def update_advantages_by_scored(scored_player)
    opponent = opponent_for_player(scored_player)
    if opponent.advantage?
      opponent.remove_advantage
    else
      scored_player.add_advantage if scored_player.points == opponent.points
    end
  end

  def add_points_to_player(player)
    if player.points < POINTS_FOR_DEUCE
      player.points += 15
    elsif player.points < POINTS_TO_STOP_COUNTING
      player.points += 10
    end
  end
end
