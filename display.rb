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
    @cursor = Cursor.new([6,4], @board)
  end

  def render(color)
    skin = "animal"
    x, y = @cursor.cursor_pos
    message = "#{color.capitalize}'s Turn"
    puts "+===================++=================+"
    puts "| Classic Mode      ||            [#{(("a".."h").to_a[y])}#{(8-x)}] |"
    puts "+======================================+"
    puts "| #{message}                         |"
    puts "+======================================+\n\n"
    
    if skin == "classic"
      puts "              #{("a".."h").to_a.join("  ")}" # Classic Skin
    else
      puts "             #{("a".."h").to_a.join(" ")}" # Emoji Skin
    end

    # print "+===================+"
    # if skin == "classic"
    #   print "    #{("a".."h").to_a.join("  ")}" # Classic Skin
    # else
    #   print "   #{("a".."h").to_a.join(" ")}" # Emoji Skin
    # end
    # puts ""


    # Print board
    @board.rows.each_with_index do |row, i|

      # case i
      # when 0 # Game Mode
      #   print "| Classic Mode      |"
      # when 1, 3, 5, 7 # Divider
      #   print "+===================+"
      # when 6 # Position
      #   print "| [#{(("a".."h").to_a[y])}#{(8-x)}]              |"
      # when 2 # Turn Indicator
      #   print "| #{message}      |"
      # else
      #   print "                     "
      # end
      # print " #{(8-i)} "

      print "           #{(8-i)} "
      row.each_with_index do |col, j|

        # New print logic
        piece = draw_piece(col.symbol, col.color, skin)
        if [x, y] == [i, j] # Cursor selected
          print piece.on_red
        else
          bg = (i+j).odd? ? :light_blue : :blue
          print piece.colorize({background: bg})
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
      skin_w = CLASSIC_W
      skin_b = CLASSIC_B
    when "animal"
      skin_w = ANIMAL_W
      skin_b = ANIMAL_B
    when "fantasy"
      skin_w = FANTASY_W
      skin_b = FANTASY_B
    end
    color == "white" ? skin_w[sym] : skin_b[sym]
  end
end
