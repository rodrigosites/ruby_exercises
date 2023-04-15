# frozen_string_literal: true

require 'pry'

# Board
class Board
  COLORS = %w[blue black green red yellow white].freeze
  TURNS = 12
  COLUMNS = 4

  def initialize
    @guess_board = []
    @feedback_board = []
    @correct_code = []
    COLUMNS.times { @correct_code.push(COLORS[rand(0..5)]) }
    TURNS.times do
      @guess_board.push(%w[. . . .])
      @feedback_board.push(%w[_ _ _ _])
    end
  end

  def mark_row(row_line, guess)
    @board[row_line - 1] = guess
  end

  def show_board
    @guess_board.each_with_index do |row, index|
      puts "#{format('%02d', index + 1)} - | #{row[0]} #{row[1]} #{row[2]} #{row[3]} | #{@feedback_board[index][0]}#{@feedback_board[index][1]}#{@feedback_board[index][2]}#{@feedback_board[index][3]} "
    end
  end
end

board = Board.new
board.show_board
