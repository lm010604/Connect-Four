require_relative '../lib/game'
require_relative '../main/console_display'

puts '🎲 Welcome to Connect Four!'
puts "Enter player 1's name:"
player1 = gets.chomp
puts "Enter player 2's name:"
player2 = gets.chomp
game = Game.new(player1, player2)
display = ConsoleDisplay.new(game.board)
display.render
until game.win?(game.player1) || game.win?(game.player2) || game.tie?
  puts "#{game.current_player.name}'s turn"
  puts 'Enter the column you wish to drop a token in:'
  input = gets.chomp.to_i
  game.play_round(input - 1)
  display.render
end
if game.win?(game.player1) || game.win?(game.player2)
  puts "#{game.current_player.name} wins!"
elsif game.tie?
  puts "It's a tie!"
end
