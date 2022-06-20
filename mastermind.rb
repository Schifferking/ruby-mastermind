module Generable
    COLORS = ['red', 'green', 'blue', 'pink', 'yellow', 'purple', 'orange', 'black', 'white', 'brown', 'gray']

  def generate_code
    COLORS.sample(6)
  end
end

class Player
  include Generable

  def initialize    
  end

end

class Human < Player
  def initialize
  end
end

class Computer < Player
  def initialize
  end
end
