require_relative '../lib/player'

class Human < Player
  def enter_input
    gets.chomp.downcase
  end
end
