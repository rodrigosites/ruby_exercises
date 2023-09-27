# frozen_string_literal: true

HANGMAN = ["|    O\n|\n|\n|",
           "|    O\n|    |\n|\n|",
           "|    O\n|   /|\n|\n|",
           "|    O\n|   /|\\\n|\n|",
           "|    O\n|   /|\\\n|    |\n|",
           "|    O\n|   /|\\\n|    |\n|   / ",
           "|    O\n|   /|\\\n|    |\n|   / \\"].freeze

GIBBET = [' ____ ',
          '|    |',
          "|\n|\n|\n|",
          '|',
          '|_____',
          '|     |',
          '|_____|']

# Game class
class Game
  attr_accessor :wrong_letters, :round

  def initialize(args = {})
    @gibbet = GIBBET
    @secret_word = args[:secret_word].nil? ? fetch_word_from_dictionary : args[:secret_word]
    @correct_letters = args[:correct_letters].nil? ? String.new.rjust(@secret_word.length, '_') : args[:correct_letters]
    @wrong_letters = args[:wrong_letters].nil? ? [] : args[:wrong_letters]
    @round = args[:round].nil? ? 0 : args[:round]
  end

  def to_json
    {
      secret_word: @secret_word,
      correct_letters: @correct_letters,
      wrong_letters: @wrong_letters,
      round: @round
    }.to_json
  end

  def self.from_json(json_str)
    data = JSON.parse(json_str, { symbolize_names: true })
    new(data)
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
    @gibbet[2] = HANGMAN[errors - 1] if errors.positive?
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
      return guess if guess == 'save'
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
  end

  def over?
    if @secret_word == @correct_letters
      puts 'You win!'
      true
    elsif @wrong_letters.length >= 7
      draw_hangman(@wrong_letters.length)
      draw_correct_letters
      draw_wrong_letters
      puts "You lose! The secret word was #{@secret_word}."
      true
    end
  end

  def fetch_word_from_dictionary
    if File.exist?('google-10000-english-no-swears.txt')
      dictionary = File.read('google-10000-english-no-swears.txt').split
    end
    dictionary.select { |word| word.length >= 5 && word.length <= 12 }.sample
  end
end
