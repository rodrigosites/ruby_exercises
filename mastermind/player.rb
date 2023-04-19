# frozen_string_literal: true

require_relative 'settings'

# Player
class Player
  include Settings
  attr_reader :guess, :function, :code

  def initialize(player_type)
    @guess = []
    @function = nil
    @code = nil
    @type = player_type
    @ai_guesses = [] if @type == 'computer'
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

  def generate_guess(last_feedback = [])
    @ai_guess = COLORS.repeated_permutation(4).to_a if @ai_guesses.empty?
    @guess = %w[black black blue blue] if @guess.empty?
    unless last_feedback.empty?
      if (last_feedback.count('X') + last_feedback.count('x')).zero?
        @ai_guess = @ai_guess.difference(@guess.uniq.repeated_permutation(4).to_a)
        @guess = @ai_guess.first
      end
    end
  end
end
