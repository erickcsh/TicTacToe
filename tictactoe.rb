require_relative 'Board'
require_relative 'Start'
require_relative 'Gameplay'
require_relative 'GridPosition'
require_relative 'Instructions'
require_relative 'Player'

#puts GridPosition.is_valid_position_string("D, 1")
Start.new.start
