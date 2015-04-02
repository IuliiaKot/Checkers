class Piece
  attr_accessor :board, :pos, :color

  def initialize(board, color, pos, king = false)
    @board = board
    @color = color
    @pos = pos
    @king = king
  end

  def perform_slide(to_pos)
    current_x = pos[0]
    current_y = pos[1]

    return false unless legal_move?(to_pos)
    if (to_pos[0] - current_x).abs == 1 &&  (to_pos[1] - current_y).abs == 1
      if board[to_pos].nil?
        return true
      else
        return false
      end
    end
    false
  end

  def perform_jump(to_pos)
    current_x = pos[0]
    current_y = pos[1]
    return false unless legal_move?(to_pos)
    return false unless check_next_squre?(to_pos)
    if (to_pos[0] - current_x).abs == 2 &&  (to_pos[1] - current_y).abs == 2
      if board[to_pos].nil?
        return true
      else
        return false
      end
    end
    false
  end

  def legal_move?(to_pos)

    if to_pos[0].between?(0,7) &&  to_pos[1].between?(0,7)
      return true
    else
      return false
    end
  end

  def check_next_squre?(to_pos)
    if direction(to_pos) == :right
      next_x, next_y = pos[0] - 1, pos[1] + 1
      return false if board[[next_x, next_y]].nil?
      return false if board[[next_x, next_y]].color == color
    else
      next_x, next_y = pos[0] -1, pos[1] - 1
      return false if board[[next_x, next_y]].nil?
      return false if board[[next_x, next_y]].color == color

    end
    true
  end

  def direction(to_pos)
    x = pos[1]
    if x > to_pos[1]
      return :left
    else
      return :right
    end
  end
end

class Board
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

  end

  def move(from_pos, to_pos, color)

  end

end
