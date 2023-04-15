# Game
class Game
  def initialize
    @round = 1
  end

  def start
    puts 'MASTERMIND'
  end

  def show_round
    puts "ROUND #{@round}"
  end

  def next_round
    @round += 1
  end
end
