require_relative '../lib/generable'
require_relative '../lib/player'
require_relative '../lib/human'
require_relative '../lib/computer'

class Mastermind
  include Generable

  def initialize
    @human = Human.new
    @turn = 1
    @white_pegs = 0
    @red_pegs = 0
  end

  def print_welcome_message
    puts 'Welcome to a new mastermind game!'
  end

  def print_role_prompt_message
    puts "Please select your role. Type 'creator' or 'guesser'"
  end

  def print_available_colors_message
    puts "The available colors are: \"#{available_colors}\""
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

  def roles
    '%w creator guesser'
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
      return input if valid_color?(input) && repeated_color?(input) == false
    end
  end

  def create_code
    loop do
      color = obtain_color
      @creator.add_color(color)
      return if @creator.code.count == CODE_LENGTH
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
    COLORS - @creator.code
  end

  def valid_color?(input)
    COLORS.include?(input)
  end

  def repeated_color?(color)
    @creator.code.include?(color)
  end

  def update_turn
    @turn += 1
  end
end
