require 'singleton'
require_relative 'piece'

class NullPiece < Piece
  attr_reader :symbol
  include Singleton

  def initialize
    @symbol = "    "
    @color = :none
  end

  def symbol
    " "
  end

  def moves
    []
  end

end
