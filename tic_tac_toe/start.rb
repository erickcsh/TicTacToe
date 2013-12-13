module TicTacToe  
  class Start

    def initialize
      @players_number = 1
      @players = []
      @display = Display.new
    end

    def start
      Instructions.display_beginning_instructions
      ask_for_mode
      enter_players_name
      play_until_no_more_replay
    end

    private
    def play_until_no_more_replay
      replay = true
      while replay
        start_game
        replay = ask_for_replay
      end
    end

    private
    def ask_for_replay
      @display.display_msg_replay
      replay = STDIN.gets.chomp
      wants_to_replay?(replay)
    end

    private
    def wants_to_replay?(replay)
      replay.downcase.eql?('y')
    end

    private
    def ask_for_mode
      @display.display_modes_options
      enter_mode
    end

    private
    def enter_mode
      mode = STDIN.gets.chomp
      while !mode_is_valid? (mode.to_i)
        @display.display_error_msg_mode
        mode = STDIN.gets.chomp
      end
      assign_player_mode(mode.to_i)
    end

    private
    def mode_is_valid?(mode)
      mode == 1 || mode == 2
    end

    private
    def assign_player_mode(mode)
      @players_number = mode
    end

	private
    def enter_players_name
      @players_number.times { |count| @players[count] = Player.new(ask_for_name(count), false) }
      @players[1] = Player.new("Computer", true) if @players_number == 1
    end

    private
    def ask_for_name(player_number)
      @display.display_msg_ask_for_player_name(player_number)
      STDIN.gets.chomp
    end

    private
    def start_game
      @display.clear_console
      Gameplay.new(@players).play
    end
  end
end

