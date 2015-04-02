load 'piece.rb'
board = Board.new
p = Piece.new(board, :white, [7,1],false)
board[[7,1]] = p
p.perform_jump([5,3])
