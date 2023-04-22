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
    @ai_guesses = COLORS.repeated_permutation(4).to_a if @type == 'computer'
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
    @guess = %w[black black blue blue] if @guess.empty?
    return if last_feedback.empty?

    @ai_guesses = @ai_guesses.difference(@guess.uniq.repeated_permutation(4).to_a)
    if (last_feedback.count('X') + last_feedback.count('x')).zero?
      possible_guesses = COLORS.difference(@guess.uniq).repeated_permutation(4).to_a
      @ai_guesses = @ai_guesses.intersection(possible_guesses)
    elsif last_feedback == %w[x _ _ _]
      possible_guesses = []
      @guess.uniq.each { |color| possible_guesses += COLORS.difference([color]).permutation(4).to_a }
      possible_guesses.uniq!
      @ai_guesses = @ai_guesses.intersection(possible_guesses)
    end
    @guess = @ai_guesses.first
  end
end
