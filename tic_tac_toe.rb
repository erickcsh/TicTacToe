module TicTacToe
end

require_relative 'tic_tac_toe/board'
require_relative 'tic_tac_toe/display'
require_relative 'tic_tac_toe/start'
require_relative 'tic_tac_toe/checker'
require_relative 'tic_tac_toe/gameplay'
require_relative 'tic_tac_toe/grid_position'
require_relative 'tic_tac_toe/instructions'
require_relative 'tic_tac_toe/player'

TicTacToe::Start.new.start
