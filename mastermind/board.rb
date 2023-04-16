# frozen_string_literal: true

# Board
class Board
  COLORS = %w[blue black green red yellow white].freeze
  TURNS = 12
  COLUMNS = 4

  attr_reader :guess_board, :win_condition

  def initialize
    @guess_board = []
    @feedback_board = []
    @correct_code = []
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

  def mark_feedback(round)
    if guess_board[round] == @correct_code
      @feedback_board[round] = %w[X X X X]
      @win_condition = true
    else
      feedback_exact = []
      feedback_partial = []
      @guess_board[round].each_with_index do |guess, index|
        if guess == @correct_code[index]
          @feedback_board[round][feedback_exact] = 'X'
          feedback_exact.push(index)

      
    end
  end

  def show_board
    @guess_board.each_with_index do |row, index|
      puts "#{format('%02d', index + 1)} - | #{row[0]} #{row[1]} #{row[2]} #{row[3]} | #{@feedback_board[index][0]}#{@feedback_board[index][1]}#{@feedback_board[index][2]}#{@feedback_board[index][3]} "
    end
  end
end
