class Piece

  attr_reader :board, :color
  attr_accessor :pos

  def initialize(color, board, pos)
    @pos = pos
    @board = board
    @color = color
  end

  def valid_moves
    moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  def move_into_check?(end_pos)
    new_board = board.dup

    new_board.move_piece!(pos, end_pos)
    new_board.in_check?(color)
  end

  def to_s
    " #{symbol}"
  end

  def empty?
    self.is_a?(NullPiece) ? true : false
  end

end
