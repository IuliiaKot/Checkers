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
      board[[0,i]] = Piece.new(board, :white, [0,i], false) if i % 2 != 0
      board[[2,i]] = Piece.new(board, :white, [1,i], false) if i % 2 != 0
      board[[6,i]] = Piece.new(board, :black, [6,i], false) if i % 2 != 0
    end
    (0..7).each do |i|
      board[[1,i]] = Piece.new(board, :white, [1,i], false) if i % 2 == 0
      board[[5,i]] = Piece.new(board, :black, [0,i], false) if i % 2 == 0
      board[[7,i]] = Piece.new(board, :black, [0,i], false) if i % 2 == 0
    end

    board
  end

  def valid_move(to_pos)
    to_pos[0].between?(0,7) && to_pos[1].between?(0,7)
  end

  def move(from_pos, to_pos, color)
    if self[from_pos] && self[from_pos].color == color
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


  def make_leagal_move(from_pos, to_pos, color)
      self.move(from_pos, to_pos, color)
  end

end
