# frozen_string_literal: true

# Player
class Player
  attr_reader :guess

  def initialize
    @guess = []
  end

  def ask_guess
    puts 'Type your guess:'
    @guess = gets.chomp.split
  end
end
