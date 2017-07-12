require_relative 'board'
require_relative 'human_player'

class Game

  attr_reader :board, :display, :current_player, :players

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      white: HumanPlayer.new(:white, @display),
      black: HumanPlayer.new(:black, @display)
    }
    @current_player = :white
  end

  def play
    display.render

    until board.checkmate?(current_player)
      begin
        start_pos, end_pos = players[current_player].make_move(board)
        board.move_piece(current_player, start_pos, end_pos)

        change_turn
      rescue StandardError => e
        puts e.message
        retry
      end
    end
    puts "the game is over"
  end

  private

  def change_turn
    @current_player = (current_player == :white) ? :black : :white
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
