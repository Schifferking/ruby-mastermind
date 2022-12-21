require_relative '../lib/generable'

class Player
  include Generable
  attr_reader :code

  def initialize
    @code = []
  end

  def create_code; end

  def make_guess; end

  def reset_code_guess
    @code_guess = []
  end
end
