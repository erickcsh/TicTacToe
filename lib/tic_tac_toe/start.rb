module TicTacToe  
  class Start

    def initialize
      @players_number = 1
      @players = []
    end

    def start
      Display.instance.display_beginning_instructions
      @players_number = Input.instance.ask_mode
      enter_players_name
      play_until_no_more_replay
    end

    private
    def play_until_no_more_replay
      replay = true
      while replay
        start_game
        replay = replay? 
      end
    end

    def replay?
      Input.instance.ask_replay.eql?('y')
    end

    def enter_players_name
      @players_number.times { |count| @players[count] = Player.new(Input.instance.ask_name(count)) }
      @players[1] = Player.new("Computer", computer: true) if @players_number == 1
    end

    def start_game
      Display.instance.clear_console
      Gameplay.new(@players).play
    end
  end
end

