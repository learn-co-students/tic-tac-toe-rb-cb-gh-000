# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  board[index] == "X" || board[index] == "O" ? true : false
end

# code your #valid_move? method here
def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8) ? true : false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn (board)
  else
    move(board, index, current_player(board))
  end
  display_board(board)
end

def turn_count(board)
  i = 0
  board.each do |boards|
    i += 1 if boards != " "
  end
  i
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
     board[combo[0]] == board[combo[1]] &&
     board[combo[1]] == board[combo[2]] &&
     position_taken?(board, combo[0])
   end
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
     puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
     puts "Cat\'s Game!"
   end
end
