require_relative "piece"

class Board

  attr_reader :rows

  def initialize
    @null_piece = NullPiece.instance
    @rows = Array.new(8) { Array.new(8, @null_piece) }
    populate_board
  end

  def populate_board
    @rows[1].each_with_index { |col, i| @rows[1][i] = Pawn.new("black", self, [1,i]) }
    @rows[0][0] = Rook.new("black", self, [0,0])
    @rows[0][1] = Knight.new("black", self, [0,1])
    @rows[0][2] = Bishop.new("black", self, [0,2])
    @rows[0][3] = Queen.new("black", self, [0,3])
    @black_king = King.new("black", self, [0,4])
    @rows[0][4] = @black_king
    @rows[0][5] = Bishop.new("black", self, [0,5])
    @rows[0][6] = Knight.new("black", self, [0,6])
    @rows[0][7] = Rook.new("black", self, [0,7])

    @rows[6].each_with_index { |col, i| @rows[6][i] = Pawn.new("white", self, [6,i]) }
    @rows[7][0] = Rook.new("white", self, [7,0])
    @rows[7][1] = Knight.new("white", self, [7,1])
    @rows[7][2] = Bishop.new("white", self, [7,2])
    @rows[7][3] = Queen.new("white", self, [7,3])
    @white_king = King.new("white", self, [7,4])
    @rows[7][4] = @white_king
    @rows[7][5] = Bishop.new("white", self, [7,5])
    @rows[7][6] = Knight.new("white", self, [7,6])
    @rows[7][7] = Rook.new("white", self, [7,7])
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @rows[row][col] = val
  end

  def move_piece(color, start_pos, end_pos)
    raise "Start position is out of bounds" if !valid_pos?(start_pos)
    raise "End position is out of bounds" if !valid_pos?(end_pos)
    raise "Start position is empty" if self[start_pos] == @null_piece
    raise "End position contains own piece" if color == self[end_pos].color

    # puts "Moving (#{color} #{self[start_pos].symbol}) #{start_pos} to #{end_pos}"
    self[end_pos], self[start_pos] = self[start_pos], @null_piece

    self[end_pos].pos = end_pos
    raise "Cannot move into check" if in_check?(color) 
  end

  # For use with duped board for lookahead
  def move_piece!(color, start_pos, end_pos)
    raise "Start position is out of bounds" if !valid_pos?(start_pos)
    raise "End position is out of bounds" if !valid_pos?(end_pos)
    raise "Start position is empty" if self[start_pos] == @null_piece
    raise "End position contains own piece" if color == self[end_pos].color

    self[end_pos], self[start_pos] = self[start_pos], self[end_pos]

    self[end_pos].pos = end_pos
  end

  def valid_pos?(pos)
    pos[0] >= 0 && pos[0] <= 7 && pos[1] >= 0 && pos[1] <= 7
  end

  def in_check?(color)
    @rows.any? do |row|
      row.any? do |col|
        if color == "white"
          col.moves.include?(@white_king.pos)
        else
          col.moves.include?(@black_king.pos)
        end
      end
    end
  end

  def checkmate?(color)
    @rows.each do |row|
      row.each do |col|
        return false if !col.valid_moves.empty? && col.color == color
      end
    end
    in_check?(color)
  end

end
