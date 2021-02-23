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

      # Ensure a valid end position is found
      got_end = false
      while !got_end
        got_end = true
        end_pos = get_end(board, start_pos)
        # Cancel current piece move and switch to new piece
        if board[end_pos].color == @color
          start_pos = end_pos
          got_end = false
        end
      end

      # Cancel piece selection if re-selected
      valid_input = false if start_pos == end_pos
    end

    board.move_piece(@color, start_pos, end_pos)
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
      start_valid = false if board[start_pos].valid_moves.empty? # piece cannot move
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
        @display.render(@color, board[start_pos]) # Update board with selected piece
        end_pos = @display.cursor.get_input.dup
      end
      return end_pos if end_pos == start_pos # Cancel piece selection
      return end_pos if board[end_pos].color == color # Switch piece selection
      end_valid = false if !board.valid_pos?(end_pos) # out-of-bounds
      end_valid = false if !board[start_pos].valid_moves.include?(end_pos) # invalid move
    end
    end_pos
  end

end