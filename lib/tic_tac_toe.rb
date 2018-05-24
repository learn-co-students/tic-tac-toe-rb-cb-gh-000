def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(x)
  return x.to_i-1
end

def move(board,ind,turn)
  board[ind]=turn
end

def position_taken?(board,position)
  if(board[position]=="X" || board[position]=="O")
    return true
  else
    return false
  end
end

def valid_move?(board,pos)
  position=input_to_index(pos)
  if(position_taken?(board,position))
    return false
  else
    return true
  end
end

def turn_count(board)
count=0
board.each do |tmp|
if(tmp=="X" || tmp=="O")
  count+=1
end
end
return count
end

def current_player(board)
if(turn_count(board)%2==0)
  return "X"
end
return "O"
end

def turn(board)
puts "Please enter 1-9:"
inp=gets.strip
if (!valid_move?(board,inp))
  #turn(board)
  return
end
move(board,input_to_index(inp),current_player(board))
display_board(board)
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
WIN_COMBINATIONS.each do |poss|
  if(board[poss[0]]=="X" && board[poss[1]]=="X" && board[poss[2]]=="X")
    return poss
  end
  if(board[poss[0]]=="O" && board[poss[1]]=="O" && board[poss[2]]=="O")
    return poss
  end
end
return nil
end

def full?(board)
  board.each do |x|
    if(x!="X" && x!="O")
      return false
    end
  end
  return true
end

def draw?(board)
  if(full?(board))
    x=won?(board)
    if(x!=nil)
      return false
    end
    return true
  end
return false
end

def over?(board)
  if(won?(board) || draw?(board))
    return true
  end
  return false
end

def winner(board)
  x=won?(board)
  if(x!=nil)
    return board[x[0]]
  end
  return nil
end

def play(board)

  while(!over?(board))
    turn(board)
  end


  if(winner(board)==nil)
    puts "Cat's Game!"
  end

  if(winner(board)=="X")
    puts "congratulates the winner X"
  else
    puts "congratulates the winner O"
  end

end
