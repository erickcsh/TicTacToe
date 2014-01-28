require 'tic_tac_toe'
require 'constants'
require 'boards'

describe TicTacToe::Gameplay, "#play" do
  let(:display) { double(:display).as_null_object }
  let(:checker) { double(:checker).as_null_object }
  let(:board) { double(:board).as_null_object }
  let(:player_1) { Boards.player_1 }
  let(:player_2) { Boards.player_2 }
  let(:players) { [player_1, player_2] }

  subject { described_class.new(players) }

  before do
    allow(TicTacToe::Board).to receive(:new) { board }
    allow(TicTacToe::Display).to receive(:new) { display }
    allow(TicTacToe::Checker).to receive(:new) { checker }
    allow(Kernel).to receive(:rand) { 0 }
    allow(TicTacToe::Input).to receive(:ask_player_action) { 'quit' }
  end

  after do
    subject.play
  end

  it "displays turn status" do
    expect(display).to receive(:display_turn_status).with(board, player_1.name)
  end

  it "sets symbols correctly" do
    expect(player_1.symbol).to eq(PLAYER_1_SYMBOL)
    expect(player_2.symbol).to eq(PLAYER_2_SYMBOL)
  end

  context "when action is 'quit'" do
    it "quits the game" do
      expect(display).to receive(:display_turn_status).once
    end
  end

  context "when action is 'reset'" do
    before do
      allow(TicTacToe::Input).to receive(:ask_player_action).and_return('reset' , 'quit')
    end

    it "resets the game" do
      expect(board).to receive(:add_observer).with(checker).twice
    end
  end

  context "when action is 'help'" do
    before do
      allow(TicTacToe::Input).to receive(:ask_player_action).and_return('help', 'quit')
      allow(display).to receive(:display_gameplay_instructions)
    end

    it "displays Instructions" do
      expect(display).to receive(:display_gameplay_instructions)
    end
  end

  context "when action is a position" do
    before do
      allow(TicTacToe::Input).to receive(:ask_player_action).and_return(A_POSITION_STRING, 'quit')
    end

    it "fills the space in the board" do
      expect(board).to receive(:fill_board_space).with(A_POSITION_STRING, player_1)
    end

    context "when it is an ending move" do
      before do
        allow(board).to receive(:fill_board_space) { subject.finish_game }
      end

      it "does not change turn" do
        expect(subject).not_to receive(:change_turn)
      end
    end

    context "when it is not an ending move" do
      it "changes turn" do
        expect(subject).to receive(:change_turn).once.and_call_original
      end
    end
  end

end

describe TicTacToe::Gameplay, "#finished_turn_status" do
  let(:display) { double(:display).as_null_object }
  let(:player) { double(:player, name: A_PLAYER_NAME).as_null_object }
  let(:players) { [player, player] }
  subject { described_class.new(players) }

  before do
    allow(TicTacToe::Display).to receive(:new) { display }
    allow(Kernel).to receive(:rand) { 0 }
  end

  it "displays the board" do
    expect(display).to receive(:print_board)
    subject.finished_turn_status
  end

  context "when there is a win" do
    it "displays win message" do
      expect(display).to receive(:display_msg_win).with(player.name)
      subject.finished_turn_status( win: true )
    end
  end

  context "when there is a draw" do
    it "displays draw message" do
      expect(display).to receive(:display_msg_draw)
      subject.finished_turn_status( draw: true )
    end
  end

  context "when there is no draw nor win" do
    it "should not display any message" do
      expect(display).not_to receive(:display_msg_win)
      expect(display).not_to receive(:display_msg_draw)
      subject.finished_turn_status
    end
  end
end

describe TicTacToe::Gameplay, "#finish_game" do
  let(:player) { double(:player).as_null_object }
  let(:players) { [player, player] }
  subject { described_class.new(players) }

  it "ends game" do
    subject.finish_game
    expect(subject).not_to receive(:player_turn)
    subject.play
  end
end
