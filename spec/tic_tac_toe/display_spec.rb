require 'tic_tac_toe/display'
require 'constants'

describe TicTacToe::Display, ".initialize" do
  context "when it is initialized with an output" do
    subject { described_class.new(AN_OUTPUT) }

    its(:output) { should == AN_OUTPUT }
  end

  context "when it is initialized without an output" do
    subject { described_class.new() }

    its(:output) { should == $stdout }
  end

end

describe TicTacToe::Display, "#print_board" do
  let(:cell) { double(:cell, content: CELL_CONTENT) }
  let(:board) { double(:board, rows: [[cell, cell],[cell, cell],[cell, cell]]) }
  let(:output) { double(:output).as_null_object }
  subject { described_class.new(output) }

  it "displays the board top index" do
    expect(output).to receive(:puts).with("\t   A     B     C")
    subject.print_board(board)
  end 

  it "displays the board" do
    expect(output).to receive(:puts).at_least(1).times.with(BOARD_MESSAGE)
    subject.print_board(board)
  end
end

describe TicTacToe::Display, "#clear_console" do
  let(:output) { double(:output).as_null_object }
  subject { described_class.new(output) }

  it "clears the output" do
    expect(output).to receive(:puts).with(`clear`)
    subject.clear_console
  end 
end

describe TicTacToe::Display, "#display_turn_status" do
  let(:board) { double(:board, rows: [[]]) }
  let(:output) { double(:output).as_null_object }
  subject { described_class.new(output) }

  it "displays the playing player name" do
    expect(output).to receive(:puts).with("\n\n #{A_PLAYER_NAME} turn")
    subject.display_turn_status(board, A_PLAYER_NAME)
  end

  it "calls print_board" do
    expect(subject).to receive(:print_board).with(board)
    subject.display_turn_status(board, A_PLAYER_NAME)
  end
end

describe TicTacToe::Display, "#display_msg_ask_for_player_name" do
  let(:output) { double(:output).as_null_object }
  subject { described_class.new(output) }

  it "displays message asking for a player name" do
    expect(output).to receive(:puts).with("Enter player #{A_PLAYER_NUMBER + 1} name")
    subject.display_msg_ask_for_player_name(A_PLAYER_NUMBER)
  end
end

describe TicTacToe::Display, "#display_msg_win" do
  let(:output) { double(:output).as_null_object }
  subject { described_class.new(output) }

  it "displays message with the winner player name" do
    expect(output).to receive(:puts).with("#{A_PLAYER_NAME} won")
    subject.display_msg_win(A_PLAYER_NAME)
  end
end

describe TicTacToe::Display, "#display_msg_computer_thinking" do
  let(:output) { double(:output).as_null_object }
  subject { described_class.new(output) }

  before { allow(Kernel).to receive(:sleep) {} }

  it "displays message of computer thinking" do
    expect(output).to receive(:print).with("Thinking.")
    expect(output).to receive(:print).exactly(2).times.with(".")
    subject.display_msg_computer_thinking
  end
end

describe TicTacToe::Display, ".read_line" do

  it "reads the input and chops the \\n" do
    allow(STDIN).to receive(:gets).and_return(AN_INPUT + "\n")
    expect(described_class.read_line).to eq(AN_INPUT)
  end
end

describe TicTacToe::Display, "#display_msg_not_valid_input" do
  it { expect(subject).to respond_to(:display_msg_not_valid_input) }
end

describe TicTacToe::Display, "#display_msg_not_empty_position" do
  it { expect(subject).to respond_to(:display_msg_not_empty_position) }
end

describe TicTacToe::Display, "#display_msg_replay" do
  it { expect(subject).to respond_to(:display_msg_replay) }
end

describe TicTacToe::Display, "#display_modes_options" do
  it { expect(subject).to respond_to(:display_modes_options) }
end

describe TicTacToe::Display, "#display_error_msg_mode" do
  it { expect(subject).to respond_to(:display_error_msg_mode) }
end

describe TicTacToe::Display, "#display_msg_select_position" do
  it { expect(subject).to respond_to(:display_msg_select_position) }
end

describe TicTacToe::Display, "#display_msg_draw" do
  it { expect(subject).to respond_to(:display_msg_draw) }
end

describe TicTacToe::Display, "#display_msg_does_not_exist" do
  it { expect(subject).not_to respond_to(:display_msg_does_not_exist) }
end
