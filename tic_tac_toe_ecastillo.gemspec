lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require File.expand_path("../lib/tic_tac_toe_ecastillo/version", __FILE__)

Gem::Specification.new do |s|
  s.name = 'tic_tac_toe_ecastillo'
  s.version = TicTacToeEcastillo::VERSION
  s.date = '2014-01-31'
  s.summary = 'TicTacToe!'
  s.description = 'Play a simple TicTacToe game'
  s.authors = ['Erick Castillo']
  s.email = 'ecastillo@pernix-solutions.com'
  s.files         = Dir.glob("{bin,lib,res}/**/*") + %w(README.md)
  s.test_files    = Dir['spec/*']
  s.executables << 'tic_tac_toe'
  s.require_path = 'lib'
  s.homepage = 'http://github.com/erickcsh/TicTacToe'
  s.license = 'MIT'
end
