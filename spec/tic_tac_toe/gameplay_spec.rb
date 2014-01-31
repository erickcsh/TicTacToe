require 'tic_tac_toe'
require 'constants'
require 'boards'

describe TicTacToe::Gameplay, "#play" do
  let(:display) { double(:display).as_null_object }
  let(:console) { TicTacToe::Console.instance }
  let(:checker) { double(:checker).as_null_object }
  let(:input) { double(:input).as_null_object }
  let(:board) { double(:board).as_null_object }
  let(:player_1) { double(:player_1).as_null_object }
  let(:player_2) { double(:player_2).as_null_object}
  let(:computer) { double(:computer).as_null_object }
  let(:players) { [PLAYER_1, PLAYER_2] }

  subject { described_class.new(checker, console, players) }

  before do
    allow(TicTacToe::Board).to receive(:new) { board }
    allow(TicTacToe::Display).to receive(:instance) { display }
    allow(TicTacToe::Input).to receive(:instance) { input }
    allow(Kernel).to receive(:rand) { 0 }
    allow(input).to receive(:input_player_action) { 'quit' }
    allow(TicTacToe::Player).to receive(:new) do |name, args|
      case name
      when PLAYER_1 then player_1
      when PLAYER_2 then player_2
      when 'Computer' then computer
      end
    end
  end

  after do
    subject.play
  end

  it "displays turn status" do
    expect(display).to receive(:display_turn_status).with(board: board, player_name: player_1.name)
  end

  it "sets symbols correctly" do
    expect(player_1).to receive(:symbol=).with(PLAYER_1_SYMBOL)
    expect(player_2).to receive(:symbol=).with(PLAYER_2_SYMBOL)
  end

  context "when select two players mode" do
    it "creates two players" do
      expect(TicTacToe::Player).to receive(:new).with(PLAYER_1)
      expect(TicTacToe::Player).to receive(:new).with(PLAYER_2)
    end

    it "does not create a computer" do
      expect(TicTacToe::Player).not_to receive(:new).with('Computer', computer: true)
    end
  end

  context "creates a player and a computer" do
    let(:players) { [PLAYER_1] }

    it "creates one player" do
      expect(TicTacToe::Player).to receive(:new).with(PLAYER_1)
    end

    it "creates a computer" do
      expect(TicTacToe::Player).to receive(:new).with('Computer', computer: true)
    end
  end

  context "when action is 'quit'" do
    it "quits the game" do
      expect(display).to receive(:display_turn_status).once
    end
  end

  context "when action is 'reset'" do
    before do
      allow(input).to receive(:input_player_action).and_return('reset' , 'quit')
    end

    it "resets the game" do
      expect(TicTacToe::Board).to receive(:new).twice
    end
  end

  context "when action is 'help'" do
    before do
      allow(input).to receive(:input_player_action).and_return('help', 'quit')
      allow(display).to receive(:display_gameplay_instructions)
    end

    it "displays Instructions" do
      expect(display).to receive(:display_gameplay_instructions)
    end
  end

  context "when action is a position" do
    before do
      allow(input).to receive(:input_player_action).and_return(A_POSITION_STRING, 'quit')
    end

    it "calls changed" do
      expect(subject).to receive(:changed)
    end

    it "calls notify_observers" do
      expect(subject).to receive(:notify_observers)
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
  let(:player) { double(:player, name: PLAYER_1).as_null_object }
  let(:players) { [PLAYER_1, PLAYER_1] }
  let(:checker) { double(:checker).as_null_object }
  let(:console) { TicTacToe::Console.instance }

  subject { described_class.new(checker, console, players) }

  before do
    allow(TicTacToe::Display).to receive(:instance) { display }
    allow(TicTacToe::Player).to receive(:new) { player }
    allow(Kernel).to receive(:rand) { 0 }
  end

  it "displays the board" do
    expect(display).to receive(:display_board)
    subject.finished_turn_status
  end

  context "when there is a win" do
    it "displays win message" do
      expect(display).to receive(:display_msg_win).with(player_name: player.name)
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
  let(:players) { [PLAYER_1, PLAYER_1] }
  let(:console) { TicTacToe::Console.instance }
  let(:checker) { double(:checker).as_null_object }

  subject { described_class.new(checker, console, players) }

  it "ends game" do
    subject.finish_game
    expect(subject).not_to receive(:player_turn)
    subject.play
  end
end
