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
    allow(subject).to receive(:select_position) { 'quit' }
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

  context "when asks for a position" do
    let(:cell) { double(:cell, position:'quit') }
    before do
      allow(board).to receive(:get_empty_positions) { [cell, cell, cell] }
      allow(subject).to receive(:select_position).and_call_original
    end

    context "when player is a computer" do
      let(:computer) { TicTacToe::Player.new(A_COMPUTER_NAME, computer: true) }
      let(:players) { [computer, player_2] }

      it "displays computer thinking message" do
        expect(display).to receive(:display_msg_computer_thinking)
      end

      it "selects random position" do
        expect(subject).to receive(:input_validation).with(cell.position).and_call_original
      end
    end

    context "when player is not a computer" do
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
          it_behaves_like "valid input"

          it "does not ask for input again" do
            expect(subject).to receive(:select_position).once.with(player_1, board)
          end

          it "quits the game" do
            expect(display).to receive(:display_turn_status).once
          end
        end

        context "when input is 'reset'" do
          before do
            allow(subject).to receive(:select_position).and_return('reset' , 'quit')
          end

          it_behaves_like "valid input"

          it "resets the game" do
            expect(board).to receive(:add_observer).with(checker).once
          end

        end

        context "when input is 'help'" do
          before do
            allow(subject).to receive(:select_position).and_return('help', 'quit')
            allow(display).to receive(:display_gameplay_instructions)
          end

          it_behaves_like "valid input"

          it "displays Instructions" do
            expect(display).to receive(:display_gameplay_instructions)
          end
        end
      end

      context "when input is a position" do
          before do
            allow(subject).to receive(:select_position).and_return(A_POSITION_STRING, 'quit')
          end

          it_behaves_like "valid input"

          it "fills the space in the board" do
            expect(board).to receive(:fill_board_space).with(A_POSITION_STRING, player_1)
          end

          it "displays the board" do
            expect(display).to receive(:print_board).with(board)
          end

          context "displays the result message of the action if any" do
            before do
              allow(checker).to receive(:win) { false }
              allow(checker).to receive(:draw) { false }
            end

            context "when there is a win" do
              it "displays message win" do
                allow(checker).to receive(:win) { true }
                expect(display).to receive(:display_msg_win).with(player_1.name)
              end
            end

            context "when there is a draw" do
              it "displays message draw" do
                allow(checker).to receive(:draw) { true }
                expect(display).to receive(:display_msg_draw)
              end
            end

            context "when there is no win nor draw" do
              it "does not display draw" do
                expect(display).not_to receive(:display_msg_draw)
              end

              it "does not display win message" do
                expect(display).not_to receive(:display_msg_win).with(player_1.name)
              end
            end
          end

          context "when it is an ending move" do
            before do
              allow(subject).to receive(:result_message) { subject.finish_game }
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
