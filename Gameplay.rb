class Gameplay
  
  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
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
      
    end
    check_for_finish_flags
  end

  def check_for_finish_flags
    true
  end

  def game_finished?
    @game_finished
  end
end
