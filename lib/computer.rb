require_relative '../lib/player'

class Computer < Player
  attr_reader :next_guess

  def initialize
    super
    @next_guess = []
  end

  def create_code
    @code = generate_code
  end

  def make_guess
    @code = @next_guess
    if @code.length == CODE_LENGTH
      @code.shuffle!
    else
      @code += generate_code(CODE_LENGTH - @code.length)
    end
  end

  def add_color?(color)
    @next_guess.length < CODE_LENGTH &&
      color_in_code?(@next_guess, color) == false
  end

  def add_color(color)
    @next_guess << color if add_color?(color)
  end

  def color_in_code?(code, color)
    code.include?(color)
  end

  def calculate_colors_guessed(creator_code)
    CODE_LENGTH.times do |i|
      if creator_code[i] == @code[i]
        add_color(@code[i])
      elsif color_in_code?(creator_code, @code[i])
        add_color(@code[i])
      end
    end
  end

  def obtain_unique_colors
    loop do
      new_color = generate_color
      @code << new_color unless color_in_code?(@code, new_color)
      break if @code.length == CODE_LENGTH
    end
  end
end
