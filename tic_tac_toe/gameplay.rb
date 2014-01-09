module TicTacToe  
  class Gameplay

    def initialize(players)
      prepare_initial_conditions(players)
    end

    def play
      while !game_finished? do
        player_turn
      end
    end

    private
    def prepare_initial_conditions(players)
      @board = Board.new
      @players = players
      @turn = rand(2)
      @game_finished = false
      @display = Display.new
      @checker = Checker.new()
      @board.add_observer(@checker)
      set_players_symbols
    end

    def set_players_symbols
      @players[@turn].symbol = 1
      @players[(@turn + 1) % 2].symbol = 2
    end

    def game_finished?
      @game_finished
    end

    def player_turn
      @display.display_turn_status(@board, @players[@turn].name)
      input = get_player_valid_input
      check_input(input)
    end

    def get_player_valid_input
      begin
        input = @players[@turn].select_position(@board.get_empty_positions)
      end while !is_valid_input?(input)
      input
    end

    def is_valid_input?(input)
      return true if is_quit_reset_option?(input)
      if(GridPosition.valid_position_string?(input))
        is_empty_position?(input)
      else
        @display.display_msg_not_valid_input
        false
      end
    end

    def is_empty_position?(input)
      if(@board.is_position_empty?(input))
        true
      else
        @display.display_msg_not_empty_position
        false
      end
    end

    def check_input(input)
      is_quit_reset_option?(input) ? quit_reset_option_action(input) : completed_player_move(input)
    end

    def is_quit_reset_option?(option)
      option = option.downcase
      option.eql?("help") || option.eql?("quit") || option.eql?("reset")
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
      check_for_ending_move
      change_turn
    end

    def check_for_ending_move
      @display.print_board(@board)
      @game_finished = @checker.ending_move?(@players[@turn])
    end

    def change_turn
      @turn = (@turn + 1) % 2
    end

  end
end

