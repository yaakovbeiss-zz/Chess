class Piece

  attr_reader :board, :color
  attr_accessor :pos

  def initialize(color, board, pos)
    @pos = pos
    @board = board
    @color = color
  end

  def moves
  end

  def to_s
    " #{symbol}"
  end

  def empty?
    self.is_a?(NullPiece) ? true : false
  end

end
