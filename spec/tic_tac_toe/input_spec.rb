require 'tic_tac_toe'
require 'constants'
require 'boards'

describe TicTacToe::Input, ".ask_name" do
  let(:display) { double(:display).as_null_object }

  before do
    allow(TicTacToe::Display).to receive(:read_line) { PLAYER_1 }
    allow(TicTacToe::Display).to receive(:instance) { display }
  end

  after do
    described_class.instance.ask_name(0)
  end

  it "displays enter player name message" do
    expect(display).to receive(:display_msg_ask_for_player_name)
  end

  it "reads player name" do
    expect(TicTacToe::Display).to receive(:read_line)
  end
end

describe TicTacToe::Input, ".ask_replay" do
  let(:display) { double(:display).as_null_object }

  before do
    allow(TicTacToe::Display).to receive(:read_line) { PLAYER_1 }
    allow(TicTacToe::Display).to receive(:instance) { display }
  end

  after do
    described_class.instance.ask_replay
  end

  it "displays replay message" do
    expect(display).to receive(:display_msg_replay)
  end

  it "reads replay answer" do
    expect(TicTacToe::Display).to receive(:read_line)
  end
end

describe TicTacToe::Input, ".ask_mode" do
  let(:display) { double(:display).as_null_object }

  before do
    allow(TicTacToe::Display).to receive(:read_line) { PLAYER_1 }
    allow(TicTacToe::Display).to receive(:instance) { display }
  end

  after do
    described_class.instance.ask_mode
  end

  context "when valid mode is selected" do
    it "does not display error message" do
      expect(display).not_to receive(:display_error_msg_mode)
    end
  end

  context "when invalid mode is selected" do
    before do
      allow(TicTacToe::Display).to receive(:read_line).and_return( AN_INVALID_MODE, A_VALID_MODE)
    end

    it "displays error message" do
      expect(display).to receive(:display_error_msg_mode)
    end
  end
end

describe TicTacToe::Input, ".ask_player_action" do
  let(:display) { double(:display).as_null_object }
  let(:checker) { double(:checker).as_null_object }
  let(:board) { double(:board).as_null_object }
  let(:player_1) { Boards.player_1 }

  subject { described_class.instance }

  before do
    allow(TicTacToe::Display).to receive(:read_line).and_return( 'quit')
    allow(TicTacToe::Display).to receive(:instance) { display }
    allow(Kernel).to receive(:rand) { 0 }
  end

  context "when asks for a position" do
    let(:cell) { double(:cell, position:'quit') }
    before do
      allow(board).to receive(:get_empty_positions) { [cell, cell, cell] }
    end

    context "when player is a computer" do
      after do
        subject.ask_player_action(computer, board)
      end

      let(:computer) { TicTacToe::Player.new(A_COMPUTER_NAME, computer: true) }

      it "displays computer thinking message" do
        expect(display).to receive(:display_msg_computer_thinking)
      end

      it "selects random position" do
        expect(subject).to receive(:input_validation).with(cell.position, board).and_call_original
      end
    end

    context "when player is not a computer" do
      after do
        subject.ask_player_action(player_1, board)
      end
      it "displays select position message" do
        allow(TicTacToe::Display).to receive(:read_line) { 'quit' }
        expect(display).to receive(:display_msg_select_position)
      end

      it "reads player's input" do
        expect(TicTacToe::Display).to receive(:read_line) { 'quit' }
      end
    end
  end

  context "when player types an input" do
    after do
        subject.ask_player_action(player_1, board)
    end

    context "when input is invalid" do
      shared_examples "re-ask position" do
        it "asks for input again" do
          expect(subject).to receive(:select_position).twice.with(player_1, board)
        end
      end

      context "when input is not a valid  position" do
        before do
          allow(subject).to receive(:select_position).and_return(INVALID_INPUT_POSITION, 'quit')
        end

        it "displays not valid input error message" do
          expect(display).to receive(:display_msg_not_valid_input)
        end

        it_behaves_like "re-ask position"
      end

      context "when input is not an empty position" do
        before do
          allow(subject).to receive(:select_position).and_return(A_POSITION_STRING, 'quit')
          allow(board).to receive(:position_empty?) { false }
        end

        it "displays not empty position error message" do
          expect(display).to receive(:display_msg_not_empty_position)
        end

        it_behaves_like "re-ask position"
      end
    end

    context "when input is valid" do
      shared_examples "valid input" do
        it "does not show error messagges" do
          expect(display).not_to receive(:display_msg_not_valid_input)
          expect(display).not_to receive(:display_msg_not_empty_position)
        end
      end

      context "when input is a special option" do
        context "when input is 'quit'" do
          before do
            allow(subject).to receive(:select_position) { 'quit' }
          end

          it_behaves_like "valid input"

          it "does not ask for input again" do
            expect(subject).to receive(:select_position).once.with(player_1, board)
          end
        end

        context "when input is 'reset'" do
          before do
            allow(subject).to receive(:select_position).and_return('reset' , 'quit')
          end

          it_behaves_like "valid input"
        end

        context "when input is 'help'" do
          before do
            allow(subject).to receive(:select_position).and_return('help', 'quit')
            allow(display).to receive(:display_gameplay_instructions)
          end

          it_behaves_like "valid input"
        end
      end

      context "when input is a position" do
          before do
            allow(subject).to receive(:select_position).and_return(A_POSITION_STRING, 'quit')
          end

          it_behaves_like "valid input"
      end
    end
  end
end
