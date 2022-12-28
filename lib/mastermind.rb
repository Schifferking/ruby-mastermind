require_relative '../lib/generable'
require_relative '../lib/player'
require_relative '../lib/human'
require_relative '../lib/computer'

class Mastermind
  include Generable

  def initialize
    set_game
  end

  def print_welcome_message
    puts 'Welcome to a new mastermind game!'
  end

  def print_role_prompt_message
    puts "Please select your role. Type 'creator' or 'guesser'"
  end

  def print_available_colors_message
    puts "The available colors are: \"#{available_colors}\""
    print_empty_line
  end

  def print_color_prompt_message
    puts 'Please enter a color from the list above'
  end

  def print_code_prompt_message
    puts "Please enter a #{CODE_LENGTH} colors code"
  end

  def print_current_turn
    puts "Turn no. #{@turn}"
  end

  def print_white_pegs_count
    puts "You have #{@white_pegs} white pegs"
  end

  def print_red_pegs_count
    puts "You have #{@red_pegs} red pegs"
  end

  def print_pegs_count
    print_white_pegs_count
    print_red_pegs_count
  end

  def print_guesser_victory_message
    puts 'The guesser player won!'
  end

  def print_guesser_defeat_message
    puts 'The guesser player lost!'
  end

  def print_empty_line
    puts ''
  end

  def print_creator_code
    puts "The creator's code is: #{@creator.code.join(' ')}"
  end

  def roles
    %w[creator guesser]
  end

  def valid_role?(input)
    roles.include?(input)
  end

  def obtain_human_role
    loop do
      print_role_prompt_message
      input = @human.enter_input
      return input if valid_role?(input)
    end
  end

  def obtain_color
    loop do
      print_available_colors_message
      print_color_prompt_message
      input = @human.enter_input
      print_empty_line
      return input if valid_color?(input) && repeated_color?(input) == false
    end
  end

  def obtain_code
    loop do
      color = obtain_color
      @human.code << color
      return if @human.code.length == CODE_LENGTH
    end
  end

  def count_pegs
    CODE_LENGTH.times do |i|
      if same_color(@guesser.code[i], @creator.code[i])
        update_red_pegs
      else
        update_white_pegs
      end
    end
  end

  def assign_roles(human_role)
    case human_role
    when 'creator'
      @creator = @human
      @guesser = Computer.new
    when 'guesser'
      @creator = Computer.new
      @guesser = @human
    end
  end

  def available_colors
    COLORS - @human.code
  end

  def valid_color?(input)
    COLORS.include?(input)
  end

  def repeated_color?(color)
    @human.code.include?(color)
  end

  def same_color(color, other_color)
    color == other_color
  end

  def update_turn
    @turn += 1
  end

  def update_white_pegs
    @white_pegs += 1
  end

  def update_red_pegs
    @red_pegs += 1
  end

  def reset_white_pegs
    @white_pegs = 0
  end

  def reset_red_pegs
    @red_pegs = 0
  end

  def reset_pegs
    reset_white_pegs
    reset_red_pegs
  end

  def guesser_victory?
    @red_pegs == 6
  end

  def guesser_defeat?
    @turn == 13
  end

  def create_variables
    @human = Human.new
    @turn = 1
    @white_pegs = 0
    @red_pegs = 0
  end

  def create_code
    @creator.is_a?(Human) ? obtain_code : @creator.create_code
  end

  def make_guess
    @guesser.is_a?(Human) ? obtain_code : @guesser.make_guess
  end

  def set_game
    create_variables
    print_welcome_message
    assign_roles(obtain_human_role)
    create_code
  end
end
