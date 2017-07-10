module Slideable
  NON_DIAGONAL_DIRS = [
    [-1,0],
    [0,-1],
    [0,1],
    [1,0]
  ]
  DIAGONAL_DIRS = [
    [-1,-1],
    [-1,1],
    [1,1],
    [1,-1]
  ]

  def non_diagonal_dirs
    NON_DIAGONAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    all_moves = []
    move_dirs.each do |dx, dy|

      all_moves.concat(find_possible_moves(dx, dy))
    end
    all_moves
  end

  private

  def move_dirs
    raise NotImplementedError
  end

  def find_possible_moves(dx, dy)
    cur_x, cur_y = pos
    possible_moves = []

    loop do
      cur_x, cur_y = cur_x + dx, cur_y + dy
      pos = [cur_x, cur_y]
      break unless board.in_bounds?(pos)

      if board.empty?(pos)
        possible_moves << pos
      else
        possible_moves << pos if board[pos].color != color
        break
      end
    end

    possible_moves
  end


end
