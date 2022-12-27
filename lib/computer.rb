require_relative '../lib/player'

class Computer < Player
  def create_code
    @code = generate_code
  end

  def make_guess
    @code += generate_code(CODE_LENGTH - @code.length)
  end
end
