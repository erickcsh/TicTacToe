require 'tic_tac_toe/display'
require 'constants'

describe TicTacToe::Display, "#print_board" do
  let(:cell) { double(:cell, content: CELL_CONTENT) }
  let(:board) { double(:board, rows: [[cell, cell],[cell, cell],[cell, cell]]) }

  subject { described_class.instance }

  before do
    allow(STDOUT).to receive(:puts)
    allow(STDOUT).to receive(:print)
  end

  it "displays the board top index" do
    expect(STDOUT).to receive(:puts).with("\t   A     B     C")
    subject.print_board(board)
  end 

  it "displays the board" do
    expect(STDOUT).to receive(:puts).once.with(BOARD_MESSAGE)
    subject.print_board(board)
  end
end

describe TicTacToe::Display, "#clear_console" do
  subject { described_class.instance }

  it "clears the subject" do
    expect(STDOUT).to receive(:puts).with(`clear`)
    subject.clear_console
  end 
end

describe TicTacToe::Display, "#display_turn_status" do
  let(:board) { double(:board, rows: [[]]) }
  subject { described_class.instance }

  before do
    allow(STDOUT).to receive(:puts)
    allow(STDOUT).to receive(:print)
  end

  it "displays the playing player name" do
    expect(STDOUT).to receive(:puts).with("\n\n #{A_PLAYER_NAME} turn")
    subject.display_turn_status(board, A_PLAYER_NAME)
  end

  it "calls print_board" do
    expect(subject).to receive(:print_board).with(board)
    subject.display_turn_status(board, A_PLAYER_NAME)
  end
end

describe TicTacToe::Display, "#display_msg_ask_for_player_name" do
  subject { described_class.instance }

  it "displays message asking for a player name" do
    expect(STDOUT).to receive(:puts).with("Enter player #{A_PLAYER_NUMBER + 1} name")
    subject.display_msg_ask_for_player_name(A_PLAYER_NUMBER)
  end
end

describe TicTacToe::Display, "#display_msg_win" do
  subject { described_class.instance }

  it "displays message with the winner player name" do
    expect(STDOUT).to receive(:puts).with("#{A_PLAYER_NAME} won")
    subject.display_msg_win(A_PLAYER_NAME)
  end
end

describe TicTacToe::Display, "#display_msg_computer_thinking" do
  subject { described_class.instance }

  before { allow(Kernel).to receive(:sleep) {} }

  it "displays message of computer thinking" do
    expect(STDOUT).to receive(:print).with("Thinking.")
    expect(STDOUT).to receive(:print).exactly(2).times.with(".")
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
  subject { described_class.instance }

  it { expect(subject).to respond_to(:display_msg_not_valid_input) }
end

describe TicTacToe::Display, "#display_msg_not_empty_position" do
  subject { described_class.instance }

  it { expect(subject).to respond_to(:display_msg_not_empty_position) }
end

describe TicTacToe::Display, "#display_msg_replay" do
  subject { described_class.instance }

  it { expect(subject).to respond_to(:display_msg_replay) }
end

describe TicTacToe::Display, "#display_modes_options" do
  subject { described_class.instance }

  it { expect(subject).to respond_to(:display_modes_options) }
end

describe TicTacToe::Display, "#display_error_msg_mode" do
  subject { described_class.instance }

  it { expect(subject).to respond_to(:display_error_msg_mode) }
end

describe TicTacToe::Display, "#display_msg_select_position" do
  subject { described_class.instance }

  it { expect(subject).to respond_to(:display_msg_select_position) }
end

describe TicTacToe::Display, "#display_msg_draw" do
  subject { described_class.instance }

  it { expect(subject).to respond_to(:display_msg_draw) }
end

describe TicTacToe::Display, "#display_beginning_instructions" do
  subject { described_class.instance }

  before do
    allow(STDOUT).to receive(:puts)
  end

  it { expect(subject).to respond_to(:display_beginning_instructions) }

  it "waits to continue" do
    expect(STDIN).to receive(:gets)
    subject.display_beginning_instructions
  end
end

describe TicTacToe::Display, "#display_gameplay_instructions" do
  subject { described_class.instance }

  before do
    allow(STDOUT).to receive(:puts)
  end

  it { expect(subject).to respond_to(:display_gameplay_instructions) }

  it "waits to continue" do
    expect(STDIN).to receive(:gets)
    subject.display_gameplay_instructions
  end
end

describe TicTacToe::Display, "#display_msg_does_not_exist" do
  subject { described_class.instance }

  it { expect(subject).not_to respond_to(:display_msg_does_not_exist) }
end
