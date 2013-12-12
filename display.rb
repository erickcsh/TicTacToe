module TicTacToe
  class TicTacToe::Display
	
  	def print_board(board)
  	  clear_console
  		puts "\t   A     B     C"
  		board.rows.each_with_index { |row, index| print_row(row, index) }
  	end
	
  	def print_row(row, index)
  		puts "\t#{index + 1}  #{row[0]}  |  " +
  		"#{row[1]}  |  #{row[2]}"
  		puts "\t -----------------" unless index == 2
  	end
	
  	def clear_console
  	  system "clear"
  	end

  end
end