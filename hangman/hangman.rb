# frozen_string_literal: true

gibbet = [' ____ ',
          '|    |',
          "|\n|\n|\n|",
          '|',
          '|_____',
          '|     |',
          '|_____|']

hangman = ["|    O\n|\n|\n|",
           "|    O\n|    |\n|\n|",
           "|    O\n|   /|\n|\n|",
           "|    O\n|   /|\\\n|\n|",
           "|    O\n|   /|\\\n|    |\n|",
           "|    O\n|   /|\\\n|    |\n|   / ",
           "|    O\n|   /|\\\n|    |\n|   / \\"]

def draw_hangman(gibbet, hangman, errors, round)
  puts "\n------------- HANGMAN - ROUND #{round} -------------"
  gibbet[2] = hangman[errors - 1] if errors.positive?
  gibbet.each { |line| puts line }
end

def draw_correct_letters(correct_letters)
  print "\nSecret world: "
  correct_letters.chars.each { |letter| print "#{letter} " }
  print "\n"
end

def draw_wrong_letters(wrong_letters)
  print 'Wrong guesses: '
  wrong_letters.each { |letter| print "#{letter} " }
  print "\n"
end

def ask_player_guess
  print "\nType your guess letter: "
  gets.chomp.downcase[0]
end

def correct_guess?(secret_word, player_guess)
  secret_word.include?(player_guess)
end

def save_correct_guess(secret_word, correct_letters, player_guess)
  current_index = secret_word.index(player_guess)
  correct_letters[current_index] = player_guess
  while current_index
    current_index = secret_word.index(player_guess, current_index + 1)
    correct_letters[current_index] unless current_index.nil?
  end
  correct_letters
end

def win_condition?(secret_word, correct_letters)
  secret_word == correct_letters
end

def loss_condition?(wrong_letters)
  wrong_letters.length >= 7
end

def fetch_word_from_dictionary
  if File.exist?('google-10000-english-no-swears.txt')
    dictionary = File.read('google-10000-english-no-swears.txt').split
  end
  secret_word = dictionary.select { |word| word.length >= 5 && word.length <= 12 }.sample
  puts "Secret word is #{secret_word}"
  secret_word
end

secret_word = fetch_word_from_dictionary
correct_letters = ''.rjust(secret_word.length, '_')
wrong_letters = []
round = 0

until win_condition?(secret_word, correct_letters) || loss_condition?(wrong_letters)
  draw_hangman(gibbet, hangman, wrong_letters.length, round)
  draw_correct_letters(correct_letters)
  draw_wrong_letters(wrong_letters)

  player_guess = ask_player_guess
  if correct_guess?(secret_word, player_guess)
    correct_letters = save_correct_guess(secret_word, correct_letters, player_guess)
    draw_correct_letters(correct_letters)
  else
    wrong_letters << player_guess
    draw_wrong_letters(wrong_letters)
  end
  round += 1
end

if win_condition?(secret_word, correct_letters)
  puts 'You win!'
else
  draw_hangman(gibbet, hangman, wrong_letters.length, round)
  draw_correct_letters(correct_letters)
  draw_wrong_letters(wrong_letters)
  puts 'You lose!'
end
