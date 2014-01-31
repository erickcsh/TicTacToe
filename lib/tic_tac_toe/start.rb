module TicTacToe  
  class Start

    def initialize
      @players_name_number = 1
      @players_name = []
    end

    def start
      console.display_beginning_instructions
      @players_name_number = console.input_mode
      enter_players_name
      play_until_no_more_replay
    end

    private
    def console
      Console.instance
    end

    def play_until_no_more_replay
      replay = true
      while replay
        start_game
        replay = replay? 
      end
    end

    def replay?
      console.input_replay.eql?('y')
    end

    def enter_players_name
      @players_name_number.times { |count| @players_name[count] = console.input_name(player_number: count) }
    end

    def start_game
      console.clear_console
      Gameplay.new(Checker.new, console, @players_name).play
    end
  end
end

