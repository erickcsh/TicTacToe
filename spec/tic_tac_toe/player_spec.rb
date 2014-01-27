require 'tic_tac_toe'
require 'constants'

describe TicTacToe::Player, ".initialize" do
  subject { described_class.new(A_PLAYER_NAME) }

  its(:name) { should == A_PLAYER_NAME }
end

describe TicTacToe::Player, "#computer?" do
  context "when it is a computer" do
    subject { described_class.new(A_COMPUTER_NAME, computer: true) }

    its(:computer?) { should == true }
  end

  context "when it is not a computer" do
    subject { described_class.new(A_PLAYER_NAME) }

    its(:computer?) { should == false }
  end
end
