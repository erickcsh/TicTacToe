class Gameplay
  
  def initialize(players)
    @board = Board.new
    @players = players
    @turn = rand(1)
    @game_finished = false
    @reset = false
    @quit = false
    set_players_symbols
  end

  def set_players_symbols
    @players[@turn].symbol = 1
    @players[(@turn + 1) % 2] = 2
  end

  def play
    while !game_finished? do
      player_turn
    end
    check_for_finish_flags
  end

  def check_for_finish_flags
    true
  end

  def game_finished?
    @game_finished
  end

  def player_turn
    display_turn_status

  end

  def display_turn_status
    system "clear"
    @board.display
    puts "\n\n #{@players[@turn].name} turn"
  end
end
