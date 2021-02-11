require "colorize"
require_relative "cursor"
require_relative "board"

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    puts "========================="
    puts "===       CHESS       ==="
    puts "========================="
    code_notation = true
    puts code_notation ? "  #{("0".."7").to_a.join(" ")}" : "  #{("a".."h").to_a.join(" ")}"
    
    x, y = @cursor.cursor_pos

    @board.rows.each_with_index do |row, i|
      print code_notation ? "#{(i)} " : "#{(8-i)} "
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
      puts ""
    end
  end
  
end
