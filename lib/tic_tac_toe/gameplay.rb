require 'observer'

module TicTacToe
  class Gameplay
    include Observable

    attr_reader :board

    def initialize(checker, ui, players)
      create_players(players)
      @ui = ui
      prepare_initial_conditions
      self.add_observer(checker)
    end

    def play
      player_turn while !@game_finished
    end

    def finish_game
      @game_finished = true
    end

    def finished_turn_status(args = { win: false, draw: false })
      @ui.display_board(board: @board)
      @ui.display_msg_draw if args[:draw]
      @ui.display_msg_win(player_name: @players[@turn].name) if args[:win]
    end

    private
    def create_players(players)
      @players = players.map { |name| Player.new(name) }
      @players << Player.new('Computer', computer: true) if @players.size == 1
    end

    def prepare_initial_conditions
      @game_finished = false
      @board = Board.new
      @turn = Kernel.rand(2)
      set_players_symbols
    end

    def set_players_symbols
      @players[@turn].symbol = "X" 
      @players[(@turn + 1) % 2].symbol = "O"
    end

    def player_turn
      @ui.display_turn_status(board: @board, player_name: @players[@turn].name)
      input = @ui.input_player_action(@players[@turn], @board)
      input_action(input)
    end

    def input_action(option)
      case option
      when 'help' then @ui.display_gameplay_instructions
      when 'quit' then finish_game
      when 'reset' then reset
      else completed_player_move(option)
      end
    end

    def reset
      prepare_initial_conditions
    end

    def completed_player_move(input)
      @board.fill_board_space(input, @players[@turn])
      changed
      notify_observers(gameplay: self, player: @players[@turn])
      change_turn unless @game_finished
    end

    def change_turn
      @turn = (@turn + 1) % 2
    end
  end
end
