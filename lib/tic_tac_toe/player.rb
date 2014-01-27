module TicTacToe
  class Player

    attr_accessor :name, :symbol

    def initialize(name, options = { computer: false })
      @name = name
      @is_computer = options[:computer]
    end

    def computer?
      @is_computer
    end
  end
end
