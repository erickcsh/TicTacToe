module TicTacToe
  class Display

    def print_board(board)
      clear_console
      puts "\t   A     B     C"
      board.rows.each_with_index { |row, index| print_row(row, index) }
    end

    def clear_console
      system "clear"
    end

    def display_msg_not_valid_input
      puts "Not a valid selection, select another one"
    end

    def display_msg_not_empty_position
      puts "Not an empty position select another one"
    end

    def display_turn_status(board, player_name)
      print_board(board)
      puts "\n\n #{player_name} turn"
    end

    def display_msg_replay
      puts "Do you want to play again [Y/N]"
    end

    def display_modes_options
      puts "Select a mode:
               1) 1 player
               2) 2 players"
    end

    def display_error_msg_mode
      puts "Enter a valid mode"
    end

    def display_msg_ask_for_player_name(player_number)
      puts "Enter player #{player_number + 1} name"
    end

    def self.display_msg_win(player_name)
      puts "#{player_name} won"
    end

    def self.display_msg_draw
      puts "Game drawn"
    end

    def self.display_msg_computer_thinking
      print "Thinking."
      2.times do
        sleep(1)
        print "."
      end
    end

    def self.display_msg_select_position
      puts "Select the position"
    end

    def self.read_line
      STDIN.gets.chomp
    end

    private
    def print_row(row, row_index)
      print "\t#{row_index + 1}"
      row.each_with_index do |cell, index| 
        print "  #{cell.content}  " 
        separator = (index == row.size - 1)  ? "\n" : "|"
        print separator
      end
      puts "\t -----------------" unless row_index == 2
    end

  end
end
