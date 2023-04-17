require 'pry'
require_relative 'board'
require_relative 'game'
require_relative 'player'

game = Game.new
player = Player.new
board = Board.new

game.start
until board.win_condition
  game.show_round
  board.show_board
  player.ask_guess
  board.mark_guess(game.round, player.guess)
  board.check_win_condition(game.round - 1)
  board.check_correct_marks(game.round - 1)
  board.check_partial_marks(game.round - 1)
  board.clear_feedback_check
  game.next_round
end
puts 'You win!'
