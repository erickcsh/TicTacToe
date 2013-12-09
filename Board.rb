class Board

  DICTIONARY_NUMBER_SYMBOL = {0 => " ", 1 => "X", 2 => "O"}

  def initialize
    create_board
  end

  def create_board
    @board = [[0,0,0],[0,0,0],[0,0,0]]
  end

  def print_board
    puts "\t   A     B     C"
    @board.each_with_index { |row, index| print_row(row, index) }
  end

  def print_row(row, index)
    puts "\t#{index + 1}  #{transform_number_to_symbol(row[0])}  |  " +
    "#{transform_number_to_symbol(row[1])}  |  #{transform_number_to_symbol(row[0])}"
    puts "\t -----------------" unless index == 2
  end

  def transform_number_to_symbol(number)
    DICTIONARY_NUMBER_SYMBOL[number]
  end

  def fill_board_space(position, player_number)
    @board[position.row][position.col] = player_number
  end
end

Board.new.print_board
