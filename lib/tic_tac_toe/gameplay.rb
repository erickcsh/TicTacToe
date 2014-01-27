module TicTacToe  
  class Gameplay

    VALID_INPUT = 0
    NOT_VALID_INPUT = 1
    NOT_EMPTY_INPUT_POSITION = 2

    def initialize(players)
      prepare_initial_conditions(players)
    end

    def play
      player_turn while !@game_finished
    end

    def finish_game
      quit
    end

    private
    def prepare_initial_conditions(players)
      @board = Board.new
      @players = players
      @turn = Kernel.rand(2)
      @game_finished = false
      @display = Display.new
      @checker = Checker.new(self)
      @board.add_observer(@checker)
      set_players_symbols
    end

    def set_players_symbols
      @players[@turn].symbol = "X" 
      @players[(@turn + 1) % 2].symbol = "O"
    end

    def player_turn
      @display.display_turn_status(@board, @players[@turn].name)
      input = read_player_valid_input.downcase
      check_input(input)
    end

    def read_player_valid_input
      begin
        input = select_position(@players[@turn], @board.get_empty_positions)
        validated_input = input_validation(input)
        input_error_message(validated_input)
      end while !valid_input?(validated_input)
      input
    end

    def select_position(player, posible_positions)
      if player.computer?
        select_random_position(posible_positions)
      else
        receive_player_input
      end
    end

    def input_validation(input)
      return VALID_INPUT if quit_reset_option?(input)
      if(GridPosition.valid_position_string?(input))
        @board.position_empty?(input) ? VALID_INPUT : NOT_EMPTY_INPUT_POSITION
      else
        NOT_VALID_INPUT
      end

    end

    def select_random_position(posible_positions)
      index = Kernel.rand(posible_positions.size)
      @display.display_msg_computer_thinking
      posible_positions[index].position
    end

    def receive_player_input
      @display.display_msg_select_position
      Display.read_line
    end


    def valid_input?(validated_input)
      validated_input == VALID_INPUT
    end

    def input_error_message(validated_input)
     case validated_input
     when NOT_VALID_INPUT
       @display.display_msg_not_valid_input
     when NOT_EMPTY_INPUT_POSITION
       @display.display_msg_not_empty_position
     end 
    end

    def check_input(input)
      quit_reset_option?(input) ? quit_reset_option_action(input) : completed_player_move(input)
    end

    def quit_reset_option?(option)
      ['help','quit','reset'].include?(option)
    end

    def quit_reset_option_action(option)
      case option
      when 'help' then @display.display_gameplay_instructions
      when 'quit' then quit
      when 'reset' then reset
      end
    end

    def quit
      @game_finished = true
    end

    def reset
      prepare_initial_conditions(@players)
    end

    def completed_player_move(input)
      @board.fill_board_space(input, @players[@turn])
      @display.print_board(@board)
      result_message(@players[@turn])
      change_turn unless @game_finished
    end

    def result_message(player)
      @display.display_msg_draw if @checker.draw
      @display.display_msg_win(player.name) if @checker.win
    end

    def change_turn
      @turn = (@turn + 1) % 2
    end
  end
end
