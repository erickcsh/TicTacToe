require 'tic_tac_toe'
require 'constants'

describe TicTacToe::Player, ".initialize" do
  subject { described_class.new(A_PLAYER_NAME) }

  its(:name) { should == A_PLAYER_NAME }
end

describe TicTacToe::Player, "#select_position" do 
  let(:cell) { double(:cell, position: 1) }
  let(:display) { double(:display).as_null_object }
  let(:posible_positions) { [cell, cell, cell] }

  context "when it is computer" do
    before do
      allow(TicTacToe::Display).to receive(:new).and_return(display)
    end

    it "displays computer thinking message" do
      expect(display).to receive(:display_msg_computer_thinking)
      described_class.new(A_COMPUTER_NAME, computer: true).select_position(posible_positions)
    end

    it "selects a random position" do
      allow(Kernel).to receive(:rand).and_return(1)
      position = described_class.new(A_COMPUTER_NAME, computer: true).select_position(posible_positions)
      expect(position).to eq(cell.position)
    end 
  end

  context "when it is player" do
    before do
      allow(TicTacToe::Display).to receive(:read_line).and_return(AN_INPUT)
      allow(TicTacToe::Display).to receive(:new).and_return(display)
    end

    it "displays select position message" do
      expect(display).to receive(:display_msg_select_position)
      described_class.new(A_PLAYER_NAME).select_position(posible_positions)
    end

    it "receives input position" do
      input_position = described_class.new(A_PLAYER_NAME).select_position(posible_positions)
      expect(input_position).to eq(AN_INPUT)
    end 
  end
end
