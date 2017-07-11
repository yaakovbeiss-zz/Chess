require_relative 'piece'

class Queen < Piece
  include Slideable

  def symbol
    '♛'.colorize(color)
  end

  def move_dirs
    non_diagonal_dirs + diagonal_dirs
  end

end
