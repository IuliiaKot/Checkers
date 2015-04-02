require './piece'
class Board

  WHITE_BLACK = {white: '⚪', black: "⚫" }
  attr_reader :board

  def initialize
    @board = Array.new(8) {Array.new(8)}
  end

  def [](pos)
    i, j = pos
    board[i][j]
  end

  def []=(pos, value)
    i, j = pos
    board[i][j] = value
  end

  def self.startig_board
    board = Board.new
    (1..7).each do |i|
      board[[0,i]] = Piece.new(board, :black, [0,i], false) if i % 2 != 0
      board[[2,i]] = Piece.new(board, :black, [1,i], false) if i % 2 != 0
      board[[6,i]] = Piece.new(board, :white, [6,i], false) if i % 2 != 0
    end
    (0..7).each do |i|
      board[[1,i]] = Piece.new(board, :black, [1,i], false) if i % 2 == 0
      board[[5,i]] = Piece.new(board, :white, [0,i], false) if i % 2 == 0
      board[[7,i]] = Piece.new(board, :white, [0,i], false) if i % 2 == 0
    end

    board
  end

  def valid_move(to_pos)
    to_pos[0].between?(0,7) && to_pos[1].between?(0,7)
  end

  def move(from_pos, to_pos, color)
    p "now i am here"
    p self[from_pos].pos
    if self[from_pos].color == color
      self[from_pos].move(to_pos)
      self[from_pos], self[to_pos] = nil, self[from_pos]
      true
    else
      false
    end
  end

  def print_board
    print_letter
    board.each_with_index do |row, row_number|
      print "\n"
      print ((row_number - 8).abs).to_s + " "
      row.each do |square|

        print WHITE_BLACK[square.color] if square
        print "_" if square.nil?
        print " "
      end
    end
    print "\n"
    print_letter
    print "\n\n"
    nil
  end

  def print_letter
    print " "
    letters = ("a".."h").each do |letter|
      print " #{letter}"
    end
  end

  def move_puts_player_in_check?(from_pos, to_pos, color)
    p "check"
    p from_pos
    p to_pos
    board_copy = self.dup
    board_copy.print_board
    board_copy.move(from_pos, to_pos, color)
    board_copy.print_board
  end

  def make_legal_move(from_pos, to_pos, color)
    p "MAKE LEAGAL MOVE"
    p from_pos
    p to_pos
    if move_puts_player_in_check?(from_pos, to_pos, color)
      return false
    else
      self.move(from_pos, to_pos, color)
      true
    end
  end

   def dup
     new_board = Board.new

     self.board.each_with_index do |row,row_i|
       row.each_with_index do |square,col_i|
         unless square.nil?
           p "try"
           p board[row_i, col_i].color
           new_board[[row_i, col_i]] = Piece.new(board, board[[row_i, col_i]].color, board[[row_i, col_i]].pos, board.king)
         end
       end
     end

     new_board
   end


end
