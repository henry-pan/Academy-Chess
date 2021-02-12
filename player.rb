require_relative "cursor"

class Player

  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

end

class HumanPlayer < Player

  def make_move(board)
    begin
      start_pos = nil
      while start_pos == nil
        system("clear")
        @display.render(@color)
        start_pos = @display.cursor.get_input.dup
      end

      end_pos = nil
      while end_pos == nil
        system("clear")
        @display.render(@color)
        end_pos = @display.cursor.get_input.dup
      end

      board.move_piece(@color, start_pos, end_pos)
    rescue
      sleep(5)
      retry
    end
  end

end