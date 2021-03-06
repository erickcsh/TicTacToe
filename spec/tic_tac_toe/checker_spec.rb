require 'tic_tac_toe'
require 'constants'
require 'boards'

describe TicTacToe::Checker, "#update" do
  let(:player) { Boards.player_1 }
  let(:board) { Boards.no_win_nor_draw_board }
  let(:gameplay) { double(:gameplay, board: board).as_null_object }

  subject { described_class.new }

  after { subject.update( gameplay: gameplay, player: player) }

  shared_examples "finish game" do
    it "finishes the game" do 
      expect(gameplay).to receive(:finish_game) 
    end
  end

  it "sends message to gameplay with turn finished status" do
    expect(gameplay).to receive(:finished_turn_status)
  end

  context "when there is a draw board" do
    let(:board) { Boards.draw_board }
    it_behaves_like "finish game"
  end

  context "when there is a win in the first row" do
    let(:board) { Boards.first_horizontal_win_board }
    it_behaves_like "finish game"
  end

  context "when there is a win in the second row" do
    let(:board) { Boards.second_horizontal_win_board }
    it_behaves_like "finish game"
  end

  context "when there is a win in the third row" do
    let(:board) { Boards.third_horizontal_win_board }
    it_behaves_like "finish game"
  end

  context "when there is a win in the first col" do
    let(:board) { Boards.first_vertical_win_board }
    it_behaves_like "finish game"
  end

  context "when there is a win in the second col" do
    let(:board) { Boards.second_vertical_win_board }
    it_behaves_like "finish game"
  end

  context "when there is a win in the third col" do
    let(:board) { Boards.third_vertical_win_board }
    it_behaves_like "finish game"
  end

  context "when there is a win in the up diagonal" do
    let(:board) { Boards.up_diagonal_win_board }
    it_behaves_like "finish game"
  end

  context "when there is a win in the down diagonal" do
    let(:board) { Boards.down_diagonal_win_board }
    it_behaves_like "finish game"
  end

  context "when there is no win nor draw" do
    let(:board) { Boards.no_win_nor_draw_board }
    it "does not finish game" do
      expect(gameplay).not_to receive(:finish_game)
    end
  end
end
