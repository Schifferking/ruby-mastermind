module Printable
  def print_empty_line
    puts ''
  end

  def print_welcome_message
    puts 'Welcome to a new mastermind game!'
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
end
