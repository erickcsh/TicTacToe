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
	
  	def get_empty_positions
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
	
  end
end
