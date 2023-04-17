# frozen_string_literal: true

# Player
class Player
  attr_reader :guess, :function, :code

  def initialize(player_type)
    @guess = []
    @function = nil
    @code = nil
    @type = player_type
  end

  def ask_guess
    puts 'Type your guess:'
    @guess = gets.chomp.split
  end

  def ask_code
    puts 'Type the code you want to be the the key:'
    @code = gets.chomp.split
  end

  def ask_function
    @function = gets.chomp
  end

  def generate_guess
    COLUMNS.times { @guess.push(COLORS[rand(0..5)]) }
  end
end
