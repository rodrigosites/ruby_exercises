# frozen_string_literal: true

# Game
class Game
  attr_reader :round

  def initialize
    @round = 1
  end

  def start
    puts 'MASTERMIND'
    puts 'Do you wish to be the code creator or the guesser?'
    puts 'Type 1 for code creator or 2 for guesser:'
  end

  def show_round
    puts "ROUND #{@round}"
  end

  def next_round
    @round += 1
  end
end
