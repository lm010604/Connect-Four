require 'colorize'

class ConsoleDisplay
  def initialize(board)
    @board = board
  end

  def render
    puts "\n"
    @board.board.each do |row|
      line = row.map do |cell|
        case cell
        when 'X'
          ' o '.colorize(:red)
        when 'O'
          ' o '.colorize(:blue)
        else
          '   '.colorize(:light_black)
        end
      end.join('|')
      puts "|#{line}|"
    end
    puts '-' * 29
    puts '  1   2   3   4   5   6   7 '
    puts "\n"
  end
end
