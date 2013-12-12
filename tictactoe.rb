module TicTacToe
end

require_relative 'board'
require_relative 'display'
require_relative 'start'
require_relative 'gameplay'
require_relative 'grid_position'
require_relative 'instructions'
require_relative 'player'

TicTacToe::Start.new.start
