WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,4,8], # Right diagonal
  [2,4,6], # Left diagonal
  [0,3,6], # Left column
  [1,4,7], # Center column
  [2,5,8]  # Right column
]

def display_board(board)
  table=Array.new()
  table << " #{board[0]} | #{board[1]} | #{board[2]} "
  table.push("-----------")
  table.push(" #{board[3]} | #{board[4]} | #{board[5]} ")
  table.push("-----------")
  table.push(" #{board[6]} | #{board[7]} | #{board[8]} ")
  for i in table
    puts i
  end
end

def input_to_index(index)
  return index.to_i - 1
end

def move(board,index,player)
  board[index]=player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if index > board.length() || index < 0
    return false
  else
    return !position_taken?(board,index)
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index=input_to_index(gets.strip)

  if valid_move?(board,index)==false
    puts "Index move not valid."
    turn(board)
  else
    move(board,index,current_player(board))
  end

  display_board(board)
end

def turn_count(board)
  cont=0
  board.each do |var|
    if var==" "
      cont+=1
    end
  end
  return 9 - cont
end

def current_player(board)
  num=turn_count(board)
  if num.even?
    return "X"
  end
  return "O"
end

def won?(board)
  res = nil
  WIN_COMBINATIONS.each do |combination|
    winX=combination.all? do |index|
      board[index].eql?("X")
    end
    winO=combination.all? do |index|
      board[index].eql?("O")
    end

    if winX==true || winO==true
      res = combination
    end

  end

  return res
end

def full?(board)
  !board.any? do |var|
    var.eql?(" ")
  end
end

def draw?(board)
  if full?(board)==true and won?(board)==nil
    return true
  end

  return false
end

def over?(board)
  full?(board)||won?(board)||draw?(board)
end

def winner(board)
  player=won?(board)

  if player == nil
    return nil
  else
    board[player[0]]
  end
end

def play(board)
  while over?(board)==false
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
