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
    valid_input = false
    while !valid_input
      valid_input = true
      start_pos = get_start(board)
      end_pos = get_end(board, start_pos)

      valid_input = false if start_pos == end_pos # cancel piece selection
    end

    board.move_piece(@color, start_pos, end_pos)


    # raise "Cannot move into check" if in_check?(color) 

  end

  def get_start(board)
    start_valid = false
    while !start_valid
      start_valid = true
      start_pos = nil
      while start_pos == nil
        system("clear")
        @display.render(@color)
        start_pos = @display.cursor.get_input.dup
      end
      start_valid = false if !board.valid_pos?(start_pos) # out-of-bounds
      start_valid = false if board[start_pos].color != color # not your piece
    end
    start_pos
  end

  def get_end(board, start_pos)
    end_valid = false
    while !end_valid
      end_valid = true
      end_pos = nil
      while end_pos == nil
        system("clear")
        @display.render(@color, board[start_pos]) # Send selected piece to be rendered
        end_pos = @display.cursor.get_input.dup
      end
      return end_pos if end_pos == start_pos
      end_valid = false if !board.valid_pos?(end_pos) # out-of-bounds
      end_valid = false if start_pos != end_pos && board[end_pos].color == color # can't capture own piece
      end_valid = false if !board[start_pos].valid_moves.include?(end_pos) # invalid move
    end
    end_pos
  end

end