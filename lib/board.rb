class Board
  attr_reader :board

  def initialize
    @board = Array.new(6) { Array.new(7, nil) }
  end

  def drop_token(token, col)
    row = @board.length - 1
    row -= 1 until @board[row][col].nil?
    @board[row][col] = token
  end

  def valid_move?(col)
    return false unless @board[0][col].nil?

    true
  end
end
