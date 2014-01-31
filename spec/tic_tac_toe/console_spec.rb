require 'tic_tac_toe'
require 'constants'

describe TicTacToe::Console, "#clear_console" do
  subject { described_class.instance }

  it "clears the subject" do
    expect(STDOUT).to receive(:puts).with(`clear`)
    subject.clear_console
  end 
end
