module TicTacToe  
  class Start

    def initialize
      @players_number = 1
      @players = []
    end

    def start
      console.display_beginning_instructions
      @players_number = console.input_mode
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
      @players_number.times { |count| @players[count] = console.input_name(player_number: count) }
    end

    def start_game
      console.clear_console
      Gameplay.new(Checker.new, console, @players).play
    end
  end
end

