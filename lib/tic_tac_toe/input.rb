require 'singleton'

module TicTacToe
  class Input
    include Singleton

    ONE_PLAYER_MODE = 1
    TWO_PLAYER_MODE = 2
    VALID_INPUT = 0
    NOT_VALID_INPUT = 1
    NOT_EMPTY_INPUT_POSITION = 2

    def input_mode
      display.display_modes_options
      enter_mode
    end

    def input_name(args)
      display.display_msg_ask_for_player_name(args)
      input_line
    end

    def input_replay
      display.display_msg_replay
      input_line.downcase
    end

    def input_player_action(player, board)
      begin
        input = select_position(player, board.get_empty_positions)
        validated_input = input_validation(input, board)
        input_error_message(validated_input)
      end while !valid?(validated_input)
      input.downcase
    end

    def input_line
      STDIN.gets.chomp
    end

    private
    def display
      Display.instance
    end

    def select_position(player, posible_positions)
      if player.computer?
        select_random_position(posible_positions)
      else
        receive_player_input
      end
    end

    def input_validation(input, board)
      return VALID_INPUT if quit_reset_option?(input)
      if(Board.valid_position_string?(input))
        board.position_empty?(input) ? VALID_INPUT : NOT_EMPTY_INPUT_POSITION
      else
        NOT_VALID_INPUT
      end
    end

    def select_random_position(posible_positions)
      index = Kernel.rand(posible_positions.size)
      display.display_msg_computer_thinking
      posible_positions[index].position
    end

    def receive_player_input
      display.display_msg_select_position
      input_line
    end

    def valid?(validated_input)
      validated_input == VALID_INPUT
    end

    def input_error_message(validated_input)
     case validated_input
     when NOT_VALID_INPUT
       display.display_msg_not_valid_input
     when NOT_EMPTY_INPUT_POSITION
       display.display_msg_not_empty_position
     end 
    end

    def quit_reset_option?(option)
      ['help','quit','reset'].include?(option)
    end

    def enter_mode
      mode = input_line
      while !valid_mode?(mode.to_i)
        display.display_error_msg_mode
        mode = input_line
      end
      mode.to_i
    end

    def valid_mode?(mode)
      [ONE_PLAYER_MODE, TWO_PLAYER_MODE].include?(mode)
    end
  end
end
