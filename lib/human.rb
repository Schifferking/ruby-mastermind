require_relative '../lib/player'

class Human < Player
  def enter_input
    gets.chomp.downcase
  end

  def create_code; end

  def add_color(color)
    @code << color
  end
end
