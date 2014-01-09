module TicTacToe
  class Checker
    
    def initialize
      @win = false
      @draw = false
    end
    
    def draw?
  		draw = true
  		@board.each {|row| row.each { |element| draw = false if element == Board::EMPTY}}
  		draw
  	end
	
  	def win? (player_number)
  		vertical_win?(player_number) || horizontal_win?(player_number) || diagonal_win?(player_number)
  	end

    def ending_move?(player)
    	return win(player.name) if @win
      @draw ? draw : false
    end

    def update(board, player)
      @board = board.rows
      (@win = win(player.name)) if win?(player.symbol)
  		(@draw = draw) if draw?
    end

    private
  	def draw
  		Display.display_msg_draw
      true
  	end

  	def win(player_name)
  		Display.display_msg_win(player_name)
  		true
  	end

    def vertical_win?(player_number)
  		win = false
  		3.times { |count| win = true if win_vertical_line?(player_number, count) }
  		win
  	end
	
  	def win_vertical_line?(player_number, col)
  	  rows = [0, 1, 2]
  	  rows.all? do |row_index|
  	    @board[row_index][col] == player_number
	    end
  	end
	
  	def horizontal_win?(player_number)
  		win = false
  		3.times { |count| win = true if win_horizontal_line?(player_number,count)}
  		win
  	end
	
  	def win_horizontal_line?(player_number, row)
  	  cols = [0, 1, 2]
  	  cols.all? do |col_index|
  	    @board[row][col_index] == player_number
	    end
  	end
	
  	def diagonal_win?(player_number)
  		left_to_right_diagonal_win?(player_number) || right_to_left_diagonal_win?(player_number)
  	end
	
  	def left_to_right_diagonal_win?(player_number)
  		@board[0][0] == player_number &&
  		@board[1][1] == player_number &&
  		@board[2][2] == player_number
  	end
	
  	def right_to_left_diagonal_win?(player_number)
  		@board[0][2] == player_number &&
  		@board[1][1] == player_number &&
  		@board[2][0] == player_number
  	end
  	
  end
end
