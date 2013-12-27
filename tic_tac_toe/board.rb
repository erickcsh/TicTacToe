module TicTacToe
  class Board
    include TicTacToe::Observer
  
		
  	DICTIONARY_INDEX_LETTER = {0 => 'A', 1 => 'B', 2 => 'C'}
  	EMPTY = 0
	
  	def initialize
  		create_board
      super()
  	end
	
    def rows
        @board 
    end
    def cols
      
        @board.each_with_index.map do |row, row_index|
        @board.map { |row| row[row_index] }
      end
    end
		
  	def fill_board_space(position, player)
  		position = GridPosition.new(position)
  		@board[position.row][position.col] = player.symbol
      notify_observers(player)
  	end
	
  	def is_position_empty?(position)
  		position = GridPosition.new(position)
  		@board[position.row][position.col] == EMPTY
  	end
	
  	def get_empty_positions
  		@board.each_with_index.reduce([]) { |positions, row_with_index| positions << get_col_empty_positions(row_with_index.first, row_with_index.last) }.flatten!
  	end
	
    private
  	def create_board
  		@board = [[EMPTY,EMPTY,EMPTY],[EMPTY,EMPTY,EMPTY],[EMPTY,EMPTY,EMPTY]]
  	end
	
    private
  	def get_col_empty_positions(row, index)
  		letter = index_to_letter(index)
  		row.each_with_index.reduce([]) do |positions, element_with_index|  
  			letter = index_to_letter(element_with_index.last)
  			element_with_index.first == EMPTY ?  positions << "#{letter},#{index + 1}" : positions
  		end
  	end
	
    private
  	def index_to_letter(index)
  		DICTIONARY_INDEX_LETTER[index]
  	end
  end
end
