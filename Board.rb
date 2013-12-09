class Board

  DICTIONARY_NUMBER_SYMBOL = {0 => " ", 1 => "X", 2 => "O"}
  DICTIONARY_INDEX_LETTER = {0 => 'A', 1 => 'B', 2 => 'C'}

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

  def is_position_empty?(position)
    @board[position.row][position.col] == 0
  end

  def get_empty_postions
    @board.each_with_index.reduce([]) { |positions, row, index| positions << get_col_empty_positions(row, index) }
  end

  def get_col_empty_positions(row, index)
    letter = index_to_letter(index)
    row.each_with_index.reduce([]) { |positions, element, index_col|
                                         positions << "#{letter},#{index_col + 1}" if element == 0}
  end

  def index_to_letter(index)
    DICTIONARY_INDEX_LETTER[index]
  end

  def draw?
    draw = true
    @board.each {|row| row.each { |element| draw = false if element == 0}}
    draw
  end

  def win? (player_number)
    vertical_win?(player_number) || horizontal_win?(player_number) || diagonal_win?(player_number)
  end

  def vertical_win?(player_number)
    win = false
    3.times { |count| win = true if win_vertical_line?(player_number, count) }
    win
  end

  def win_vertical_line?(player_number, col)
    @board[0][col] == player_number && 
    @board[1][col] == player_number &&
    @board[2][col] == player_number
  end

  def horizontal_win?(player_number)
    win = false
    3.times { |count| win = true if win_horizontal_line?(player_number,count)}
    win
  end

  def win_horizontal_line?(player_number, row)
    @board[row][0] == player_number &&
    @board[row][1] == player_number &&
    @board[row][2] == player_number
  end

  def diagonal_win?(player_number)
    left_to_right_diagonal_win?(player_number) || right_to_left_diagonal_win?(player_number)
  end

  def left_to_right_diagonal_win?(player_number)
    @board[0][0] == player_number &&
    @board[1][1] == player_number &&
    @board[2][2] == player_number
  end

  def left_to_right_diagonal_win?(player_number)
    @board[0][2] == player_number &&
    @board[1][1] == player_number &&
    @board[2][0] == player_number
  end

end
