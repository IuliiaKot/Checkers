require './board'
LATTER_HASH = {
   "a" => 0,
   "b" => 1,
   "c" => 2,
   "d" => 3,
   "e" => 4,
   "f" => 5,
   "g" => 6,
   "h" => 7,

   "1" => 7,
   "2" => 6,
   "3" => 5,
   "4" => 4,
   "5" => 3,
   "6" => 2,
   "7" => 1,
   "8" => 0
 }

class Game

  def initialize
    @board = Board.startig_board
  end

  def play
   color = :white
   loop do
     @board.print_board

     input_loop(color)
     color = switch_color(color)
   end
 end

 def switch_color(color)
   color == :white ? :black : :white
 end

 def input_loop(color)
   moved = false
   p "here"
   until moved
     puts "#{color.to_s.capitalize}'s turn to move."
     from_pos, to_pos = get_move
     print " from_pos #{from_pos}"
     print " to_pos #{to_pos}"
     moved = @board.make_legal_move(from_pos, to_pos, color)
   end
 end

 def get_move
   puts "Enter a move "
   from_position, to_position = gets.chomp.split(":")
   from_col = LATTER_HASH[from_position[0]]
   from_row = LATTER_HASH[from_position[1]]
   to_col = LATTER_HASH[to_position[0]]
   to_row = LATTER_HASH[to_position[1]]

   [[from_row,from_col],[to_row,to_col]]
 end

 def print_board
   @board.print_board
 end
end
