# Player
class Player
  attr_reader :name
  attr_accessor :input, :plays_first

  @@all = []

  def initialize(name)
    @name = name
    @input = { row: nil, column: nil }
    @plays_first = false
    @@all.push(self)
  end

  def receive_input
    loop do
      puts "#{name}, please select the row and column (between 1 and 3) you wanna mark, using space to separate the row from the column:"
      input = gets.chomp
      if input.size > 3 || input.chars[0].to_i < 1 || input.chars[0].to_i > 3 || input.chars[2].to_i < 1 ||
         input.chars[2].to_i > 3
        puts 'Your choice did not meet the criteria above.'
      else
        @input[:row] = input.chars[0].to_i - 1
        @input[:column] = input.chars[2].to_i - 1
        break
      end
    end
  end
  
  def self.all
    @@all
  end
end