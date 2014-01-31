require 'tic_tac_toe'
require 'constants'

def same_positions?(cells, positions)
    cells.each_with_index.all? { |cell, index| cell.position.downcase == positions[index].downcase }
end

describe TicTacToe::Board, "#board" do
  let(:cells) { described_class.new.board.flatten! }

  it "contains the correct cells" do
    expect(same_positions?(cells, ALL_POSITIONS)).to be_true
  end
end

describe TicTacToe::Board, "#fill_board_space" do
  let(:position) { double(:position, { row: 1, col: 1 }) }
  subject { described_class.new }

  it "assigns space to a player" do
    subject.fill_board_space(A_POSITION_STRING, A_PLAYER)
    player = subject.board[position.row][position.col].owner
    expect(player).to eq A_PLAYER
  end
end

describe TicTacToe::Board, "#position_empty?" do
  let(:position) { double(:position, { row: 1, col: 1 }) }
  subject { described_class.new }

  context "when it is empty" do
    it { expect(subject.position_empty?(A_POSITION_STRING)).to be_true }
  end

  context "when it is filled" do
    before { subject.fill_board_space(A_POSITION_STRING, A_PLAYER) }
    it { expect(subject.position_empty?(A_POSITION_STRING)).to be_false }
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

describe TicTacToe::Board, ".valid_position_string?" do
  context "when the string is a valid position" do
    subject { described_class.valid_position_string?(A_POSITION_STRING) }
    it { should be_true }
  end

  context "when the string is not a valid position" do
    subject { described_class.valid_position_string?(NOT_A_POSITION_STRING) }
    it { should be_false }
  end
end
