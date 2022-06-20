module Generable
    COLORS = ['red', 'green', 'blue', 'pink', 'yellow', 'purple', 'orange', 'black', 'white', 'brown', 'gray']

  def generate_code
    COLORS.sample(6)
  end
end

class Player
  include Generable

  attr_reader :CODE
  def initialize 
  end
  
  def obtain_code
    @CODE = generate_code
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
  attr_accessor :computer, :human

  def initialize(computer, human)
    @computer = computer
    @human = human
    @NUMBER_OF_TURNS = 12
  end

  def game
    computer.obtain_code

    @NUMBER_OF_TURNS.times do |n|
      p "Turn #{n + 1}"
    end
  end
end

h = Human.new

c = Computer.new

m = Mastermind.new(c, h)

m.game
