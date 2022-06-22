module Generable  
  CODE_LENGTH = 6
  COLORS = ['red', 'green', 'blue', 'pink', 'yellow', 'purple', 'orange', 'black', 'white', 'brown', 'gray']

  def generate_code
    COLORS.sample(CODE_LENGTH)
  end
end

class Player
  include Generable

  attr_accessor :guess_code
  attr_reader :CODE
  
  def initialize 
  end
  
  def obtain_code
    @CODE = generate_code
  end

  def enter_code
    @guess_code = []

    while guess_code.length < CODE_LENGTH
      print "Enter a color: "
      color = gets.chomp.downcase
      if COLORS.include?(color) && !guess_code.include?(color)
        guess_code.append(color)
      end
    end

    @guess_code
  end
end

class Human < Player
  def initialize
  end

  def obtain_code
    puts "Please enter a #{CODE_LENGTH} colors code"
    @CODE = enter_code
  end
end

class Computer < Player
  def initialize
  end
end

class Mastermind
  attr_accessor :computer, :human, :white_pegs, :red_pegs, :creator, :guesser

  def initialize(computer, human)
    @computer = computer
    @human = human
    @NUMBER_OF_TURNS = 12
  end

  def verify_code
    if guesser.guess_code.eql?(creator.CODE)
      return true
    end
  end
  
  def calculate_pegs
    @white_pegs = 0
    @red_pegs = 0

    computer.CODE.each_with_index do |color, index|
      if color.eql?(human.guess_code[index])
        @red_pegs += 1
      elsif !color.eql?(human.guess_code[index]) && computer.CODE.include?(human.guess_code[index])
        @white_pegs += 1
      end
    end
  end

  def select_role
    puts "Select one of these two options (use the number)\n1.Create the secret code\n2.Guess the secret code"

    human_choice = gets.chomp.to_i

    while human_choice == 0
      puts "Select a valid option (1 or 2)"
      human_choice = gets.chomp.to_i
    end

    if human_choice == 1
      @creator = human
      @guesser = computer
    else
      @creator = computer
      @guesser = human
    end
  end

  def game
    creator.obtain_code

    @NUMBER_OF_TURNS.times do |n|
      puts "Turn #{n + 1}\n\n"

      puts "Please enter a #{creator.CODE.length} colors code"

      puts "\nYour guess: #{guesser.enter_code}\n"

      if verify_code
        puts "You guessed the code, you win!"

        break
      else
        puts "Incorrect code\n"

        calculate_pegs
        
        puts "You have #{red_pegs} red peg(s) and #{white_pegs} white peg(s)\n\n"
      end
    end

    if !verify_code
      puts "You did not guess the code\n"

      puts "The creator code is #{creator.CODE}"
    end
  end
end

h = Human.new

c = Computer.new

m = Mastermind.new(c, h)

m.select_role

m.game
