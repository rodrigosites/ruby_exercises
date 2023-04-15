require 'pry'

class Board
  COLORS = ['blue', 'black', 'green', 'red', 'yellow', 'white']
  TURNS = 12
  COLUMNS = 4

  def initialize
    @guess_board = []
    @feedback_board = []
    @correct_code = []
    COLUMNS.times { @correct_code.push(COLORS[rand(0..5)]) }
    TURNS.times { @guess_board.push(['.', '.', '.', '.']) }
  end

  def mark_row(row_line, guess)
    @board[row_line - 1] = guess
  end

  def show_board
    @guess_board.each do |row|
      puts "| #{row[0]} #{row[1]} #{row[2]} #{row[3]} | "
    end
  end
end