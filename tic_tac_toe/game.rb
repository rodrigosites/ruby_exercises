# Game
class Game
  attr_reader :turn

  def initialize
    @board = [['_', '_', '_'], ['_', '_', '_'], [' ', ' ', ' ']]
    @turn = 1
    @winner = false
    @win_conditions = [['00', '01', '02'], ['00', '11', '22'], ['00', '10', '20'], ['01', '11', '21'],
    ['02', '12', '22'], ['02', '11', '20']]
  end

  def mark_board(player, input)
    @board[input[:row]][input[:column]] = player.plays_first ? 'X' : 'O'
  end

  def used_space(input)
    if @board[input[:row]][input[:column]] != 'X' && @board[input[:row]][input[:column]] != 'O'
      false
    else
      puts 'Invalid choice! That space is already taken.'
      true
    end
  end

  def show_board
    puts "#{@board[0][0]}|#{@board[0][1]}|#{@board[0][2]}"
    puts "#{@board[1][0]}|#{@board[1][1]}|#{@board[1][2]}"
    puts "#{@board[2][0]}|#{@board[2][1]}|#{@board[2][2]}"
  end

  def next_turn
    @turn += 1
  end

  def winner?
    @win_conditions.each do |condition|
      if @board[condition[0].chars[0].to_i][condition[0].chars[1].to_i] == 'X' &&
         @board[condition[1].chars[0].to_i][condition[1].chars[1].to_i] == 'X' &&
         @board[condition[2].chars[0].to_i][condition[2].chars[1].to_i] == 'X'
        show_board
        puts "The winner is #{Player.all.select(&:plays_first).first.name}!"
        @winner = Player.all.select(&:plays_first).first
      elsif @board[condition[0].chars[0].to_i][condition[0].chars[1].to_i] == 'O' &&
            @board[condition[1].chars[0].to_i][condition[1].chars[1].to_i] == 'O' &&
            @board[condition[2].chars[0].to_i][condition[2].chars[1].to_i] == 'O'
        show_board
        puts "The winner is #{Player.all.reject(&:plays_first).first.name}!"
        @winner = Player.all.reject(&:plays_first).first
      end
    end
    unless !@winner && @board.flatten.include?(' ') || @board.flatten.include?('_')
      @winner = 'draw'
      show_board
      puts 'It\'s a draw!'
    end
    @winner
  end

  def set_first_player
    rand(1..2) == 1 ? Player.all.first.plays_first = true : Player.all.last.plays_first = true
  end
end