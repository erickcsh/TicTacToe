module TicTacToe
  class Board

    attr_reader :board

    def initialize
      @board = empty_board
      super()
    end

    def fill_board_space(position, player)
      cell = cell_from_position(position)
      cell.owner = player
    end

    def position_empty?(position)
      cell = cell_from_position(position)
      cell.empty?
    end

    def get_empty_positions
      @board.each.reduce([]) { |positions, row| positions + row.select(&:empty?) }
    end

    def self.valid_position_string?(selection)
      selection.downcase.gsub(" ","").match(/^[abc],[123]$/)
    end

    private
    def cell_from_position(position)
      @board.flatten.find { |cell| cell.position == position.downcase }
    end

    def empty_board
      [1,2,3].each.reduce([]) do |board, number| 
        board << ['a','b','c'].each.reduce([]) do |row, letter|
          row << Cell.new("#{letter},#{number}")
        end
      end
    end
  end
end
