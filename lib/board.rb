require_relative 'pieces'
require 'byebug'

class Board

  attr_accessor :grid

  def initialize()
    @grid = Array.new(8) { Array.new(8) }
    fill_board
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
    raise 'position not empty' unless self[pos]== nil
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

  def valid_move?(start_pos)
    raise StartError if self[start_pos].is_a?(NullPiece)
  end

  def move_piece(turn_color, start_pos, end_pos)

    valid_move?(start_pos)
    piece = self[start_pos]

    if piece.color != turn_color
      raise 'You cannot move the opponents piece'
    elsif !piece.moves.include?(end_pos)
      p piece.moves
      raise 'You cannot move like that'
    end
    piece.pos = end_pos
    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
    nil
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0,7) }
  end

  def find_king(color)
    king_pos = pieces.find { |p| p.color == color && p.is_a(King)}
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
    4.times do |i|
      8.times do |j|
        add_piece( NullPiece.instance, [i + 2, j])
      end
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
