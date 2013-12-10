class Start

  def initialize
    @players_number = 1
    @players = []
  end

  def start
    Instructions.display_beginning_instructions
    ask_for_mode
    enter_players_name
    start_game
  end

  def ask_for_mode
    puts "Select a mode:
           1) 1 player
           2) 2 players"
   enter_mode
  end

  def enter_mode
    mode = STDIN.gets.chomp
    while !mode_is_valid? (mode.to_i)
      puts "Enter a valid mode"
      mode = STDIN.gets.chomp
    end
    assign_player_mode(mode.to_i)
  end

  def mode_is_valid?(mode)
    mode == 1 || mode == 2
  end

  def assign_player_mode(mode)
    @players_number = mode
  end

  def enter_players_name
    @players_number.times { |count| @players[count] = Player.new(ask_for_name(count), false) }
    @players[1] = Player.new("Computer", true) if @players_number == 1
  end

  def ask_for_name(player_number)
    puts "Enter player #{player_number + 1} name"
    STDIN.gets.chomp
  end

  def start_game
    system "clear"
    Gameplay.new(@players).play
  end
end

