module TicTacToe
  class Player

    attr_accessor :name, :symbol

    def initialize(name, is_computer)
      @name = name
      @is_computer = is_computer
    end

    def select_position(posible_positions)
      @is_computer ? select_random_position(posible_positions) : receive_player_input
    end

	private
    def select_random_position(posible_positions)
      index = rand(posible_positions.size)
      make_computer_think
      posible_positions[index]
    end

	private
    def make_computer_think
      print "Thinking."
	  2.times do
		sleep(1)
		print "."
	  end
    end

	private
    def receive_player_input
      puts "Select the position"
      position = STDIN.gets.chomp
    end

  end
end