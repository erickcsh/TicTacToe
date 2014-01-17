module TicTacToe  
  class GridPosition

    DICTIONARY_LETTER_NUMBER_TRANSFORMATION = {'A' => 0, 'B' => 1, 'C' => 2}

    attr_accessor :row, :col

    def initialize(args)
      @row = args[:row]
      @col = args[:col]
    end

    def self.from_string(string_position)
      col, row = string_position.split(',')
      row = row.to_i - 1
      col = DICTIONARY_LETTER_NUMBER_TRANSFORMATION[col]
      GridPosition.new({:row => row, :col => col})
    end

    def self.valid_position_string?(selection)
      selection.gsub(" ","").match(/^[ABC],[123]$/)
    end

  end
end
