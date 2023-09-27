# frozen_string_literal: true

require 'json'
require_relative 'game'

game = Game.new

if game.start == '2'
  begin
    print 'Type the name of the save file you wanna load: '
    save_file = gets.chomp.downcase
    unless File.exist?("savedgames/#{save_file}.json")
      raise "There is no \'#{save_file}.json\' file in the savedgames folder. Try again please."
    end
  rescue StandardError => e
    puts
    puts e.to_s
    retry
  end
  File.open("savedgames/#{save_file}.json", 'r') { |file| game = Game.from_json(file.read) }
end

until game.over?
  game.draw_hangman(game.wrong_letters.length)
  game.draw_correct_letters
  game.draw_wrong_letters
  player_guess = game.ask_player_guess
  if player_guess == 'save'
    print 'Type the name of the save file: '
    save_file = gets.chomp.downcase
    File.open("savedgames/#{save_file}.json", 'w') { |file| file.write(game.to_json) }
    puts "Game saved at savedgames/#{save_file}.json"
    puts 'Thanks for playing! Closing game.'
    break
  elsif game.correct_guess?(player_guess)
    game.save_correct_guess(player_guess)
    game.draw_correct_letters
  else
    game.wrong_letters << player_guess
    game.draw_wrong_letters
  end
  game.round += 1
end
