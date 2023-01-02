require_relative '../lib/player'

class Computer < Player
  attr_reader :next_guess

  def initialize
    super
    @next_guess = Array.new(6, nil)
  end

  def create_code
    @code = generate_code
  end

  def make_guess
    @code = @next_guess.dup
    if shuffle_code?
      @code.shuffle!
    else
      obtain_unique_colors
    end
  end

  def shuffle_code?
    @code.none?(&:nil?)
  end

  def add_color?(color)
    @next_guess.length < CODE_LENGTH &&
      color_in_code?(@next_guess, color) == false
  end

  def add_color(color, index)
    @next_guess[index] = color
  end

  def add_nil
    @next_guess << nil if @next_guess.length < CODE_LENGTH
  end

  def color_in_code?(code, color)
    code.include?(color)
  end

  def replace_nil_element(color)
    nil_index = @code.index(nil)
    @code[nil_index] = color
  end

  def calculate_colors_guessed(creator_code)
    CODE_LENGTH.times do |i|
      if creator_code[i] == @code[i]
        add_color(@code[i], i)
      else
        add_nil
      end
    end
  end

  def obtain_unique_colors
    loop do
      new_color = generate_color
      replace_nil_element(new_color) unless color_in_code?(@code, new_color)
      break unless color_in_code?(@code, nil)
    end
  end
end
