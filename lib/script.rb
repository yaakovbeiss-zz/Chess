require_relative 'board'
require_relative 'display'
require_relative 'pieces'
require_relative 'cursor'


board = Board.new()
display = Display.new(board)

display.render
