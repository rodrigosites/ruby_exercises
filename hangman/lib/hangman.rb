# frozen_string_literal: true

require 'json'
require_relative 'game'

game = Game.new

if game.start == '2'
  File.open('savedgames/test.json', 'r') do |file|
    game = Game.from_json(file.read)
  end
end

until game.over?
  game.draw_hangman(game.wrong_letters.length)
  game.draw_correct_letters
  game.draw_wrong_letters
  player_guess = game.ask_player_guess
  if game.correct_guess?(player_guess)
    game.save_correct_guess(player_guess)
    game.draw_correct_letters
  else
    game.wrong_letters << player_guess
    game.draw_wrong_letters
  end
  game.round += 1
  File.open('savedgames/test.json', 'w') { |file| file.write(game.to_json) }
end
