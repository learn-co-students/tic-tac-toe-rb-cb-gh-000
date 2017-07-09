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

def display_board(board=Array.new)
  puts " #{board[0]} "+"|"+" #{board[1]} "+"|"+" #{board[2]} "
  puts "-----------"
  puts " #{board[3]} "+"|"+" #{board[4]} "+"|"+" #{board[5]} "
  puts "-----------"
  puts " #{board[6]} "+"|"+" #{board[7]} "+"|"+" #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board,index,value)
  board[index]=value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if index>=0 && index<=8
    if position_taken?(board,index)
      false
    else
      true
    end
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input=gets
  index=input_to_index(input)
  if index!=-1 && valid_move?(board,index)
      move(board,index,current_player(board))
      display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  counter=0
  board.each do |bd|
    if bd=="X" or bd=="O"
      counter+=1
    end
  end
  counter
end

def current_player(board)
count=turn_count(board)
  if count%2==0
    "X"
  else
    "O"
  end
end

def won?(board)
  f=0
  i=Array.new
  WIN_COMBINATIONS.each do |index|
    win_index_1=index[0]
    win_index_2=index[1]
    win_index_3=index[2]

    position_1=board[win_index_1]
    position_2=board[win_index_2]
    position_3=board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      f=1
      i<<index[0]
      i<<index[1]
      i<<index[2]
      break
    end

  end
  if f!=1
    false
  else
    return  i
  end
end


def full?(board)
  board.all? do |b|
    b == "X" || b == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  p=Array.new
  if won?(board)
    p=won?(board)
    return board[p[0]]
  else
    return nil
  end
end

def play(board)
  p=0
  turn(board)
  while !over?(board) && p<2 do
    turn(board)
    if over?(board) 
      if won?(board)
        p=1
        break
      else
        p=2
      end
    end
  end
  if p<2
    puts "Congratulations " + winner(board) + "!"
  else
    puts "Cats Game!"
  end
end
