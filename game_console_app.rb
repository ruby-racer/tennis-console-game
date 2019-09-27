require_relative 'app/player'
require_relative 'app/game'

class GameConsoleApp
  PLAYERS_MAP = { a: 0, b: 1 }

  def run
    while game.winner.nil?
      game.score(ask_player_to_add_scores)

      show_points_won_by_players
    end

    show_winner
  end

  private

  def show_winner
    p "Player #{PLAYERS_MAP.key(game.winner)} won!"
  end

  def show_points_won_by_players
    %i(a b).each do |player|
      p "Player #{player}: #{game.point_won_by(PLAYERS_MAP[player])}"
    end
  end

  def ask_player_to_add_scores
    loop do
      p 'Who should get a point? [a/b]'
      player = PLAYERS_MAP[gets.chomp.to_sym]
      break player unless player.nil?
      ask_to_retry
    end
  end

  def ask_to_retry
    p 'Please try again.'
  end

  def game
    @game ||= Game.new
  end
end

GameConsoleApp.new.run
