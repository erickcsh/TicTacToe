module TicTacToe
  class Checker

    attr_reader :win, :draw

    def initialize(gameplay)
      @win = false
      @draw = false
      @gameplay = gameplay
    end

    def update(args)
      @board = args[:board].board
      @win = win?(args[:player])
  		@draw = draw? unless @win
      @gameplay.finish_game if (@win || @draw)
    end

    private
    def draw?
  		@board.all? {|row| row.all? { |element| !element.empty? }}
    end
	
  	def win? (player)
  		vertical_win?(player) || horizontal_win?(player) || diagonal_win?(player)
  	end

    def vertical_win?(player)
  		3.times.any? { |count| win_vertical_line?(player, count) }
    end
	
  	def win_vertical_line?(player, col)
  	  rows = [0, 1, 2]
  	  rows.all? do |row_index|
  	    @board[row_index][col].owner?(player)
	    end
  	end
	
  	def horizontal_win?(player)
  		3.times.any? { |count| win_horizontal_line?(player,count)}
  	end
	
  	def win_horizontal_line?(player, row)
  	  cols = [0, 1, 2]
  	  cols.all? do |col_index|
  	    @board[row][col_index].owner?(player)
	    end
  	end
	
  	def diagonal_win?(player)
  		left_to_right_diagonal_win?(player) || right_to_left_diagonal_win?(player)
  	end
	
  	def left_to_right_diagonal_win?(player)
  		@board[0][0].owner?(player) &&
  		@board[1][1].owner?(player) &&
  		@board[2][2].owner?(player)
  	end
	
  	def right_to_left_diagonal_win?(player)
  		@board[0][2].owner?(player) &&
  		@board[1][1].owner?(player) &&
  		@board[2][0].owner?(player)
  	end

  end
end
