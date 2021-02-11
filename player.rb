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
    start_pos = nil
    while start_pos == nil
      system("clear")
      @display.render
      puts "-- #{color.capitalize}, it's your move! -- "
      puts "Use the arrow keys to select a piece, and press enter to move."
      start_pos = @display.cursor.get_input.dup
    end

    end_pos = nil
    while end_pos == nil
      system("clear")
      @display.render
      puts "-- #{color.capitalize}, it's your move! -- "
      puts "Select a new position for this piece using the arrow keys."
      end_pos = @display.cursor.get_input.dup
    end

    # Text input
      # input = gets.chomp.split(" ").map(&:to_i)
      # start_pos = [input[0], input[1]]
      # end_pos = [input[2], input[3]]
    board.move_piece(@color, start_pos, end_pos)
  end

end