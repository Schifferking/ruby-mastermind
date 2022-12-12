module Generable
  CODE_LENGTH = 6
  COLORS = ['red', 'green', 'blue', 'pink', 'yellow', 'purple', 'orange', 'black', 'white', 'brown', 'gray']

  def generate_code(colors_needed = CODE_LENGTH)
    COLORS.sample(colors_needed)
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
  attr_accessor :code_guessed, :possible_colors

  def initialize
    @code_guessed = [nil, nil, nil, nil, nil, nil]
    @possible_colors = COLORS.dup
  end

  def generate_code(colors_needed = CODE_LENGTH)
    possible_colors.sample(colors_needed)
  end

  def enter_code(input_code = [])
    input_code.each_with_index do |color, index|
      if color.nil?
        new_color = generate_code(1).first
        new_color = generate_code(1).first while input_code.include?(new_color)
        input_code[index] = new_color
      end
    end
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
    @white_pegs = 0
    @red_pegs = 0
  end

  def verify_code
    true if guesser.guess_code.eql?(creator.code)
  end

  def calculate_pegs
    @white_pegs = 0
    @red_pegs = 0

    creator.code.each_with_index do |color, index|
      guesser_color = guesser.guess_code[index]
      if color.eql?(guesser_color)
        @red_pegs += 1
        if computer.role == 'guesser'
          # keep color on guess code
          computer.code_guessed[index] = color
        end
      elsif !color.eql?(guesser_color) && creator.code.include?(guesser_color)
        @white_pegs += 1
      elsif computer.role == 'guesser'
        guesser.possible_colors.delete(guesser_color) unless creator.code.include?(guesser_color)
        guesser.code_guessed[index] = nil
      end
    end
  end

  def ask_player_role
    puts "Select one of these two options (use the number)\n1.Create the secret code\n2.Guess the secret code"

    human_choice = gets.chomp.to_i

    while human_choice.zero?
      puts 'Select a valid option (1 or 2)'
      human_choice = gets.chomp.to_i
    end

    human_choice
  end

  def assign_roles(human_choice)
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

    @NUMBER_OF_TURNS.times do |n|
      puts "Turn #{n + 1}\n\n"

      if human.role == 'guesser'
        puts "Please enter a #{creator.code.length} colors code"

        guesser.enter_code

      else
        guesser.code_guessed.shuffle! if (@red_pegs + @white_pegs) == 6
        guesser.enter_code(guesser.code_guessed)
      end

      puts "\nYour guess: #{guesser.guess_code}\n"

      if verify_code
        puts 'You guessed the code, you win!'

        break
      else
        puts "Incorrect code\n"

        calculate_pegs

        puts "You have #{red_pegs} red peg(s) and #{white_pegs} white peg(s)\n\n"
      end
    end

    puts "You did not guess the code\nThe creator code is #{creator.code}" unless verify_code
  end
end

h = Human.new

c = Computer.new

m = Mastermind.new(c, h)

m.assign_roles(m.ask_player_role)

m.game
