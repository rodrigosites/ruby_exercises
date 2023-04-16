# frozen_string_literal: true

# Game
class Game
  attr_reader :round

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
