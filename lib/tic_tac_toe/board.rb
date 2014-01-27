require 'observer'

module TicTacToe
  class Board
    include Observable

    attr_reader :board

    def initialize
      @board = empty_board
      super()
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
      @board.each.reduce([]) { |positions, row| positions + row.select(&:empty?) }
    end

    private
    def empty_board
      [1,2,3].each.reduce([]) do |board, number| 
        board << ['A','B','C'].each.reduce([]) do |row, letter|
          row << Cell.new("#{letter},#{number}")
        end
      end
    end
  end
end
