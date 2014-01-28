module TicTacToe  
  class Gameplay

    def initialize(players)
      prepare_initial_conditions(players)
    end

    def play
      player_turn while !@game_finished
    end

    def finish_game
      @game_finished = true
    end

    def finished_turn_status(args = { win: false, draw: false })
      @display.print_board(@board)
      @display.display_msg_draw if args[:draw]
      @display.display_msg_win(@players[@turn].name) if args[:win]
    end

    private
    def prepare_initial_conditions(players)
      @players = players
      @game_finished = false
      @board = Board.new
      @turn = Kernel.rand(2)
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
      input = Input.ask_player_action(@players[@turn], @board)
      input_action(input)
    end

    def input_action(option)
      case option
      when 'help' then @display.display_gameplay_instructions
      when 'quit' then finish_game
      when 'reset' then reset
      else completed_player_move(option)
      end
    end

    def reset
      prepare_initial_conditions(@players)
    end

    def completed_player_move(input)
      @board.fill_board_space(input, @players[@turn])
      change_turn unless @game_finished
    end

    def change_turn
      @turn = (@turn + 1) % 2
    end
  end
end
