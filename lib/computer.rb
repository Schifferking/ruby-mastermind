require_relative '../lib/player'

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
