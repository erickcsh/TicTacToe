class Player

  attr_accessor :name, :symbol

  def initialize(name, isComputer)
    @name = name
    @isComputer = isComputer
  end

  def select_position(posible_positions)
    @isComputer ? select_random_position(posible_positions) : receive_player_input
  end

  def select_random_position(posible_positions)
    index = rand(posible_positions.size)
    posible_positions[index]
  end

  def receive_player_input
    puts "Select the position"
    position = STDIN.gets.chomp
  end
end
