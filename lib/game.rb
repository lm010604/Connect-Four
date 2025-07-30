require_relative 'board'
require_relative 'player'

class Game
  def initialize(name1 = 'Player1', name2 = 'Player2')
    @board = Board.new
    @player1 = Player.new(name1, 'X')
    @player2 = Player.new(name2, 'O')
    @current_player = @player1
  end

  attr_reader :current_player, :player1, :player2, :board

  def win?(player)
    board = @board.board
    token = player.token
    # Horizontal
    board.each do |row|
      (0..3).each do |col|
        return true if row[col, 4].all?(token)
      end
    end

    # Vertical
    (0..6).each do |col|
      (0..2).each do |row|
        return true if (0..3).all? { |i| board[row + i][col] == token }
      end
    end

    # Diagonal (descending)
    (0..2).each do |row|
      (0..3).each do |col|
        return true if (0..3).all? { |i| board[row + i][col + i] == token }
      end
    end

    # Diagonal (ascending)
    (3..5).each do |row|
      (0..3).each do |col|
        return true if (0..3).all? { |i| board[row - i][col + i] == token }
      end
    end
    false
  end

  def tie?
    board = @board.board
    board.all? do |row|
      row.all? { |cell| !cell.nil? }
    end
  end

  def play_round(col)
    placed = @board.valid_move?(col)
    unless placed
      puts 'Invalid move! Try again.'
      return
    end

    @board.drop_token(@current_player.token, col)

    return if win?(@player1) || win?(@player2) || tie?

    switch_player
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
