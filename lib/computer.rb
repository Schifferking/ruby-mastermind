require_relative '../lib/player'

class Computer < Player
  def create_code
    @code = generate_code
  end
end
