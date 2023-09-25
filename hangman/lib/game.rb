# frozen_string_literal: true

# Game class
class Game
  attr_reader :wrong_letters

  def initialize
    @gibbet = [' ____ ',
               '|    |',
               "|\n|\n|\n|",
               '|',
               '|_____',
               '|     |',
               '|_____|']
    @hangman = ["|    O\n|\n|\n|",
                "|    O\n|    |\n|\n|",
                "|    O\n|   /|\n|\n|",
                "|    O\n|   /|\\\n|\n|",
                "|    O\n|   /|\\\n|    |\n|",
                "|    O\n|   /|\\\n|    |\n|   / ",
                "|    O\n|   /|\\\n|    |\n|   / \\"]
    @secret_word = fetch_word_from_dictionary
    @correct_letters = String.new.rjust(@secret_word.length, '_')
    @wrong_letters = []
    @round = 0
  end

  def start
    puts 'Welcome to Hangman!'
    puts '1) Start a new game'
    puts '2) Load a saved game'
    print 'Choose your option: '
    player_choice = gets.chomp
    until %w[1 2].include?(player_choice)
      print "\nInvalid choice. Try again: "
      player_choice = gets.chomp
    end
    player_choice
  end

  def draw_hangman(errors)
    puts "\n------------- HANGMAN - ROUND #{@round} -------------"
    @gibbet[2] = @hangman[errors - 1] if errors.positive?
    @gibbet.each { |line| puts line }
  end

  def draw_correct_letters
    print "\nSecret world: "
    @correct_letters.chars.each { |letter| print "#{letter} " }
    print "\n"
  end

  def draw_wrong_letters
    print 'Wrong guesses: '
    @wrong_letters.each { |letter| print "#{letter} " }
    print "\n"
  end

  def ask_player_guess
    begin
      print "\nType your guess letter: "
      guess = gets.chomp.downcase
      raise "Invalid guess #{guess}." unless /[[:alpha:]]/.match(guess) && guess.length == 1
      raise "You've already guessed that letter!" if @correct_letters.include?(guess) ||
                                                     @wrong_letters.include?(guess)
    rescue StandardError => e
      puts
      puts e.to_s
      retry
    end
    guess
  end

  def correct_guess?(player_guess)
    @secret_word.include?(player_guess)
  end

  def save_correct_guess(player_guess)
    current_index = @secret_word.index(player_guess)
    @correct_letters[current_index] = player_guess
    while current_index
      current_index = @secret_word.index(player_guess, current_index + 1)
      @correct_letters[current_index] = player_guess unless current_index.nil?
    end
    @round += 1
  end

  def save_wrong_letter(player_guess)
    @wrong_letters << player_guess
    @round += 1
  end

  def over?
    if @secret_word == @correct_letters
      puts 'You win!'
      true
    elsif @wrong_letters.length >= 7
      draw_hangman(@wrong_letters.length)
      draw_correct_letters
      draw_wrong_letters
      puts 'You lose!'
      true
    end
  end

  def fetch_word_from_dictionary
    if File.exist?('google-10000-english-no-swears.txt')
      dictionary = File.read('google-10000-english-no-swears.txt').split
    end
    secret_word = dictionary.select { |word| word.length >= 5 && word.length <= 12 }.sample
    puts "Secret word is #{secret_word}"
    secret_word
  end
end
