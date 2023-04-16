require 'pry'
require_relative 'board'
require_relative 'game'
require_relative 'player'

game = Game.new
player = Player.new
board = Board.new

until board.winner
  game.start
  game.show_round
  board.show_board
  player.ask_guess
  board.mark_guess(game.round, player.guess)
  game.next_round
end
