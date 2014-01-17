module TicTacToe
  class Cell

    EMPTY_SYMBOL = ' '

    attr_accessor :owner, :position

    def initialize(position, owner = nil)
      @position = position
      @owner = owner
    end

    def owner?(owner)
      owner == @owner
    end

    def empty?
      @owner.nil?
    end

    def content
      @owner.nil? ? EMPTY_SYMBOL : @owner.symbol
    end
  end
end
