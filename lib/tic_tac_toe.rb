# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  board.count{|x|x=="X"||x=="O"}
end

def current_player(board)
  i = turn_count(board)
  i % 2 == 0 ? "X" : "O"
end

# Helper Methods
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

def move(board, index, token)
  board[index] = token
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  until over?(board)
    puts "your turn"
    turn(board)
  end
  if winner(board) == "X"
    puts"Congratulations X!"
  elsif winner(board) == "O"
    puts"Congratulations O!"
  else puts "Cat's Game!"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Down row

  [0,3,6], #1st column
  [1,4,7], #2nd column
  [2,5,8], #3d column

  [0,4,8], #horizontal 1
  [2,4,6] #horizontal 1
]
def won?(board)
  a = []
  b = []
for i in 0..8 do
  if  board[i] == "X"
    a<<i
  elsif board[i] == "O"
    b<<i
  end
end


WIN_COMBINATIONS.each do |ar|
   if (ar - a).empty?
     return ar
   elsif (ar - b).empty?
     return ar
   end
  end
  return false
end

def full?(board)
  a = []
  b = []
  for i in 0..8 do
    if  board[i] == "X"
      a<<i
    elsif board[i] == "O"
      b<<i
    end
  end
  return true if (a + b).length == 9
  return false
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || !!won?(board) || draw?(board)
end

def winner(board)
  x = won?(board)
  if !x
    return nil
  end
  board[won?(board)[0]]
end
