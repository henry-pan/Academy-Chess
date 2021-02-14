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


      # raise "Start position is out of bounds" if !valid_pos?(start_pos)
      # raise "End position is out of bounds" if !valid_pos?(end_pos)
      # raise "Start position is empty" if self[start_pos] == @null_piece
      # raise "End position contains own piece" if color == self[end_pos].color
      # raise "That's not your piece" if color != self[start_pos].color
  
      # self[end_pos], self[start_pos] = self[start_pos], @null_piece
  
      # self[end_pos].pos = end_pos
      # raise "Cannot move into check" if in_check?(color) 



    rescue
      sleep(5)
      retry
    end
  end

end