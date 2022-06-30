module Generable
  CODE_LENGTH = 6
  COLORS = ['red', 'green', 'blue', 'pink', 'yellow', 'purple', 'orange', 'black', 'white', 'brown', 'gray']

  def generate_code
    COLORS.sample(CODE_LENGTH)
  end
end

class Player
  include Generable

  attr_accessor :guess_code, :role, :code

  def initialize
    @role = ''
  end

  def obtain_code
    @code = generate_code
  end

  def enter_code
    @guess_code = []

    while guess_code.length < CODE_LENGTH
      print 'Enter a color: '
      color = gets.chomp.downcase
      guess_code.append(color) if COLORS.include?(color) && !guess_code.include?(color)
    end

    @guess_code
  end
end

class Human < Player
  def initialize
  end

  def obtain_code
    puts "Please enter a #{CODE_LENGTH} colors code"
    @code = enter_code
  end
end

class Computer < Player
  attr_accessor :combinations, :colors_hash

  def initialize
  end

  def generate_combinations
    @combinations = COLORS.repeated_permutation(CODE_LENGTH).to_a
  end

  def enter_code(input_code = [])
    @guess_code = input_code
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
    true if guesser.guess_code.eql?(creator.code)
  end

  def calculate_pegs
    @white_pegs = 0
    @red_pegs = 0

    creator.code.each_with_index do |color, index|
      if color.eql?(guesser.guess_code[index])
        @red_pegs += 1
      elsif !color.eql?(guesser.guess_code[index]) && creator.code.include?(guesser.guess_code[index])
        @white_pegs += 1
      end
    end
  end

  def select_role
    puts "Select one of these two options (use the number)\n1.Create the secret code\n2.Guess the secret code"

    human_choice = gets.chomp.to_i

    while human_choice.zero?
      puts 'Select a valid option (1 or 2)'
      human_choice = gets.chomp.to_i
    end

    if human_choice == 1
      @creator = human
      human.role = 'creator'
      @guesser = computer
      computer.role = 'guesser'
    else
      @creator = computer
      computer.role = 'creator'
      @guesser = human
      human.role = 'guesser'
    end
  end

  def game
    creator.obtain_code

    computer.generate_combinations if computer.role == 'guesser'

    @NUMBER_OF_TURNS.times do |n|
      puts "Turn #{n + 1}\n\n"

      if human.role == 'guesser'
        puts "Please enter a #{creator.code.length} colors code"

        guesser.enter_code

      else
        # Computer enters code
        if n.zero?
          guesser.enter_code(["red", "red", "red", "green", "green", "green"])
        else
          # Enter new code
        end
      end

      puts "\nYour guess: #{guesser.guess_code}\n"

      if verify_code
        puts 'You guessed the code, you win!'

        break
      else
        puts "Incorrect code\n"

        calculate_pegs

        puts "You have #{red_pegs} red peg(s) and #{white_pegs} white peg(s)\n\n"

        if computer.role == 'guesser'
          # Remove combinations where a color is not in code
          guesser.guess_code.uniq.each do |color|
            unless creator.code.include?(color)
              guesser.combinations.reject! { |combination| combination.include?(color) }
            end
          end
        end
      end
    end

    puts "You did not guess the code\nThe creator code is #{creator.code}" unless verify_code
  end
end

h = Human.new

c = Computer.new

m = Mastermind.new(c, h)

m.select_role

m.game
