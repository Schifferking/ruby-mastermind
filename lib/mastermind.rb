require_relative '../lib/generable'
require_relative '../lib/printable'
require_relative '../lib/player'
require_relative '../lib/human'
require_relative '../lib/computer'

class Mastermind
  include Generable
  include Printable

  def initialize
    set_game
  end

  def print_pegs_count
    print_white_pegs_count(@white_pegs)
    print_red_pegs_count(@red_pegs)
    print_empty_line
  end

  def print_guesser_defeat_message
    puts 'The guesser player lost!'
    print_creator_code
  end

  def print_creator_code
    puts "The creator's code is: #{@creator.code.join(' ')}"
  end

  def print_guesser_code
    puts "The guesser's code is : #{@guesser.code.join(' ')}"
    print_empty_line
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
      print_available_colors_message(available_colors)
      print_color_prompt_message
      input = @human.enter_input
      print_empty_line
      return input if valid_color?(input) && repeated_color?(input) == false
    end
  end

  def obtain_code
    print_code_prompt_message(CODE_LENGTH)
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
    print_empty_line
    create_code
  end

  def set_next_turn
    print_pegs_count
    update_turn
    reset_pegs
    @guesser.calculate_colors_guessed(@creator.code)
    @guesser.reset_code
  end

  def play_current_turn
    print_current_turn(@turn)
    make_guess
    print_guesser_code
    count_pegs
  end

  def game
    loop do
      play_current_turn
      return print_guesser_victory_message if guesser_victory?

      set_next_turn
      return print_guesser_defeat_message if guesser_defeat?
    end
  end
end
