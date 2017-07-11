require_relative 'piece'
require_relative 'slideable'

class Rook < Piece

  include Slideable

  def symbol
    '♜'.colorize(color)
  end

  protected

  def move_dirs
    non_diagonal_dirs
  end

end
