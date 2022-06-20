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

class Mastermind
  def initialize
    @NUMBER_OF_TURNS = 12
  end

  def game
    @NUMBER_OF_TURNS.times do |n|
      p "Turn #{n + 1}"
    end
  end
end

mastermind = Mastermind.new
mastermind.game
