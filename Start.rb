class Start

  def initialize
    @players_number = 1
  end

  def start
    #player = Player.new("a",false)
    Instructions.display_beginning_instructions
    ask_for_mode
  end

  def ask_for_mode
    puts "Select a mode:
           1) 1 player
           2) 2 players"
   mode = STDIN.gets.chomp
   check_mode(mode)
  end

  def check_mode(mode)
    @players_number = mode
  end
end

