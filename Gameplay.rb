class Gameplay
  
  def initialize(players)
    prepare_initial_conditions
  end

  def prepare_initial_conditions
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
  end

  def game_finished?
    @game_finished
  end

  def player_turn
    display_turn_status
    input = get_player_valid_input
    check_input(input)
  end

  def get_player_valid_input
    'quit'
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
    @game_finished = true
    @quit = true
  end

  def reset
    prepare_initial_conditions
  end

  def completed_player_move(input)
    @board.fill_board_space(GridPosition.new(input),@players[@turn].symbol)
    check_for_ending_move
    change_turn
  end

  def check_for_ending_move
    system "clear"
    @board.display
    draw if @board.draw?
    win if @board.win?(@player[@turn].symbol)
  end

  def draw
    puts "Game drawn"
    @game_finished = true
  end

  def win
    puts "#{@players[@turn].name} won"
    @game_finished = true
  end

  def change_turn
    @turn = (@turn + 1) % 2
  end

  def display_turn_status
    system "clear"
    @board.display
    puts "\n\n #{@players[@turn].name} turn"
  end
end
