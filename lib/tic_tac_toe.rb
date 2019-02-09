
def play(board)
  while !over?(board)
    return turn(board)
  end
  if winner(board) == true
    puts "Congratulation #{winner(board)!}"
  else
    if draw?(board)
      puts "Draw game!"
    end
  end
end
