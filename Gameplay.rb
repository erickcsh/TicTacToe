class Gameplay
  
  def initialize(players)
    prepare_initial_conditions(players)
  end

  def prepare_initial_conditions(players)
    @board = Board.new
    @players = players
    @turn = rand(2)
    @game_finished = false
    @reset = false
    @quit = false
    set_players_symbols
  end

  def set_players_symbols
    @players[@turn].symbol = 1
    @players[(@turn + 1) % 2].symbol = 2
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
    begin
      input = @players[@turn].select_position(@board.get_empty_postions)
    end while !is_valid_input?(input)
    input
  end

  def is_valid_input?(input)
    return true if is_quit_reset_option?(input)
    if(GridPosition.is_valid_position_string(input))
       is_empty_position?(input)
    else
      puts "Not a valid selection, select another one"
      false
    end
  end

  def is_empty_position?(input)
    if(@board.is_position_empty?(input))
      true
    else
      puts "Not an empty position select another one"
      false
    end
  end

  def check_input(input)
    is_quit_reset_option?(input) ? quit_reset_option_action(input) : completed_player_move(input)
  end

  def is_quit_reset_option?(option)
    option = option.downcase
    option.eql?("help") || option.eql?("quit") || option.eql?("reset")
  end

  def quit_reset_option_action(option)
    option = option.downcase
    if(option.eql?("help"))
      Instructions.display_gameplay_instructions
    else
      option.eql?("quit") ? quit : reset
    end
  end

  def quit
    @game_finished = true
    @quit = true
  end

  def reset
    prepare_initial_conditions(@players)
  end

  def completed_player_move(input)
    @board.fill_board_space(input,@players[@turn].symbol)
    check_for_ending_move
    change_turn
  end

  def check_for_ending_move
    system "clear"
    @board.print_board
    return win if @board.win?(@players[@turn].symbol)
    draw if @board.draw?
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
    @board.print_board
    puts "\n\n #{@players[@turn].name} turn"
  end
end
