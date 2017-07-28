WIN_COMBINATIONS = [
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
  print " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} \n"
end

def input_to_index(input)
  input.to_i - 1
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
  input = gets.chomp
  index = input_to_index(input)
  while !valid_move?(board,index)
    input = gets.chomp
    index = input_to_index(input)
  end
  move(board,index,current_player(board))
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do | position |
    if position != " "
      turns +=1
    end
  end
  turns
end

def current_player(board)
  turn = turn_count(board)
  if turn % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  counter=0
  condition = true
  combination = nil
  while counter < WIN_COMBINATIONS.size
    ind1 = WIN_COMBINATIONS[counter][0]
    ind2 = WIN_COMBINATIONS[counter][1]
    ind3 = WIN_COMBINATIONS[counter][2]
    pos1 = board[ind1]
    pos2 = board[ind2]
    pos3 = board[ind3]
    if (pos1 == "X" && pos2 == "X" && pos3 == "X") || (pos1 == "O" && pos2 == "O" && pos3 == "O")
      combination = [ind1,ind2,ind3]
    end
    counter+=1
  end
  if combination == nil
    false
  else
    combination
  end
end

def full?(board)
  !(board.any?{|i| i==" "})
end

def draw?(board)
  if full?(board)
    if won?(board)!=false
      false
    else
      true
    end
  else
    false
  end
end
def over?(board)
  if draw?(board)
    true
  elsif won?(board)!=false
    true
  elsif !(full?(board))
    false
  end
end

def winner(board)
  if over?(board)
    if won?(board)!=false
      var=won?(board)
      board[var[0]]
    else
      nil
    end
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif winner(board)!=nil
    puts "Congratulations #{winner(board)}!"
  end
end


board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
