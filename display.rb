require "colorize"
require_relative "cursor"
require_relative "board"

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([6,4], @board)
  end

  def render
    puts "+======================================+"
    puts "|            ACADEMY CHESS             |"
    puts "|     - A Battle as Old as Time -      |"
    # puts "|  - Trouble in the Animal Kingdom -   |"
    # puts "|    - They are the Real Monsters -    |"
    puts "+======================================+"

    x, y = @cursor.cursor_pos

    puts "| Cursor: [#{(("a".."h").to_a[y])}#{(8-x)}]     ||     White's Turn |"
    puts "+======================================+\n\n"
    code_notation = false
    puts code_notation ? "           #{("0".."7").to_a.join(" ")}  " : "             #{("a".."h").to_a.join(" ")}"

    @board.rows.each_with_index do |row, i|
      print code_notation ? "         #{(i)} " : "           #{(8-i)} "
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

    # puts code_notation ? "           #{("0".."7").to_a.join(" ")}  " : "  #{("a".."h").to_a.join(" ")}"
  end
  
end
