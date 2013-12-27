module TicTacToe
  module Observer
    def initialize
      @observers = []
    end
    
    def add_observer(observer)
      @observers << observer
    end

    def delete_observer(observer)
      @observers.delete(observer)
    end

    def notify_observers(player)
      @observers.each { |observer| observer.update(self, player) }
    end
  end
end
