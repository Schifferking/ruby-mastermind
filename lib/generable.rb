module Generable
  CODE_LENGTH = 6
  COLORS = '%w red green blue pink
            yellow purple orange black
            white brown gray'.freeze

  def generate_code(colors_needed = CODE_LENGTH)
    COLORS.sample(colors_needed)
  end
end
