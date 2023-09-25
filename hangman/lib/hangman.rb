# frozen_string_literal: true

require 'json'
require_relative 'game'

game = Game.new

if game.start == '2'
  saved = File.open('savedgames/test.json')
  loaded_game = JSON.parse(saved.read)
  saved.close
  game = loaded_game
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
    game.save_wrong_letter(player_guess)
    game.draw_wrong_letters
  end
  dump = JSON.dump(game)
  File.open('savedgames/test.json', 'w') { |file| file.write dump }
end
