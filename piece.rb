require "singleton"
require_relative "modules"

class Piece

  attr_reader :color, :board, :symbol
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    empty? ? " " : symbol
  end

  def empty?
    self.is_a?(NullPiece)
  end

  def valid_moves
    valid = []
    moves.each { |move| valid << move if !move_into_check?(move) }
    valid
  end

  private
  def move_into_check?(end_pos)
    new_copy = Marshal.load(Marshal.dump(@board))
    new_copy.move_piece!(@color, @pos, end_pos)
    new_copy.in_check?(@color)
  end

end

class NullPiece < Piece

  include Singleton
  
  attr_reader :moves, :symbol

  def initialize
    @moves = []
    @symbol = :null
  end

end

class Queen < Piece

  include Slideable
  
  attr_reader :symbol 

  def initialize(color, board, pos)
    super(color, board, pos)
    @symbol = :♛
  end

  def move_dirs  
    diagonal_dirs + horizontal_dirs
  end

end

class Rook < Piece

  include Slideable
  
  attr_reader :symbol 

  def initialize(color, board, pos)
    super(color, board, pos)
    @symbol = :♜
  end

  def move_dirs  
    horizontal_dirs
  end

end

class Bishop < Piece

  include Slideable

  attr_reader :symbol  

  def initialize(color, board, pos)
    super(color, board, pos)
    @symbol = :♝
  end

  def move_dirs
    diagonal_dirs
  end

end

class Knight < Piece

  include Stepable

  def initialize(color, board, pos)
    super(color, board, pos)
    @symbol = :♞
  end

  attr_reader :symbol  

  def move_diffs
    [
      [-2,-1],
      [-2, 1],
      [-1,-2],
      [-1, 2],
      [ 1,-2],
      [ 1, 2],
      [ 2,-1],
      [ 2, 1]
    ]
  end

end

class King < Piece

  include Stepable

  attr_reader :symbol  

  def initialize(color, board, pos)
    super(color, board, pos)
    @symbol = :♚
  end

  def move_diffs
    [
      [-1,-1],
      [-1, 0],
      [-1, 1],
      [ 0, 1],
      [ 0,-1],
      [ 1,-1],
      [ 1, 0],
      [ 1, 1]
    ]
  end

end

class Pawn < Piece

  attr_reader :symbol

  def initialize(color, board, pos)
    super(color, board, pos)
    @symbol = :♟
  end

  def moves
    forward_steps + side_attacks
  end

  private
  def at_start_row?
    if color == "white" && pos[0] == 6
      return true
    elsif color == "black" && pos[0] == 1
      return true
    end
    false
  end
  
  def forward_dir
    color == "white" ? -1 : 1
  end

  def forward_steps
    steps = []
    current_pos = self.pos
    i = current_pos[0] + forward_dir
    j = current_pos[1] 

    if at_start_row?
      steps << [i, j] if @board[[i, j]].is_a?(NullPiece)  
      i += forward_dir  
      steps << [i, j] if @board[[i, j]].is_a?(NullPiece) 
    else
      steps << [i, j] if @board[[i, j]].is_a?(NullPiece)
    end

    steps
  end

  def side_attacks
    steps = []
    current_pos = self.pos
    i = current_pos[0] + forward_dir
    j = current_pos[1] 

    steps << [i, j-1] if j-1 >= 0 && !@board[[i, j-1]].is_a?(NullPiece) && @board[[i, j-1]].color != self.color
    steps << [i, j+1] if j+1 <= 7 && !@board[[i, j+1]].is_a?(NullPiece) && @board[[i, j+1]].color != self.color

    steps
  end

end