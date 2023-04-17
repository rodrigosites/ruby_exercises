# frozen_string_literal: true

# Board
class Board
  COLORS = %w[blue black green red yellow white].freeze
  TURNS = 12
  COLUMNS = 4

  attr_reader :guess_board, :win_condition, :correct_code, :feedback_board, :feedback_check

  def initialize
    @guess_board = []
    @feedback_board = []
    @correct_code = []
    @feedback_check = []
    @win_condition = false
    COLUMNS.times { @correct_code.push(COLORS[rand(0..5)]) }
    TURNS.times do
      @guess_board.push(%w[. . . .])
      @feedback_board.push(%w[_ _ _ _])
    end
  end

  def mark_guess(row_line, guesses)
    guesses.each_with_index { |guess, index| @guess_board[row_line - 1][index] = guess }
  end

  def check_win_condition(round)
    return unless guess_board[round] == @correct_code

    @feedback_board[round] = %w[X X X X]
    @win_condition = true
  end

  def check_correct_marks(round)
    feedback_count = 0
    @feedback_check = []
    @guess_board[round].each_with_index do |guess, index|
      if guess == @correct_code[index]
        @feedback_board[round][feedback_count] = 'X'
        feedback_count += 1
      else
        @feedback_check.push(index)
      end
    end
  end

  def check_partial_marks(round)
    feedback_count = COLUMNS - @feedback_check.length
    @feedback_check.each do |index|
      if @correct_code.values_at(*@feedback_check).include?(@guess_board[round][index])
        @feedback_board[round][feedback_count] = 'x'
        feedback_count += 1
      end
    end
  end

  def clear_feedback_check
    @feedback_check.clear
  end

  def show_board
    @guess_board.each_with_index do |row, index|
      puts "#{format('%02d', index + 1)} - | #{row[0]} #{row[1]} #{row[2]} #{row[3]} | #{@feedback_board[index][0]}#{@feedback_board[index][1]}#{@feedback_board[index][2]}#{@feedback_board[index][3]} "
    end
  end
end
