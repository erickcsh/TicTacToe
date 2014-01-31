require 'singleton'

module TicTacToe
  class Console
    include Singleton

    def clear_console
      STDOUT.puts `clear`
    end

    def respond_to?(method, include_private = false)
      super || respond_to_console?(method)
    end

    private
    def method_missing(name, *args)
      method = name.to_s
      return Display.instance.send(name, *args) if display_action?(method)
      return Input.instance.send(name, *args) if input_action?(method)
      super
    end

    def respond_to_console?(method)
      name = method.to_s
      return Display.instance.respond_to?(method) if display_action?(name)
      return Input.instance.respond_to?(method) if input_action?(name)
      false
    end

    def input_action?(name)
      name =~ /^input_/
    end

    def display_action?(name)
      name =~ /^display_/
    end
  end
end
