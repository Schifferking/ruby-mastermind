require_relative '../lib/player'

class Computer < Player
  def create_code
    @code = generate_code
  end

  def make_guess
    @code_guess += generate_code(CODE_LENGTH - code_guess.length)
  end
end
