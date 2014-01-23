module TicTacToe
  class Player

    attr_accessor :name, :symbol

    def initialize(name, options = { computer: false })
      @name = name
      @is_computer = options[:computer]
      @display = Display.new
    end

    def select_position(posible_positions)
      if(@is_computer) then select_random_position(posible_positions) 
      else  receive_player_input
      end
    end

    private
    def select_random_position(posible_positions)
      index = Kernel.rand(posible_positions.size)
      @display.display_msg_computer_thinking
      posible_positions[index].position
    end

    def receive_player_input
      @display.display_msg_select_position
      Display.read_line
    end

  end
end
