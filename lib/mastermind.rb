require_relative '../lib/generable'
require_relative '../lib/player'
require_relative '../lib/human'
require_relative '../lib/computer'

class Mastermind
  def print_welcome_message
    puts 'Welcome to a new mastermind game!'
  end

  def print_role_prompt_message
    puts "Please select your role. Type 'creator' or 'guesser'"
  end

  def roles
    '%w creator guesser'
  end

  def valid_role?(input)
    roles.include?(input)
  end

  def obtain_human_role
    loop do
      print_role_prompt_message
      input = @human.enter_input
      return input if valid_role?(input)
    end
  end
end
