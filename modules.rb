module Slideable
  attr_reader :moves

  HORIZONTAL_DIRS = [[0,1],[0,-1],[1,0],[-1,0]]
  DIAGONAL_DIRS = [[1,1],[-1,-1],[1,-1],[-1,1]]

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    slide_moves = []    
    move_dirs.each do |dir|
      dx, dy = dir 
      slide_moves += grow_unblocked_moves_in_dir(dx, dy)
    end
    slide_moves
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    unblocked_moves = []
    current_pos = self.pos

    i = current_pos[0] + dx
    j = current_pos[1] + dy
    while i >= 0 && i <= 7 && j >= 0 && j <= 7 
      if @board[[i, j]].is_a?(NullPiece)  
        unblocked_moves << [i, j]
      elsif @board[[i, j]].color != self.color
        unblocked_moves << [i, j]
        break
      else
        break
      end
      i += dx  
      j += dy
    end
    unblocked_moves
  end

end

module Stepable

  def moves
    steps_moves = []
    current_pos = self.pos

    move_diffs.each do |diff|
      i = current_pos[0] + diff[0]
      j = current_pos[1] + diff[1]
      if i >= 0 && i <= 7 && j >= 0 && j <= 7 
        if @board[[i, j]].is_a?(NullPiece)  
          steps_moves << [i, j]
        elsif @board[[i, j]].color != self.color
          steps_moves << [i, j]
        end
      end
    end

    steps_moves
  end

end
