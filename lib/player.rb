require_relative '../lib/generable'

class Player
  include Generable
  attr_reader :code

  def initialize
    @code = []
  end

  def create_code; end
end
