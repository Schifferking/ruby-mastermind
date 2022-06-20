class Mastermind
  attr_reader :COLORS

  def initialize
    @COLORS = ['red', 'green', 'blue', 'pink', 'yellow', 'purple', 'orange', 'black', 'white', 'brown', 'gray']
  end

  def generate_code
    @COLORS.sample(6)
  end
end
