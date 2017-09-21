


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]


def won?(board)
  won = nil
  WIN_COMBINATIONS.each do |x|
    if board[x[0]] == "X" && board[x[1]] == "X" && board[x[2]] == "X"
      won = x
    elsif board[x[0]] == "O" && board[x[1]] == "O" && board[x[2]] == "O"

      won = x
    end
  end
  return won
end

def full?(board)
  full = false
  x = 0
  counter = 0
  while counter < 9
  if position_taken?(board, x) == true
    x += 1
    counter += 1
  else
    counter +=1
  end
 end
  if x == 9
    full = true
  end
  return full
end

def draw?(board)
  draw = false
  if won?(board) == nil && full?(board) == true
    draw = true
  end
  return draw
end

def over?(board)
  over = false
  if draw?(board) == true || won?(board) != nil
    over = true
  end
  return over
end

def winner(board)
  won = nil
  WIN_COMBINATIONS.each do |x|
    if board[x[0]] == "X" && board[x[1]] == "X" && board[x[2]] == "X"
      won = "X"
    elsif board[x[0]] == "O" && board[x[1]] == "O" && board[x[2]] == "O"
      won = "O"
    end
  end
  return won
end

def input_to_index(user_input)
  var = user_input.to_i
  user_input = var - 1
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

def current_player(board)
  turnt = turn_count(board)
  if turnt % 2 == 0
    current_player = "X"
  else
    current_player = "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  turn = 0
  while counter < 10
    if board[counter] == "X" || board[counter] == "O"
      turn += 1
      counter += 1
    else
      counter += 1
    end
  end
  turn
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if draw?(board) == true
    puts "Cats Game!"
  end
  variable4 = winner(board)
  puts "Congratulations #{variable4}!"
end
