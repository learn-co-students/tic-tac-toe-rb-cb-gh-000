def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board,index)
  if index.between?(0,8)
    return !position_taken?(board,index)
  end
  false
end

def position_taken?(board,index)
  temp=board[index]
  if temp==" "||temp==""||temp==nil
    return false
  end
  true
end

def move(board,index,token)
  board[index]=token
end

def input_to_index(index)
  index.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  index=input_to_index(gets.strip)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count=0
  board.each do |item|
    if item == "X" || item == "O"
      count+=1
    end
  end
  count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  end
  "O"
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2],
  [0,3,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if (board[combo[0]]=="X" && board[combo[1]]=="X" && board[combo[2]]=="X") || (board[combo[0]]=="O" && board[combo[1]]=="O" && board[combo[2]]=="O")
      return combo
    end
  end
  false
end

def full?(board)
  board.all? { |i| i=="X" || i=="O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  !!won?(board)||full?(board)||draw?(board)
end

def winner(board)
  if !won?(board)
    return nil
  end
  board[won?(board)[0]]
end

def play(board)
  until over?(board)
    turn(board)
  end

  if !!won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end
