module TicTacToe  
  class GridPosition

    DICTIONARY_LETTER_NUMBER_TRANSFORMATION = {'a' => 0, 'b' => 1, 'c' => 2}

    attr_accessor :row, :col

    def initialize(args)
      @row = args[:row]
      @col = args[:col]
    end

    def self.from_string(string_position)
      col, row = string_position.downcase.split(',')
      row = row.to_i - 1
      col = DICTIONARY_LETTER_NUMBER_TRANSFORMATION[col]
      GridPosition.new({:row => row, :col => col})
    end

    def self.valid_position_string?(selection)
      selection.downcase.gsub(" ","").match(/^[abc],[123]$/)
    end

  end
end
