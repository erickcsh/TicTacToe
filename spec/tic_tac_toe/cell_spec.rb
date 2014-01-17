require 'tic_tac_toe/cell'
require 'constants'


describe TicTacToe::Cell, ".initialize" do
  subject { described_class.new(A_POSITION, AN_OWNER) }

  its(:position) { should == A_POSITION }
  its(:owner) { should == AN_OWNER }
end

describe TicTacToe::Cell, "#owner?" do
  let(:cell) { described_class.new(A_POSITION, AN_OWNER) }

  context "when is owner" do
    subject { cell.owner?(AN_OWNER) }
    it { should be_true }
  end

  context "when is not owner" do
    subject { cell.owner?(NOT_AN_OWNER) }
    it { should be_false }
  end
end

describe TicTacToe::Cell, "#empty?" do
  context "when cell doesn't have owner" do
    subject { described_class.new(A_POSITION) }
    it { should be_empty }
  end

  context "when cell has owner" do 
    subject { described_class.new(A_POSITION, AN_OWNER) }
    it { should_not be_empty }
  end
end

describe TicTacToe::Cell, "#content" do
  context "when cell doesn't have owner" do
    subject { described_class.new(A_POSITION).content }
    it { should == EMPTY_SYMBOL }
  end

  context "when cell has owner" do
    let(:owner) { double(:owner, symbol: A_SYMBOL) }
    subject { described_class.new(A_POSITION, owner).content }
    it { should == A_SYMBOL }
  end
end
