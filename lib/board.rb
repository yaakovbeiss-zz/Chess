require_relative 'pieces'

class Board

  attr_accessor :grid

  def initialize()
    @grid = Array.new(8) { Array.new(8) }
    @grid.each_with_index do |row, x|
      row.each_with_index do |col, y|
        if x < 2 || x > 5
          @grid[x][y] = Piece.new([x,y])
        else
          @grid[x][y] = NullPiece.new([x,y])
        end
      end
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

  def add_piece(piece, pos)
    raise 'position not empty' unless empty?(pos)
    self[pos] = piece
  end

  def dup
    new_board = Board.new

    pieces.each do |piece|
      piece.class.new(piece.color, new_board, piece.pos)
    end
    new_board
  end

  def pieces
    @grid.flatten.reject {|piece| piece.empty?}
  end

  def valid_move?(start_pos, end_pos)
    raise StartError if self[start_pos].is_a?(NullPiece)
    if (start_pos.any? {|x| x < 0 || x > 7} || end_pos.any? {|x| x < 0 || x > 7})
      raise ValidMoveError
    end
  end

  def move_piece(start_pos, end_pos)
    valid_move?(start_pos, end_pos)
    piece = self[start_pos]
    piece.pos = end_pos
    self[end_pos] = piece
    self[start_pos] = NullPiece.new(start_pos)
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0,7) }
  end

  def empty?(pos)
    self[pos].empty?
  end

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]
    row = (color == :white) ? 7 : 0
    back_pieces.each_with_index do |piece_class, idx|
      piece_class.new(color, self, [row, idx])
    end
  end

  def fill_pawns_row
    row = (color == :white) ? 6 : 1
    8.times { |i| Pawn.new(color, self, [row, i])}
  end

  def fill_board
    
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
