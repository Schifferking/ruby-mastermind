require_relative '../lib/generable'
require_relative '../lib/player'
require_relative '../lib/human'
require_relative '../lib/computer'

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

  def print_welcome_message
    puts 'Welcome to a new mastermind game!'
  end
end

h = Human.new

c = Computer.new

m = Mastermind.new(c, h)

m.assign_roles(m.ask_player_role)

m.game
