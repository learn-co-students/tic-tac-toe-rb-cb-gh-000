require_relative './turn.rb'
require_relative './game_status.rb'
require_relative './current_player'

def play(board)
  until over?(board)
    turn(board)
  end # until #over?
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cats Game!"
  end # if #winner
end # def
