require './lib/board'

describe Board do
  describe '#board' do
    it 'returns an empty 2D array with 6 rows and 7 columns' do
      board = Board.new
      expect(board.board).to eql(Array.new(6) { Array.new(7) })
    end
  end

  describe '#drop_token' do
    it 'drops a token in the specified empty column' do
      board = Board.new
      board.drop_token('O', 0)
      array = Array.new(6) { Array.new(7) }
      array[-1][0] = 'O'
      expect(board.board).to eql(array)
    end

    it 'drops a token in the specified non-empty column' do
      board = Board.new
      board.drop_token('O', 0)
      board.drop_token('X', 0)
      array = Array.new(6) { Array.new(7) }
      array[-1][0] = 'O'
      array[-2][0] = 'X'
      expect(board.board).to eql(array)
    end
  end

  describe '#valid_move?' do
    it 'returns true if a token can be dropped in the specified column' do
      board = Board.new
      expect(board.valid_move?(0)).to eql(true)
    end

    it 'return false if a token cannot be dropped in the specified column' do
      board = Board.new
      board.drop_token('O', 0)
      board.drop_token('O', 0)
      board.drop_token('O', 0)
      board.drop_token('O', 0)
      board.drop_token('O', 0)
      board.drop_token('O', 0)
      expect(board.valid_move?(0)).to eql(false)
    end
  end
end
