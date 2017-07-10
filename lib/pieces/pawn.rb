require_relative 'piece'
require 'byebug'

class Pawn < Piece
  include Stepable

  def symbol
    '♟'.colorize(color)
  end

  def direction
    (color == :white) ? -1 : 1
  end

  def at_start_row?
    pos[0] == ((color == :white) ? 6 : 1)
  end

  def moves
    forward_dirs + side_attacks
  end

  def forward_dirs
    x, y = pos
    one_step = [x + direction, y]
    p one_step
    return [] unless board.in_bounds?(one_step)

    steps = [one_step]
    two_steps = [x + 2 * direction, y]
  
    steps << two_steps if at_start_row? && board.empty?(two_steps)
    steps
  end

  def side_attacks
    x, y = pos

    side_moves = [[x + direction, y - 1], [x + direction, y + 1]]

    side_moves.select do |new_pos|
      next false unless board.in_bounds?(new_pos)
      next false if board.empty?(new_pos)

      threatened_piece = board[new_pos]
      threatened_piece && threatened_piece.color != color
    end
  end

end
