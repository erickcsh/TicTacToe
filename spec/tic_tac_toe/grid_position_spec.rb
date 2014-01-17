require 'tic_tac_toe/grid_position'
require 'constants'

describe TicTacToe::GridPosition, ".initialize" do
  subject { described_class.new(row: A_ROW_NUMBER, col: A_COL_NUMBER) }

  its(:row) { should == A_ROW_NUMBER }
  its(:col) { should == A_COL_NUMBER }
end

describe TicTacToe::GridPosition, ".from_string" do
  subject { described_class.from_string(A_POSITION_STRING) }

  its(:row) { should == POSITION_STRING_ROW }
  its(:col) { should == POSITION_STRING_COL }
end

describe TicTacToe::GridPosition, ".valid_position_string?" do
  context "when the string is a valid position" do
    subject { described_class.valid_position_string?(A_POSITION_STRING) }
    it { should be_true }
  end

  context "when the string is not a valid position" do
    subject { described_class.valid_position_string?(NOT_A_POSITION_STRING) }
    it { should be_false }
  end
end
