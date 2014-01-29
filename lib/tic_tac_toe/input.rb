require 'singleton'

module TicTacToe
  class Input
    include Singleton

    ONE_PLAYER_MODE = 1
    TWO_PLAYER_MODE = 2
    VALID_INPUT = 0
    NOT_VALID_INPUT = 1
    NOT_EMPTY_INPUT_POSITION = 2

    def ask_mode
      Display.instance.display_modes_options
      enter_mode
    end

    def ask_name(player_number)
      Display.instance.display_msg_ask_for_player_name(player_number)
      Display.read_line
    end

    def ask_replay
      Display.instance.display_msg_replay
      Display.read_line.downcase
    end

    def ask_player_action(player, board)
      begin
        input = select_position(player, board.get_empty_positions)
        validated_input = input_validation(input, board)
        input_error_message(validated_input)
      end while !valid?(validated_input)
      input.downcase
    end

    private
    def select_position(player, posible_positions)
      if player.computer?
        select_random_position(posible_positions)
      else
        receive_player_input
      end
    end

    def input_validation(input, board)
      return VALID_INPUT if quit_reset_option?(input)
      if(GridPosition.valid_position_string?(input))
        board.position_empty?(input) ? VALID_INPUT : NOT_EMPTY_INPUT_POSITION
      else
        NOT_VALID_INPUT
      end
    end

    def select_random_position(posible_positions)
      index = Kernel.rand(posible_positions.size)
      Display.instance.display_msg_computer_thinking
      posible_positions[index].position
    end

    def receive_player_input
      Display.instance.display_msg_select_position
      Display.read_line
    end

    def valid?(validated_input)
      validated_input == VALID_INPUT
    end

    def input_error_message(validated_input)
     case validated_input
     when NOT_VALID_INPUT
       Display.instance.display_msg_not_valid_input
     when NOT_EMPTY_INPUT_POSITION
       Display.instance.display_msg_not_empty_position
     end 
    end

    def quit_reset_option?(option)
      ['help','quit','reset'].include?(option)
    end

    def enter_mode
      mode = Display.read_line
      while !valid_mode?(mode.to_i)
        Display.instance.display_error_msg_mode
        mode = Display.read_line
      end
      mode.to_i
    end

    def valid_mode?(mode)
      [ONE_PLAYER_MODE, TWO_PLAYER_MODE].include?(mode)
    end
  end
end
