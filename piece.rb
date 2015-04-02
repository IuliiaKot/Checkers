class Piece

  LEGAL_MOVE = [[-1, 1],[-1, -1],[1, 1],[1, -1]]
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
      return true if board[to_pos].nil?
    end
    false
  end

  def perform_jump(to_pos)
    current_x = pos[0]
    current_y = pos[1]
    return false unless legal_move?(to_pos)
    return false unless check_next_square?(to_pos)
    if (to_pos[0] - current_x).abs == 2 &&  (to_pos[1] - current_y).abs == 2
      return true if board[to_pos].nil?
    end
    false
  end

  def legal_move?(to_pos)
    board.valid_move(to_pos)
  end

  def check_next_square?(to_pos)
    if direction(to_pos) == :right && diff(to_pos) == :up
      next_x, next_y = pos[0] - 1, pos[1] + 1
    elsif direction(to_pos) == :left && diff(to_pos) == :up
      next_x, next_y = pos[0] -1, pos[1] - 1
    elsif direction(to_pos) == :right && diff(to_pos) == :down
      next_x, next_y = pos[0] + 1, pos[1] + 1
    elsif direction(to_pos) == :left && diff(to_pos) == :down
      next_x, next_y = pos[0]  + 1, pos[1] - 1
    end
    return false if board[[next_x, next_y]].nil?
    return false if board[[next_x, next_y]].color == color
    return true
  end

  def direction(to_pos)
    x = pos[1]
    if x > to_pos[1]
      return :left
    else
      return :right
    end
  end

  def diff(to_pos)
    if pos[0] > to_pos[0]
      return :up
    else
      return :down
    end
  end


  def valid_move

    if perform_jump(to_pos)
      return true
    elsif perform_jump(to_pos)
      return ture
    else
      return false
    end
  end

  def move(to_pos)
    current_pos = pos
    p "current_pos #{current_pos}"
    p to_pos
    if valid_move(to_pos)
      current_pos = to_pos
    else
      raise "Invalid move"
    end
  end

  def perform_moves!(move_sequence)
    if move_sequence.length == 0
      if !perform_slide(move_sequence)
        perform_jump(move_sequence)
      end
    end
    move_sequence.each do |square|
      move(square)
    end

  end

  def valid_mov_seq?(move_sequence)
    move_sequaence.each do |square|
      next if check_next_square?(square)
      return true
    end
    return false
  end

  def perform_move(move_sequence)
    if valid_mov_seq?(move_sequence)
      perform_moves!(move_sequence)
  end
end
