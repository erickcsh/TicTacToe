require 'yaml'

module TicTacToe
  class Display

    MESSAGES_FILE = 'res/messages.yaml'

    def print_board(board)
      clear_console
      puts "\t   A     B     C"
      board.rows.each_with_index { |row, index| print_row(row, index) }
    end

    def clear_console
      system "clear"
    end

    def display(msg_name, *args)
      puts YAML.load_file(MESSAGES_FILE)[msg_name]
    end

    def display_turn_status(board, player_name)
      print_board(board)
      puts "\n\n #{player_name} turn"
    end

    def display_msg_ask_for_player_name(player_number)
      puts "Enter player #{player_number + 1} name"
    end

    def display_msg_win(player_name)
      puts "#{player_name} won"
    end

    def display_msg_computer_thinking
      print "Thinking."
      2.times do
        sleep(1)
        print "."
      end
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

    def method_missing(name, *args)
      name = name.to_s
      super unless name =~ /^display_/
      name.gsub!(/^display_/,'')
      display(name, *args)
    end


  end
end
