load 'piece.rb'
board = Board.new
p = Piece.new(board, :white, [7,1],false)
board[[7,1]] = p
p1 = Piece.new(board, :black, [6,2],false)
board[[6,2]] = p1
p.perform_jump([5,3])
