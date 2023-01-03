module Printable
  def print_welcome_message
    puts 'Welcome to a new mastermind game!'
  end
  
  def print_role_prompt_message
    puts "Please select your role. Type 'creator' or 'guesser'"
  end

  def print_color_prompt_message
    puts 'Please enter a color from the list above'
  end
end
