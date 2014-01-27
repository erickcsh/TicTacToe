require 'tic_tac_toe'
require 'constants'

describe TicTacToe::Start, "#start" do
  subject{ described_class.new}

  let(:gameplay) { double(:gameplay).as_null_object }
  let(:display) { double(:display).as_null_object }
  let(:player_1) { double(:player_1).as_null_object }
  let(:player_2) { double(:player_2).as_null_object }
  let(:computer) { double(:computer).as_null_object }

  before do
    allow(TicTacToe::Gameplay).to receive(:new) { gameplay }
    allow(display).to receive(:display_beginning_instructions) {}
    allow(TicTacToe::Display).to receive(:new) { display }
    allow(TicTacToe::Display).to receive(:read_line) { '1' }
    allow(TicTacToe::Player).to receive(:new) do |name, args|
      case name
      when PLAYER_1 then player_1
      when PLAYER_2 then player_2
      when 'Computer' then computer
      end
    end
  end

  after do
    subject.start
  end

  it "displays beggining instructions" do
    expect(display).to receive(:display_beginning_instructions) 
  end

  context "when game is going to start" do
    it "clears console " do
      expect(display).to receive(:clear_console)
    end

    it "starts new game" do
      expect(gameplay).to receive(:play)
    end
  end

  context "in mode selection" do

    context "when one player mode selected" do
      before { allow(TicTacToe::Display).to receive(:read_line).and_return('1', PLAYER_1, 'n') }

      it "asks once for player name" do
        expect(display).to receive(:display_msg_ask_for_player_name).once
      end

      it "starts game with a player and a computer" do
        expect(TicTacToe::Gameplay).to receive(:new).with([player_1, computer])
      end
    end

    context "when two player mode selected" do
      before { allow(TicTacToe::Display).to receive(:read_line).and_return('2', PLAYER_1, PLAYER_2, 'n') }

      it "asks twice for player name" do
        expect(display).to receive(:display_msg_ask_for_player_name).with(0)
        expect(display).to receive(:display_msg_ask_for_player_name).with(1)
      end

      it "starts game with 2 players" do
        expect(TicTacToe::Gameplay).to receive(:new).with([player_1, player_2])
      end
    end

    context "when invalid mode selected" do
      before { allow(TicTacToe::Display).to receive(:read_line).and_return('3', '1', PLAYER_1, 'n') }

      it "displays error message" do
        expect(display).to receive(:display_error_msg_mode)
      end
    end

    context "when valid mode selected" do
      before { allow(TicTacToe::Display).to receive(:read_line).and_return('1', PLAYER_1, 'n') }

      it "does not display error message" do
        expect(display).not_to receive(:display_error_msg_mode)
      end
    end
  end

  context "when game finished" do
    it "displays replay message" do
      expect(display).to receive(:display_msg_replay)
    end

    context "when wants to replay" do
      before { allow(TicTacToe::Display).to receive(:read_line).and_return('1', PLAYER_1, 'y', 'n') }

      it "plays twice" do
        expect(subject).to receive(:start_game).twice
      end
    end

    context "does not want replay" do
      before { allow(TicTacToe::Display).to receive(:read_line).and_return('1', PLAYER_1,  'n') }

      it "plays once" do
        expect(subject).to receive(:start_game).once
      end
    end
  end
end
