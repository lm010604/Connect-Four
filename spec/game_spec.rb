require './lib/game'

describe Game do
  describe '#initialize' do
    it 'creates two players and a board' do
      game = Game.new('Lauren', 'AI')
      expect(game.player1.name).to eq('Lauren')
      expect(game.player2.name).to eq('AI')
      expect(game.board).to be_a(Board)
    end

    it 'sets current_player to player1' do
      game = Game.new
      expect(game.current_player).to eq(game.player1)
    end
  end

  describe '#win? and #tie?' do
    it 'returns true for a vertical win' do
      game = Game.new
      player1 = game.current_player
      game.play_round(0)
      game.play_round(1)
      game.play_round(0)
      game.play_round(2)
      game.play_round(0)
      game.play_round(3)
      game.play_round(0)
      expect(game.win?(player1)).to eql(true)
    end

    it 'returns true for a horizontal win' do
      game = Game.new
      player = game.current_player
      4.times do |col|
        game.play_round(col)
        game.play_round(6) unless col == 3 # block opponent in a safe column
      end
      expect(game.win?(player)).to be(true)
    end

    it 'returns true for a descending diagonal win using play_round' do
      game = Game.new
      player = game.current_player
      game.play_round(0)
      game.play_round(1)
      game.play_round(1)
      game.play_round(2)
      game.play_round(2)
      game.play_round(3)
      game.play_round(2)
      game.play_round(3)
      game.play_round(2)
      game.play_round(3)
      game.play_round(3)
      game.play_round(4)
      game.play_round(3)
      expect(game.win?(player)).to be(true)
    end

    it 'returns true for an ascending diagonal win' do
      game = Game.new
      player = game.current_player
      game.play_round(3) # X
      game.play_round(2) # O
      game.play_round(2) # X
      game.play_round(1) # O
      game.play_round(1) # X
      game.play_round(0) # O
      game.play_round(1) # X
      game.play_round(0) # O
      game.play_round(0) # X
      game.play_round(4) # O
      game.play_round(0) # X
      expect(game.win?(player)).to be(true)
    end

    it 'return false for a non-winning scattered board' do
      game = Game.new
      game.play_round(0)
      game.play_round(1)
      game.play_round(2)
      game.play_round(3)
      game.play_round(4)
      game.play_round(5)
      expect(game.win?(game.player1)).to eql(false)
      expect(game.win?(game.player2)).to eql(false)
    end

    it 'returns false for a full board tie' do
      game = Game.new('P1', 'P2')
      tie_pattern = [
        [1, 0, 1, 0, 1, 0, 1],
        [0, 1, 0, 1, 0, 1, 0],
        [1, 0, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 0, 1],
        [0, 1, 0, 1, 0, 1, 0],
        [1, 0, 1, 0, 1, 0, 1],
        [0, 1, 0, 1, 0, 1, 0]
      ]

      tie_pattern.each_with_index do |row, r|
        row.each_with_index do |value, c|
          token = value.zero? ? game.player1.token : game.player2.token
          game.board.board[5 - r][c] = token
        end
      end

      expect(game.tie?).to be(true)
      expect(game.win?(game.player1)).to be(false)
      expect(game.win?(game.player2)).to be(false)
    end
    it 'returns false if any cell is empty' do
      game = Game.new
      expect(game.tie?).to be(false)
    end
  end
  describe '#switch_player' do
    it 'switches from player1 to player2 and back' do
      game = Game.new
      expect(game.current_player).to eq(game.player1)
      game.switch_player
      expect(game.current_player).to eq(game.player2)
      game.switch_player
      expect(game.current_player).to eq(game.player1)
    end
  end
  describe '#play_round' do
    it 'places current player token and switches player if valid' do
      game = Game.new
      current = game.current_player
      game.play_round(0)
      expect(game.board.board[5][0]).to eq(current.token)
      expect(game.current_player).not_to eq(current)
    end

    it 'does not switch player if move is invalid' do
      game = Game.new
      6.times { game.play_round(0) }
      current = game.current_player
      game.play_round(0)
      expect(game.current_player).to eq(current)
    end
  end
end
