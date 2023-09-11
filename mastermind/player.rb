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
    @possible_combinations = COLORS.repeated_permutation(COLUMNS).to_a if @type == 'computer'
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
    @guess = [COLORS.sample, COLORS.sample, COLORS.sample, COLORS.sample] if @guess.empty?
    return if last_feedback.empty?

    result = { correct_positions: last_feedback.count('X'), correct_colors: last_feedback.count('x') }
    if (result[:correct_positions] + result[:correct_colors]).zero?
      @possible_combinations = COLORS.difference(@guess.uniq).repeated_permutation(COLUMNS).to_a
    else
      @possible_combinations.select! do |combination|
        comparing_result = verify_combination(combination)
        result == comparing_result || comparing_result[:correct_positions] + comparing_result[:correct_colors] > result[:correct_positions] + result[:correct_colors]
      end
    end
    @guess = @possible_combinations.sample
  end

  def verify_combination(combination)
    correct_positions = 0
    correct_colors = 0
    @guess.each_with_index do |color, index|
      if color == combination[index]
        correct_positions += 1
      elsif combination.include?(color)
        correct_colors += 1
      end
    end
    { correct_positions: correct_positions, correct_colors: correct_colors }
  end
end
