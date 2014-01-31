require 'yaml'
require 'singleton'

module TicTacToe
  class Display
    include Singleton

    MESSAGES_FILE = 'res/messages.yaml'

    attr_accessor :output

    def display_board(args)
      board = args[:board]
      Console.instance.clear_console
      STDOUT.puts "\t   A     B     C"
      STDOUT.puts board.board.map.with_index{ |row, index| row_message(row, index) }.join
    end

    def display(msg_name, *args)
      STDOUT.puts YAML.load_file(MESSAGES_FILE)[msg_name]
      STDIN.gets if instructions?(msg_name)
    end

    def display_turn_status(args)
      player_name = args[:player_name]
      display_board(args)
      STDOUT.puts "\n\n #{player_name} turn"
    end

    def display_msg_ask_for_player_name(args)
      player_number = args[:player_number]
      STDOUT.puts "Enter player #{player_number + 1} name"
    end

    def display_msg_win(args)
      player_name = args[:player_name]
      STDOUT.puts "#{player_name} won"
    end

    def display_msg_computer_thinking
      STDOUT.print "Thinking."
      2.times do
        Kernel.sleep(1)
        STDOUT.print "."
      end
    end

    def respond_to?(method, include_private = false)
      super || respond_to_display?(method)
    end

    private
    def instructions?(msg_name)
      msg_name.end_with?('_instructions')
    end

    def respond_to_display?(method)
      name = method.to_s
      return false unless name =~ /^display_/
      name.gsub!(/^display_/,'')
      msg_in_yml_file?(name)
    end

    def msg_in_yml_file?(msg)
      YAML.load_file(MESSAGES_FILE).has_key?(msg)
    end

    def row_message(row, row_index)
      message = "\t#{row_index + 1}"
      row.each_with_index do |cell, index| 
        message << "  #{cell.content}  " 
        separator = (index == row.size - 1)  ? "\n" : "|"
        message << separator
      end
      message << "\t -----------------\n" unless row_index == 2
      message
    end

    def method_missing(name, *args)
      name = name.to_s
      super unless name =~ /^display_/
      name.gsub!(/^display_/,'')
      display(name, *args)
    end


  end
end
