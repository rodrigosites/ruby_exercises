# Player
class Player
	def initialize
		@input = []
	end
	
	def input
		input = gets.chomp.split
		input.each do |word|
			@input.p
	end
end