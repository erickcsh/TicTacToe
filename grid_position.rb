module TicTacToe  
  class GridPosition

    DICTIONARY_LETTER_NUMBER_TRANSFORMATION = {'A' => 0, 'B' => 1, 'C' => 2}

    attr_accessor :row, :col

    def initialize(row, col)
      @row = row
      @col = col
    end

    def initialize(string_position)
      get_position_from_string(string_position)
    end

    def get_position_from_string(string_position)
      col, row = string_position.split(',')
      @row = row.to_i - 1
      @col = DICTIONARY_LETTER_NUMBER_TRANSFORMATION[col]
    end

    def self.is_valid_position_string(selection)
      !selection.gsub(" ","").match(/^[ABC],[123]$/).nil?
    end

  end
end