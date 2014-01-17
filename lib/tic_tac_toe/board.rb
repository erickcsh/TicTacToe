require 'observer'

module TicTacToe
  class Board
    include Observable

    def initialize
      create_board
      super()
    end

    def rows
      @board 
    end

    def fill_board_space(position, player)
      position = GridPosition.from_string(position)
      @board[position.row][position.col].owner = player
      changed
      notify_observers({:board => self, :player => player})
    end

    def position_empty?(position)
      position = GridPosition.from_string(position)
      @board[position.row][position.col].empty?
    end

    def get_empty_positions
      @board.each.reduce([]) do |positions, row|
        positions << row.select { |cell| cell.empty? }
      end.flatten!
    end

    private
    def create_board
      @board = generate_board
    end

    def generate_board
      [1,2,3].each.reduce([]) do |board, number| 
        board << ['A','B','C'].each.reduce([]) do |row, letter|
          row << Cell.new("#{letter},#{number}")
        end
      end
    end

  end
end
