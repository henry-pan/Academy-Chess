require_relative "display"
require_relative "player"

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player_1 = HumanPlayer.new("white", @display)
    @player_2 = HumanPlayer.new("black", @display)
    @current_player = @player_1
  end

  def main_menu
    input_invalid = true
    while input_invalid
      system("clear")
      puts "+======================================+"
      puts "|   Welcome to Academy Chess           |"
      puts "|      -- Henry Pan, Michael Dean --   |"
      puts "+======================================+\n\n"
      puts "- Select game mode:"
      puts "  - \"classic\" for regular chess"
      puts "  - \"horde\" for horde chess"
      puts "  - \"replay\" to watch a replay"
      puts "  - \"quit\" to exit\n\n"
      print "> "

      input = gets.chomp
      case input
      when "c", "h", "classic", "horde"
        mode = input
        input_invalid = false
        system("clear")
        play
      when "replay"
        puts "Replay feature not yet available."
        sleep(2)
      when "quit"
        puts "Goodbye.\n\n"
        sleep(2)
        system("clear")
        return
      else
        puts "\nInvalid game mode! Please try again."
        sleep(2)
      end
    end
  end


  def play
    while !@board.checkmate?(@current_player.color)
      @current_player.make_move(@board)
      swap_turn!
    end
    system("clear")
    swap_turn!
    @display.render(@current_player.color)
    puts "Congratulations, #{@current_player.color}, you win!"
  end

  private
  def swap_turn!
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

end

g = Game.new
g.main_menu
