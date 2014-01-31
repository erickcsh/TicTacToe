require 'tic_tac_toe'
require 'constants'

describe TicTacToe::Start, "#start" do
  subject{ described_class.new}

  let(:gameplay) { double(:gameplay).as_null_object }
  let(:display) { double(:display).as_null_object }
  let(:input) { double(:input).as_null_object }
  let(:console) { TicTacToe::Console.instance }

  before do
    allow(TicTacToe::Gameplay).to receive(:new) { gameplay }
    allow(display).to receive(:display_beginning_instructions) {}
    allow(TicTacToe::Display).to receive(:instance) { display }
    allow(TicTacToe::Input).to receive(:instance) { input }
    allow(console).to receive(:clear_console)
    allow(input).to receive(:input_mode) { 1 }
    allow(input).to receive(:input_name) { PLAYER_1 }
    allow(input).to receive(:input_replay) { 'n' }
  end

  after do
    subject.start
  end

  it "displays beggining instructions" do
    expect(display).to receive(:display_beginning_instructions) 
  end

  context "when game is going to start" do
    it "clears console " do
      expect(console).to receive(:clear_console)
    end

    it "starts new game" do
      expect(gameplay).to receive(:play)
    end
  end

  context "in mode selection" do

    context "when one player mode selected" do
      it "asks once for player name" do
        expect(input).to receive(:input_name).once
      end
    end

    context "when two player mode selected" do
      before do
        allow(input).to receive(:input_name).and_return(PLAYER_1, PLAYER_2)
        allow(input).to receive(:input_mode) { 2 }
      end

      it "asks twice for player name" do
        expect(input).to receive(:input_name).once.with(player_number: 0)
        expect(input).to receive(:input_name).once.with(player_number: 1)
      end
    end
  end

  context "when game finished" do
    context "when wants to replay" do
      before { allow(input).to receive(:input_replay).and_return('y', 'n') }

      it "plays twice" do
        expect(subject).to receive(:start_game).twice
      end
    end

    context "does not want replay" do
      it "plays once" do
        expect(subject).to receive(:start_game).once
      end
    end
  end
end
