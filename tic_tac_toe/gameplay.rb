module TicTacToe  
  class Gameplay

    def initialize(players)
    	prepare_initial_conditions(players)
    end
	
	def play
  	  while !game_finished? do
    		player_turn
    	end
  	end

	private
    def prepare_initial_conditions(players)
    	@board = Board.new
    	@players = players
    	@turn = rand(2)
    	@game_finished = false
    	@display = Display.new
    	@checker = Checker.new(@board.rows)
    	set_players_symbols
    end

	private
    def set_players_symbols
    	@players[@turn].symbol = 1
    	@players[(@turn + 1) % 2].symbol = 2
    end

	private
  	def game_finished?
  		@game_finished
  	end

	private
  	def player_turn
  		display_turn_status
  		input = get_player_valid_input
  		check_input(input)
  	end

	private
  	def get_player_valid_input
  		begin
  			input = @players[@turn].select_position(@board.get_empty_positions)
  		end while !is_valid_input?(input)
  		input
  	end

	private
  	def is_valid_input?(input)
  		return true if is_quit_reset_option?(input)
  		if(GridPosition.valid_position_string?(input))
  			is_empty_position?(input)
		else
  			puts "Not a valid selection, select another one"
  			false
  		end
  	end

	private
  	def is_empty_position?(input)
  		if(@board.is_position_empty?(input))
  			true
		else
  			puts "Not an empty position select another one"
  			false
  		end
  	end

	private
  	def check_input(input)
  		is_quit_reset_option?(input) ? quit_reset_option_action(input) : completed_player_move(input)
  	end

	private
  	def is_quit_reset_option?(option)
  		option = option.downcase
  		option.eql?("help") || option.eql?("quit") || option.eql?("reset")
  	end

	private
  	def quit_reset_option_action(option)
  		option = option.downcase
  		if(option.eql?("help"))
  			Instructions.display_gameplay_instructions
  			else
  			option.eql?("quit") ? quit : reset
  		end
  	end

	private
  	def quit
  		@game_finished = true  	
  	end

	private
  	def reset
  		prepare_initial_conditions(@players)
  	end

	private
  	def completed_player_move(input)
  		@board.fill_board_space(input,@players[@turn].symbol)
  		check_for_ending_move
  		change_turn
  	end

	private
  	def check_for_ending_move
  		@display.print_board(@board)
  		return win if @checker.win?(@players[@turn].symbol)
  		draw if @checker.draw?
  	end

	private
  	def draw
  		puts "Game drawn"
  		@game_finished = true
  	end

	private
  	def win
  		puts "#{@players[@turn].name} won"
  		@game_finished = true
  	end

	private
  	def change_turn
  		@turn = (@turn + 1) % 2
  	end

	private
  	def display_turn_status
  		@display.print_board(@board)
  		puts "\n\n #{@players[@turn].name} turn"
  	end
  end
end

