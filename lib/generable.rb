module Generable
  CODE_LENGTH = 6
  COLORS = ['red', 'green', 'blue', 'pink', 'yellow', 'purple', 'orange', 'black', 'white', 'brown', 'gray']

  def generate_code(colors_needed = CODE_LENGTH)
    COLORS.sample(colors_needed)
  end
end
