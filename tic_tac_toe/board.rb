module TicTacToe
  class Board
		
  	DICTIONARY_INDEX_LETTER = {0 => 'A', 1 => 'B', 2 => 'C'}
  	EMPTY = 0
	
  	def initialize
  		create_board
  	end
	
  	def create_board
  		@board = [[EMPTY,EMPTY,EMPTY],[EMPTY,EMPTY,EMPTY],[EMPTY,EMPTY,EMPTY]]
  	end
	
	  def rows
	    @board 
	  end
		
  	def fill_board_space(position, player_number)
  		position = GridPosition.new(position)
  		@board[position.row][position.col] = player_number
  	end
	
  	def is_position_empty?(position)
  		position = GridPosition.new(position)
  		@board[position.row][position.col] == EMPTY
  	end
	
  	def get_empty_postions
  		@board.each_with_index.reduce([]) { |positions, row_with_index| positions << get_col_empty_positions(row_with_index.first, row_with_index.last) }.flatten!
  	end
	
  	def get_col_empty_positions(row, index)
  		letter = index_to_letter(index)
  		row.each_with_index.reduce([]) do |positions, element_with_index|  
  			letter = index_to_letter(element_with_index.last)
  			element_with_index.first == EMPTY ?  positions << "#{letter},#{index + 1}" : positions
  		end
  	end
	
	
  	def index_to_letter(index)
  		DICTIONARY_INDEX_LETTER[index]
  	end
	
  	def draw?
  		draw = true
  		@board.each {|row| row.each { |element| draw = false if element == EMPTY}}
  		draw
  	end
	
  	def win? (player_number)
  		vertical_win?(player_number) || horizontal_win?(player_number) || diagonal_win?(player_number)
  	end
	
  	def vertical_win?(player_number)
  		win = false
  		3.times { |count| win = true if win_vertical_line?(player_number, count) }
  		win
  	end
	
  	def win_vertical_line?(player_number, col)
  		@board[0][col] == player_number && 
  		@board[1][col] == player_number &&
  		@board[2][col] == player_number
  	end
	
  	def horizontal_win?(player_number)
  		win = false
  		3.times { |count| win = true if win_horizontal_line?(player_number,count)}
  		win
  	end
	
  	def win_horizontal_line?(player_number, row)
  		@board[row][0] == player_number &&
  		@board[row][1] == player_number &&
  		@board[row][2] == player_number
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
