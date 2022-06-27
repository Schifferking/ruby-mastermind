module Generable
  CODE_LENGTH = 6
  COLORS = ['red', 'green', 'blue', 'pink', 'yellow', 'purple', 'orange', 'black', 'white', 'brown', 'gray']

  def generate_code
    COLORS.sample(CODE_LENGTH)
  end
end

class Player
  include Generable

  attr_accessor :guess_code, :role
  attr_reader :CODE
  
  def initialize
    @role = ""
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
  attr_accessor :combinations

  def initialize
  end

  def generate_combinations
    @combinations = COLORS.repeated_permutation(CODE_LENGTH).to_a
  end

  def enter_code(code=[])
    @guess_code = code
    @guess_code
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

    creator.CODE.each_with_index do |color, index|
      if color.eql?(guesser.guess_code[index])
        @red_pegs += 1
      elsif !color.eql?(guesser.guess_code[index]) && creator.CODE.include?(guesser.guess_code[index])
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
      human.role = "creator"
      @guesser = computer
      computer.role = "guesser"
    else
      @creator = computer
      computer.role = "creator"
      @guesser = human
      human.role = "guesser"
    end
  end

  def game
    creator.obtain_code
    
    if computer.role == "guesser"
      computer.generate_combinations
    end

    @NUMBER_OF_TURNS.times do |n|
      puts "Turn #{n + 1}\n\n"

      if human.role == "guesser"
        puts "Please enter a #{creator.CODE.length} colors code"

        guesser.enter_code

      else
        if n == 0
          guesser.enter_code(["red", "red", "red", "green", "green", "green"])
        else
          # Enter new code
        end
      end
      
      puts "\nYour guess: #{guesser.guess_code}\n"

      if verify_code
        puts "You guessed the code, you win!"

        break
      else
        puts "Incorrect code\n"

        calculate_pegs
        
        puts "You have #{red_pegs} red peg(s) and #{white_pegs} white peg(s)\n\n"

        # Remove combinations where a color is not in code
        guesser.guess_code.uniq.each do |color|
          if !creator.CODE.include?(color)
            guesser.combinations.select! { |combination| !combination.include?(color) }
          end
        end
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
