require 'tic_tac_toe'
require 'constants'
require 'boards'

describe TicTacToe::Checker, "#update" do
  let(:player) { Boards.player_1 }
  let(:gameplay) { double(:gameplay).as_null_object }

  subject { described_class.new(gameplay) }

  after { subject.update( board: board, player: player) }

  shared_examples "finish game" do
    it { expect(gameplay).to receive(:finish_game) }
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

describe TicTacToe::Checker, "#result_message" do

  let(:display) { double(:display).as_null_object }
  let(:player) { Boards.player_1 }
  let(:gameplay) { double(:gameplay).as_null_object }

  subject { described_class.new(gameplay) }

  before { allow(TicTacToe::Display).to receive(:new) { display } }

  after do
    subject.update( board: board, player: player)
    subject.result_message(player)
  end

  shared_examples "message display" do |method|
    it "displays correct message" do
      expect(display).to receive(method).with(arg)
    end
  end

  context "when there is a win" do
    let(:board)  { Boards.first_vertical_win_board }
    let(:arg) { player.name }
    it_behaves_like "message display", :display_msg_win
  end

  context "when there is a draw" do
    let(:board) { Boards.draw_board }
    let(:arg) { no_args }
    it_behaves_like "message display", :display_msg_draw
  end

  context "when there is no win nor draw" do
    let(:board) { Boards.no_win_nor_draw_board }

    it "does not display draw" do
      expect(display).not_to receive(:display_msg_draw)
    end

    it "does not display win message" do
      expect(display).not_to receive(:display_msg_win).with(player.name)
    end
  end
end
