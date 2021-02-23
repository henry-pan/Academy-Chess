require "colorize"
require_relative "cursor"
require_relative "board"

class Display

  attr_reader :board, :cursor

  CLASSIC_B = {rook:" ♜ ", knight:" ♞ ", bishop: " ♝ ", queen: " ♛ ", king: " ♚ ", pawn: " ♟ ", null: "   "}
  CLASSIC_W = {rook:" ♖ ", knight:" ♘ ", bishop: " ♗ ", queen: " ♕ ", king: " ♔ ", pawn: " ♙ ", null: "   "}
  ANIMAL_B =  {rook:"🦊", knight:"🐰", bishop: "🦝", queen: "🐿 ", king: "🦥", pawn: "🐭", null: "  "}
  ANIMAL_W =  {rook:"🦏", knight:"🐴", bishop: "🐻", queen: "🐯", king: "🦁", pawn: "🐗", null: "  "}
  FANTASY_B = {rook:"👹", knight:"👻", bishop: "🦹", queen: "🐉", king: "🧛", pawn: "🧟", null: "  "}
  FANTASY_W = {rook:"🏰", knight:"🦄", bishop: "🧙", queen: "👸", king: "🤴", pawn: "🗡️ ", null: "  "}

  def initialize(board)
    @board = board
    @cursor = Cursor.new([6,4], @board) # Starts with a common opening
  end

  def render(color, selected_piece = nil)
    skin = "animal"
    x, y = @cursor.cursor_pos
    message = "#{color.capitalize}'s Turn"
    
    valid_arr = selected_piece.nil? ? [] : selected_piece.valid_moves
    
    if valid_arr.empty?
      coordinates = "[#{(("a".."h").to_a[y])}#{(8-x)}]".rjust(15)
    else
      sx, sy = selected_piece.pos[0], selected_piece.pos[1]
      coordinates = "[#{(("a".."h").to_a[sy])}#{(8-sx)}] -> [#{(("a".."h").to_a[y])}#{(8-x)}]".rjust(15)
    end


    # puts "+===================++=================+"
    # puts "| Classic Mode      || #{coordinates} |"
    # puts "+======================================+"
    # puts "| #{message}                         |"
    # puts "+======================================+\n\n"
    
    # if skin == "classic"
    #   puts "              #{("a".."h").to_a.join("  ")}" # Classic Skin
    # else
    #   puts "             #{("a".."h").to_a.join(" ")}" # Emoji Skin
    # end

    print "+===================+"
    if skin == "classic"
      print "    #{("a".."h").to_a.join("  ")}" # Classic Skin
    else
      print "   #{("a".."h").to_a.join(" ")}" # Emoji Skin
    end
    puts ""


    # Print board
    @board.rows.each_with_index do |row, i|

      case i
      when 0 # Game Mode
        print "| Classic Mode      |"
      when 1, 3, 5, 7 # Divider
        print "+===================+"
      when 6 # Position
        print "|   #{coordinates} |"
      when 2 # Turn Indicator
        print "| #{message}      |"
      else
        print "                     "
      end
      print " #{(8-i)} "

      # print "           #{(8-i)} "
      row.each_with_index do |col, j|

        # New print logic
        piece = draw_piece(col.symbol, col.color, skin)
        if valid_arr.include?([i, j]) # Valid positions for piece
          bg = (i+j).odd? ? :green : :light_green
          bg = :yellow if [x, y] == [i, j]
          print piece.colorize({background: bg, color: :black})
        elsif [x, y] == [i, j] # Cursor selected
          print piece.black.on_red
        else
          bg = (i+j).odd? ? :light_black : :light_white
          print piece.colorize({background: bg, color: :black})
        end

      end
      # print code_notation ? "#{(i)}" : "#{(8-i)}"
      puts ""
    end
    puts ""
    # puts code_notation ? "           #{("0".."7").to_a.join(" ")}  " : "  #{("a".."h").to_a.join(" ")}"
  end

  # Returns a string that can be colorized as needed.
  def draw_piece(sym, color, skin)
    case skin
    when "classic"
      skin_w, skin_b = CLASSIC_W, CLASSIC_B
    when "animal"
      skin_w, skin_b = ANIMAL_W, ANIMAL_B
    when "fantasy"
      skin_w, skin_b = FANTASY_W, FANTASY_B
    end
    color == "white" ? skin_w[sym] : skin_b[sym]
  end
end
