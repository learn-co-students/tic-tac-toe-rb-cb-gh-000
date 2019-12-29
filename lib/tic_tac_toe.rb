WIN_COMBINATIONS =[
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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  current_player = current_player(board)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |v|
    if v == "O" || v == "X"
      counter +=1 
    end
  end
  counter
end

def current_player(board)
  turn_count = turn_count(board)
  if turn_count%2 == 0 
    "X"
  else
    "O"
  end
end

def won?(board)
  counter = 0
  comb=[]
  WIN_COMBINATIONS.each do |c|
    
      if board[c[0]] == 'X' && board[c[1]] == 'X' && board[c[2]] == 'X'
        counter+=1
        comb=c
      elsif board[c[0]] == 'O' && board[c[1]] == 'O' && board[c[2]] == 'O'
        counter+=1
        comb = c
      end
  end
  if counter >= 1 
    return comb
  else
    return false 
  end
end

def full?(board)
  board.all?{|i| i != " " && i != "" && i != nil }
end

def draw?(board)
  if won?(board).class != Array && full?(board)
    return true 
  else
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board)
    return true 
  else
    return false
  end
end

def winner(board)
  w=won?(board)
  if w
    return board[w[0]]
  else
    nil 
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    puts "something wrong"
  end
end

