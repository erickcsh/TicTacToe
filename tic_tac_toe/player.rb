module TicTacToe
  class Player

    attr_accessor :name, :symbol

    def initialize(name, options)
      @name = name
      @is_computer = options[:computer]
      @display = Display.new
    end

    def select_position(posible_positions)
      @is_computer ? select_random_position(posible_positions) : receive_player_input
    end

    private
    def select_random_position(posible_positions)
      index = rand(posible_positions.size)
      make_computer_think
      posible_positions[index].position
    end

    def make_computer_think
      @display.display_msg_computer_thinking
    end

    def receive_player_input
      @display.display_msg_select_position
      Display.read_line
    end

  end
end
