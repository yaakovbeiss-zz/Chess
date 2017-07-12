require_relative 'pieces'

class Board

  attr_accessor :grid

  def initialize(fill = true)
    @grid = Array.new(8) { Array.new(8, NullPiece.instance) }
    if fill
      fill_board
    end
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def empty?(pos)
    return true if self[pos].is_a?(NullPiece)
    false
  end

  def add_piece(piece, pos)
    raise 'position not empty' unless self[pos].is_a?(NullPiece)
    self[pos] = piece
  end

  def dup
    new_board = Board.new(false)

    pieces.each do |piece|
      new_piece = piece.class.new(piece.color, new_board, piece.pos)
      new_board[new_piece.pos] = new_piece
    end
    new_board
  end

  def pieces
    @grid.flatten.reject {|piece| piece.empty?}
  end

  def move_piece(turn_color, start_pos, end_pos)
    raise StartError if self[start_pos].is_a?(NullPiece)

    piece = self[start_pos]

    if piece.color != turn_color
      raise 'You cannot move the opponents piece'
    elsif !piece.moves.include?(end_pos)
      raise 'You cannot move like that'
    elsif !piece.valid_moves.include?(end_pos)
      raise 'You cannot place yourself into check.'
    end

    piece.pos = end_pos
    self[end_pos] = piece
    self[start_pos] = NullPiece.instance

    nil
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]

    if !piece.moves.include?(end_pos)
      raise 'piece cannot move like that'
    end

    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
    piece.pos = end_pos
    nil
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0,7) }
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king_pos)
    end
  end

  def checkmate?(color)
    pieces.select {|p| p.color == color}.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def find_king(color)
    king = pieces.find { |piece| piece.color == color && piece.is_a?(King)}
  end

  private

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]
    row = (color == :white) ? 7 : 0
    back_pieces.each_with_index do |piece_class, idx|
    piece = piece_class.new(color, self, [row, idx])
      add_piece(piece, piece.pos)
    end
  end

  def fill_pawns_row(color)
    row = (color == :white) ? 6 : 1
    8.times  do |i|

      pawn = Pawn.new(color, self, [row, i])
      add_piece(pawn, pawn.pos)
    end
  end

  def fill_board
    [:white, :black].each do |color|
      fill_back_row(color)
      fill_pawns_row(color)
    end
  end

end

class StartError < StandardError
  def message
    puts "There is no piece at that position."
  end
end

class ValidMoveError < StandardError
  def message
    puts "The position you entered is off the board."
  end
end

board = Board.new()
