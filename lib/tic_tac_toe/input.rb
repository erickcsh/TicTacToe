module TicTacToe
  class Input

    ONE_PLAYER_MODE = 1
    TWO_PLAYER_MODE = 2
    VALID_INPUT = 0
    NOT_VALID_INPUT = 1
    NOT_EMPTY_INPUT_POSITION = 2

    @@display = Display.new

    def self.ask_mode
      @@display.display_modes_options
      Input.enter_mode
    end

    def self.ask_name(player_number)
      @@display.display_msg_ask_for_player_name(player_number)
      Display.read_line
    end

    def self.ask_replay
      @@display.display_msg_replay
      Display.read_line.downcase
    end

    def self.ask_player_action(player, board)
      begin
        input = Input.select_position(player, board.get_empty_positions)
        validated_input = Input.input_validation(input, board)
        Input.input_error_message(validated_input)
      end while !Input.valid?(validated_input)
      input.downcase
    end

    private
    def self.select_position(player, posible_positions)
      if player.computer?
        Input.select_random_position(posible_positions)
      else
        Input.receive_player_input
      end
    end

    def Input.input_validation(input, board)
      return VALID_INPUT if Input.quit_reset_option?(input)
      if(GridPosition.valid_position_string?(input))
        board.position_empty?(input) ? VALID_INPUT : NOT_EMPTY_INPUT_POSITION
      else
        NOT_VALID_INPUT
      end
    end

    def Input.select_random_position(posible_positions)
      index = Kernel.rand(posible_positions.size)
      @@display.display_msg_computer_thinking
      posible_positions[index].position
    end

    def Input.receive_player_input
      @@display.display_msg_select_position
      Display.read_line
    end


    def Input.valid?(validated_input)
      validated_input == VALID_INPUT
    end

    def Input.input_error_message(validated_input)
     case validated_input
     when NOT_VALID_INPUT
       @@display.display_msg_not_valid_input
     when NOT_EMPTY_INPUT_POSITION
       @@display.display_msg_not_empty_position
     end 
    end

    def Input.quit_reset_option?(option)
      ['help','quit','reset'].include?(option)
    end

    def self.enter_mode
      mode = Display.read_line
      while !Input.valid_mode?(mode.to_i)
        @@display.display_error_msg_mode
        mode = Display.read_line
      end
      mode.to_i
    end

    def self.valid_mode?(mode)
      [ONE_PLAYER_MODE, TWO_PLAYER_MODE].include?(mode)
    end
  end
end
