require_relative 'display'
require_relative 'player'

class HumanPlayer < Player

  def make_move(board)
    start_pos, end_pos = nil, nil

    until start_pos && end_pos
      display.render

      if start_pos
        puts " #{color}'s turn. Where do you want to move?"
        end_pos = display.cursor.get_input

      else
        puts "#{color}'s turn. Which piece do you want to move?"
        start_pos = display.cursor.get_input
      end

    end
    [start_pos, end_pos]
  end

end
