require_relative './display_board.rb'
require_relative './move.rb'
require_relative './valid_move.rb'
require_relative './current_player.rb'

def turn(board)
  puts "#{current_player(board)}, please enter 1-9:"
  index = input_to_index(gets.strip)
  until valid_move?(board, index)
    puts "#{current_player(board)}, please enter 1-9:"
    index = input_to_index(gets.strip)
  end
  move(board, index, current_player(board))
  display_board(board)
end
