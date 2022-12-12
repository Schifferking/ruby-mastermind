class Human < Player
  def initialize
  end

  def obtain_code
    puts "Please enter a #{CODE_LENGTH} colors code"
    @code = enter_code
  end

  def enter_input
    gets.chomp.downcase
  end
end
