module TicTacToe
  module Instructions

    INSTRUCTIONS_AT_BEGINNING = "\n\n\t\t Welcome to Tic Tac Toe 

  The extremely fun experience of playing such an amazing game as Tic Tac Toe. This game is really popular
  and we do not want to delay you more but here are some instructions for using this game.
  First you will be asked to select a mode here you could have:
        1 player: Play against the hardest computer you will ever play
        2 player: Play with another friend

  Then, the player/players names are asked, feel free to be honest.
  After that the game will start here you have to select a position to make your move, the format
  of this input should be A,1 as an example, with letters going from A to C and numbers from 1 to 3. Also, you
  have three another options quit, reset and help.'Quit' just quit the games, 'reset' restarts the game and
  'help' shows you another game help.

  Enjoy your game (hit enter to continue)"
    INSTRUCTIONS_AT_GAMEPLAY = "
  Select a position to make your move, the format
  of this input should be A,1 as an example, with letters going from A to C and numbers from 1 to 3. Also, you
  have three another options quit, reset and help.'Quit' just quit the games, 'reset' restarts the game and
  'help' shows you another game help.

  (hit enter to continue)"


    def self.display_beginning_instructions
      puts INSTRUCTIONS_AT_BEGINNING
      STDIN.gets
    end

    def self.display_gameplay_instructions
      puts INSTRUCTIONS_AT_GAMEPLAY
      STDIN.gets
    end
  end
end
