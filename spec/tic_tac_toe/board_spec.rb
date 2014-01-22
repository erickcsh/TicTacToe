require 'tic_tac_toe'
require 'constants'

def same_positions?(cells, positions)
    cells.each_with_index.all? { |cell, index| cell.position == positions[index] }
end

describe TicTacToe::Board, "#rows" do
  let(:cells) { described_class.new.rows.flatten! }

  it "contains the correct cells" do
    expect(same_positions?(cells, ALL_POSITIONS)).to be_true
  end
end

describe TicTacToe::Board, "#fill_board_space" do
  let(:position) { double(:position, { row: 1, col: 1 }) }
  subject { described_class.new }
  before do
    allow(TicTacToe::GridPosition).to receive(:from_string).and_return(position)
  end
  
  it "assigns space to a player" do
    subject.fill_board_space(A_POSITION, A_PLAYER)
    player = subject.rows[position.row][position.col].owner
    expect(player).to eq A_PLAYER
  end

  it "calls changed" do
    expect(subject).to receive(:changed)
    subject.fill_board_space(A_POSITION, A_PLAYER)
  end

  it "calls notify_observers" do
    expect(subject).to receive(:notify_observers)
    subject.fill_board_space(A_POSITION, A_PLAYER)
  end
end

describe TicTacToe::Board, "#position_empty?" do
  let(:position) { double(:position, { row: 1, col: 1 }) }
  subject { described_class.new }
  before do
    allow(TicTacToe::GridPosition).to receive(:from_string).and_return(position)
  end
  
  context "when it is empty" do
    it { expect(subject.position_empty?(A_POSITION)).to be_true }
  end

  context "when it is filled" do
    before { subject.fill_board_space(A_POSITION, A_PLAYER) }
    it { expect(subject.position_empty?(A_POSITION)).to be_false }
  end
end

describe TicTacToe::Board, "#get_empty_positions" do
  def fill_positions(board, positions, player)
    positions.each { |position| board.fill_board_space(position, player) }
  end
  subject { described_class.new }

  context "when board is totally empty" do
    it "returns all positions" do
      cells = subject.get_empty_positions
      expect(same_positions?(cells, ALL_POSITIONS)).to be_true
    end
  end

  context "when some positions are filled" do
    before { fill_positions(subject, SOME_POSITIONS, A_PLAYER) }

    it "returns all, except filled positions" do
      cells = subject.get_empty_positions
      expect(same_positions?(cells, ALL_EXCEPT_SOME_POSITIONS)).to be_true
    end
  end

  context "when board is totally filled" do
    before { fill_positions(subject, ALL_POSITIONS, A_PLAYER) }

    it { expect(subject.get_empty_positions).to be_empty }
  end
end
