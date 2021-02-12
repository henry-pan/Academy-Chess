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
    # puts "|            ACADEMY CHESS             |"
    # puts "|           - Classic Mode -           |"
    # puts "|            - Horde Mode -            |"
    # puts "|           - Fantasy Mode -           |"
    puts "+======================================+"
    puts "| #{message}                         |"
    puts "+======================================+\n\n"
    
    puts "             #{("a".."h").to_a.join(" ")}"

    @board.rows.each_with_index do |row, i|
      print "           #{(8-i)} "
      row.each_with_index do |col, j|
        if col.color == "white"
          if [x, y] == [i, j]
            print "#{col.to_s}".light_white.on_red
          else
            print "#{col.to_s}".light_white
          end
        else
          if [x, y] == [i, j]
            print "#{col.to_s}".green.on_red
          else
            print "#{col.to_s}".green
          end
        end
        print " "
      end
      # print code_notation ? "#{(i)}" : "#{(8-i)}"
      puts ""
    end
    puts ""
    # puts code_notation ? "           #{("0".."7").to_a.join(" ")}  " : "  #{("a".."h").to_a.join(" ")}"
  end
  
end
