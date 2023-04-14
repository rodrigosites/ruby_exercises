# frozen_string_literal: true

require_relative 'game'
require_relative 'player'

game = Game.new
puts 'Tic Tac Toe Game'
puts 'Whats the Player 1 name?'
player1 = Player.new(gets.chomp)
puts 'Whats the Player 2 name?'
player2 = Player.new(gets.chomp)
puts 'Starting the game.'
puts 'The board is blank:'
game.show_board
game.set_first_player
first_player = Player.all.select(&:plays_first).first
second_player = Player.all.reject(&:plays_first).first
puts "Rolling the dices. First player to play is going to be #{first_player.name} using X."
until game.winner?
  puts "Turn #{game.turn}:"
  begin first_player.receive_input end while game.used_space(first_player.input)
  game.mark_board(first_player, first_player.input)
  break if game.winner?

  game.show_board
  puts "Now its time to #{second_player.name} choose."
  begin second_player.receive_input end while game.used_space(second_player.input)
  game.mark_board(second_player, second_player.input)
  break if game.winner?

  puts 'How the board looks now:'
  game.show_board
  game.next_turn
  next
end
