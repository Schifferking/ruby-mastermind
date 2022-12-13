require_relative '../lib/generable'

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
