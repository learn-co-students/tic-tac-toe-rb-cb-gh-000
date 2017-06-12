# count the number of turns that have been taken by each Player
def turn_count(board)
  turns = 0;
  board.each do | cell |
    if cell == "X" || cell == "O"
      turns += 1
    end
  end
  turns
end
