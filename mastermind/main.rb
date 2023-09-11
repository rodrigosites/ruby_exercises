# frozen_string_literal: true


require 'pry'
require_relative 'board'
require_relative 'game'
require_relative 'player'
require_relative 'settings'
include Settings

game = Game.new
player = Player.new('player')
game.start
player.ask_function
if player.function == 'codemaker'
  player.ask_code
  computer = Player.new('computer')
  board = Board.new(player.code)
else
  board = Board.new
end
until board.win_condition
  game.show_round
  if player.function == 'codemaker'
    game.round > 1 ? computer.generate_guess(board.feedback_board[game.round - 2]) : computer.generate_guess
    board.mark_guess(game.round - 1, computer.guess)
  else
    player.ask_guess
    board.mark_guess(game.round - 1, player.guess)
  end
  board.check_win_condition(game.round - 1)
  board.check_correct_marks(game.round - 1)
  board.check_partial_marks(game.round - 1)
  board.show_board
  board.clear_feedback_check
  game.next_round
  break if game.round > TURNS
end
if board.win_condition && player.function == 'codebreaker'
  puts 'You win!'
elsif !board.win_condition && player.function == 'codemaker'
  puts 'You win!'
else
  puts 'You lose!'
  puts "The correct code was #{board.correct_code}"
end
