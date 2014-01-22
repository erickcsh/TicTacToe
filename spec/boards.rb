require 'tic_tac_toe'
require 'constants'

module Boards

  def Boards.draw_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, PLAYER_1_DRAW_POSITIONS, player_1)
    Boards.fill_positions(board, PLAYER_2_DRAW_POSITIONS, player_2)
    board
  end

  def Boards.first_vertical_win_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, FIRST_COL_WIN_POSITIONS, player_1)
    board
  end

  def Boards.second_vertical_win_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, SECOND_COL_WIN_POSITIONS, player_1)
    board
  end

  def Boards.third_vertical_win_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, THIRD_COL_WIN_POSITIONS, player_1)
    board
  end

  def Boards.first_horizontal_win_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, FIRST_ROW_WIN_POSITIONS, player_1)
    board
  end

  def Boards.second_horizontal_win_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, SECOND_ROW_WIN_POSITIONS, player_1)
    board
  end

  def Boards.third_horizontal_win_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, THIRD_ROW_WIN_POSITIONS, player_1)
    board
  end

  def Boards.up_diagonal_win_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, DIAGONAL_UP_WIN_POSITIONS, player_1)
    board
  end

  def Boards.down_diagonal_win_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, DIAGONAL_DOWN_WIN_POSITIONS, player_1)
    board
  end

  def Boards.no_win_nor_draw_board
    board = TicTacToe::Board.new
    Boards.fill_positions(board, SOME_POSITIONS, player_1)
    board
  end

  def Boards.player_1
    @@player_1 ||= Boards.player(PLAYER_1, PLAYER_1_SYMBOL)
  end

  def Boards.player_2
    @@player_2 ||= Boards.player(PLAYER_2, PLAYER_2_SYMBOL)
  end

  def Boards.fill_positions(board, positions, player)
    positions.each { |position| board.fill_board_space(position, player) }
  end

  def Boards.player(name, symbol)
    player = TicTacToe::Player.new(name)
    player.symbol = symbol
    player
  end
end
