require_relative '../lib/player'

class Computer < Player
  attr_reader :next_guess

  def initialize
    super
    @next_guess = []
  end

  def create_code
    @code = generate_code
  end

  def make_guess
    @code += generate_code(CODE_LENGTH - @code.length)
  end

  def add_color(color)
    @next_guess << color
  end
end
