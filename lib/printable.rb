module Printable
  def print_empty_line
    puts ''
  end

  def print_welcome_message
    puts 'Welcome to a new mastermind game!'
    print_empty_line
  end

  def print_role_prompt_message
    puts "Please select your role. Type 'creator' or 'guesser'"
  end

  def print_color_prompt_message
    puts 'Please enter a color from the list above'
  end

  def print_guesser_victory_message
    puts 'The guesser player won!'
  end

  def print_available_colors_message(colors)
    puts "The available colors are: \"#{colors}\""
    print_empty_line
  end

  def print_code_prompt_message(code_length)
    puts "Please enter a #{code_length} colors code"
    print_empty_line
  end

  def print_current_turn(turn)
    puts "Turn no. #{turn}"
    print_empty_line
  end

  def print_white_pegs_count(white_pegs)
    puts "You have #{white_pegs} white pegs"
  end

  def print_red_pegs_count(red_pegs = @red_pegs)
    puts "You have #{red_pegs} red pegs"
  end
end
