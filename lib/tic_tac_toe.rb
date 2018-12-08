def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  index = index.strip.to_i - 1
  return index
end
def move(board,index,value)
  board[index]=value
end

def position_taken?(board,index)
  return !(board[index].nil? || board[index]==" ")
end

def valid_move?(board,index)
  return !(index>8 || index < 0 || position_taken?(board,index))
end

def turn(board)
  puts "Please enter 1-9"
  input = gets.strip
  input = input_to_index(input)
  if(valid_move?(board,input))
    value=current_player(board)
    move(board,input,value)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter=0
  board.each do |value|
    if(value=="X" || value=="O")
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  counter = turn_count(board)
  if(counter%2==0)
    return "X"
  else
    return "O"
  end
end

WIN_COMBINATIONS=[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]
def won?(board)
  WIN_COMBINATIONS.each do |win_cobination|
    if((board[win_cobination[0]]=="X" && board[win_cobination[1]]=="X" && board[win_cobination[2]]=="X") || (board[win_cobination[0]]=="O" && board[win_cobination[1]]=="O" && board[win_cobination[2]]=="O"))
      return win_cobination
    end
  end
  return false
end

def full?(board)
  board.all? { |e| (e=="X" || e=="O")  }
end

 def draw?(board)
   return (!won?(board) && full?(board))
end

def over?(board)
  return (won?(board) || full?(board) || draw?(board))
end

def winner(board)
  win_cobination = won?(board)
  if(win_cobination)
    return board[win_cobination[0]]
  end
end
def play(board)
  until over?(board) do
    turn(board)
  end
  if(draw?(board))
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
