module TicTacToe  
  class Gameplay

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
      @turn = rand(2)
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
      input = read_player_valid_input
      check_input(input)
    end

    def read_player_valid_input
      begin
        input = @players[@turn].select_position(@board.get_empty_positions)
      end while !valid_input?(input)
      input
    end

    def valid_input?(input)
      return true if quit_reset_option?(input)
      if(GridPosition.valid_position_string?(input))
        empty_position?(input)
      else
        @display.display_msg_not_valid_input
        false
      end
    end

    def empty_position?(input)
      if(@board.position_empty?(input))
        true
      else
        @display.display_msg_not_empty_position
        false
      end
    end

    def check_input(input)
      quit_reset_option?(input) ? quit_reset_option_action(input) : completed_player_move(input)
    end

    def quit_reset_option?(option)
      option = option.downcase
      ['help','quit','reset'].include?(option)
    end

    def quit_reset_option_action(option)
      option = option.downcase
      if(option.eql?("help"))
        Instructions.display_gameplay_instructions
      else
        option.eql?("quit") ? quit : reset
      end
    end

    def quit
      @game_finished = true  	
    end

    def reset
      prepare_initial_conditions(@players)
    end

    def completed_player_move(input)
      @board.fill_board_space(input,@players[@turn])
      @display.print_board(@board)
      @checker.result_message(@players[@turn])
      change_turn unless @game_finished
    end

    def change_turn
      @turn = (@turn + 1) % 2
    end

  end
end

