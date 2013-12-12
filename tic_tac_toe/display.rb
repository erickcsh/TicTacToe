module TicTacToe
  class Display
    
    DICTIONARY_NUMBER_SYMBOL = {Board::EMPTY => " ", 1 => "X", 2 => "O"}
	
  	def print_board(board)
  	  clear_console
  		puts "\t   A     B     C"
  		board.rows.each_with_index { |row, index| print_row(row, index) }
  	end
	
  	def print_row(row, row_index)
  	  print "\t#{row_index + 1}"
  	  row.each_with_index do |position, index| 
  	    print "  #{number_to_symbol(position)}  " 
  	    separator = (index == row.size - 1)  ? "\n" : "|"
  	    print separator      
	    end
  		puts "\t -----------------" unless row_index == 2
  	end
  	
  	def number_to_symbol(number)
  	  DICTIONARY_NUMBER_SYMBOL[number]
  	end
	
  	def clear_console
  	  system "clear"
  	end

  end
end