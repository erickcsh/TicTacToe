module TicTacToe  
  class Start

    ONE_PLAYER_MODE = 1
    TWO_PLAYER_MODE = 2

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

    def ask_for_replay
      @display.display_msg_replay
      replay = Display.read_line
      wants_to_replay?(replay)
    end

    def wants_to_replay?(replay)
      replay.downcase.eql?('y')
    end

    def ask_for_mode
      @display.display_modes_options
      enter_mode
    end

    def enter_mode
      mode = Display.read_line
      while !valid_mode?(mode.to_i)
        @display.display_error_msg_mode
        mode = Display.read_line
      end
      assign_player_mode(mode.to_i)
    end

    def valid_mode?(mode)
      [ONE_PLAYER_MODE, TWO_PLAYER_MODE].include?(mode)
    end

    def assign_player_mode(mode)
      @players_number = mode
    end

    def enter_players_name
      @players_number.times { |count| @players[count] = Player.new(ask_for_name(count), :computer => false) }
      @players[1] = Player.new("Computer", :computer => true) if @players_number == 1
    end

    def ask_for_name(player_number)
      @display.display_msg_ask_for_player_name(player_number)
      Display.read_line
    end

    def start_game
      @display.clear_console
      Gameplay.new(@players).play
    end
  end
end

