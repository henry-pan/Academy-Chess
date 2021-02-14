require "colorize"
require_relative "cursor"
require_relative "board"

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([6,4], @board)
  end

  def render(color)
    x, y = @cursor.cursor_pos
    message = "#{color.capitalize}'s Turn"
    puts "+===================++=================+"
    puts "| Classic Mode      ||            [#{(("a".."h").to_a[y])}#{(8-x)}] |"
    puts "+======================================+"
    puts "| #{message}                         |"
    puts "+======================================+\n\n"
    
    # puts "             #{("a".."h").to_a.join(" ")}" # Emoji Skin
    puts "              #{("a".."h").to_a.join("  ")}" # Classic Skin
    @board.rows.each_with_index do |row, i|
      print "           #{(8-i)} "
      row.each_with_index do |col, j|
        if col.color == "white"
          if [x, y] == [i, j]
            print "#{col.to_s}".white.on_red
          else
            bg = (i+j).odd? ? :light_blue : :blue
            print "#{col.to_s}".colorize({background: bg, color: :white})
          end
        else
          if [x, y] == [i, j]
            print "#{col.to_s}".black.on_red
          else
            bg = (i+j).odd? ? :light_blue : :blue
            print "#{col.to_s}".colorize({background: bg, color: :black})
          end
        end
      end
      # print code_notation ? "#{(i)}" : "#{(8-i)}"
      puts ""
    end
    puts ""
    # puts code_notation ? "           #{("0".."7").to_a.join(" ")}  " : "  #{("a".."h").to_a.join(" ")}"
  end
  
end
