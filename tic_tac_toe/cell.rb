module TicTacToe
  class Cell

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
      @owner.nil? ? " " : @owner.symbol
    end
  end
end
