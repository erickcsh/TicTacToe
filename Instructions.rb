module Instructions

  INSTRUCTIONS_AT_BEGINNING = "Example1"
  INSTRUCTIONS_AT_GAMEPLAY = "Example2"

  def self.display_beginning_instructions
    puts INSTRUCTIONS_AT_BEGINNING
    STDIN.gets
  end

  def self.display_gameplay_instructions
    puts INSTRUCTIONS_AT_GAMEPLAY
    STDIN.gets
  end
end
