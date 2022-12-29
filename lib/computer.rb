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
    @code += generate_code(CODE_LENGTH - @code.length)
  end

  def add_color(color)
    @next_guess << color if @next_guess.lengh < CODE_LENGTH
  end

  def color_in_code?(code, color)
    code.include?(color)
  end

  def calculate_colors_guessed(creator_code)
    CODE_LENGTH.times do |i|
      if creator_code[i] == @code[i]
        add_color(@code[i])
      elsif color_in_code?(code, @code[i])
        add_color(@code[i])
      end
    end
  end
end
