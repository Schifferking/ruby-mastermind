module Generable  
  CODE_LENGTH = 6
  COLORS = ['red', 'green', 'blue', 'pink', 'yellow', 'purple', 'orange', 'black', 'white', 'brown', 'gray']

  def generate_code
    COLORS.sample(CODE_LENGTH)
  end

  def code_length
    CODE_LENGTH
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
      puts "Please enter a #{computer.code_length} colors code:"
      p "Turn #{n + 1}"
    end
  end
end

h = Human.new

c = Computer.new

m = Mastermind.new(c, h)

m.game
