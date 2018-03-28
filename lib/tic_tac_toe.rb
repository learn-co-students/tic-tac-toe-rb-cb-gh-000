WIN_COMBINATIONS=[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i-1
end

def move(board,position,player_token)
  board[position]=player_token
end

def position_taken?(board,position)
  taken=false
  if board[position]==" "||board[position]==""||board[position]==nil
    taken=false
  else
    taken=true
  end
  return taken
end

def valid_move?(board,position)
  if !position_taken?(board,position)&&position.between?(0,8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "input your number : "
  input=gets
  position=input_to_index(input)
  if valid_move?(board,position)
    move(board,position,"X")
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count=0
  board.each do |board|
    if board=="X"||board=="O"
      count+=1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |winCombinationArray|
    if board[winCombinationArray[1]]==board[winCombinationArray[2]]&&board[winCombinationArray[2]]==board[winCombinationArray[3]]
      return true
    end
  end
  return false
end

def full?(board)
  if !won?(board)&&turn_count(board)==9
    return true
  else
    return false
  end
end

def draw?(board)
  if !won?(board)&&full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board)||won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |winCombinationArray|
    winCombinationArray.each do|eachWinCombinationArray|

    end
  end
end
