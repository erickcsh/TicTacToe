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
    input = get_player_valid_input
    check_input(input)
  end

  def check_input(input)
    is_quit_reset_option?(input) ? quit_reset_option_action(input) : completed_player_move(input)
  end

  def is_quit_reset_option?(option)
    option = option.downcase
    option.eql?("quit") || option.eql?("reset")
  end

  def quit_reset_option_action(option)
    option = option.downcase
    option.eql?("quit") ? quit : reset
  end

  def quit

  end

  def reset
    
  end

  def completed_player_move

  end

  def display_turn_status
    system "clear"
    @board.display
    puts "\n\n #{@players[@turn].name} turn"
  end
end
