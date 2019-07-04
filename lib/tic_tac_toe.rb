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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  board.count{|c| c != " "}
end

def current_player(board)
  ["X", "O"][turn_count(board) % 2]
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
    turn(board)
    won?(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

def won?(board)
  pos = WIN_COMBINATIONS.find do |indexes|
    ["X", "O"].any? do |c|
      indexes.all?{|i| board[i]==c}
    end
  end
  if pos == nil
    false
  else
    pos
  end
end

def full?(board)
  board.none?{|c| c == " "}
end

def draw?(board)
  full?(board) && won?(board) == false
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  board[won?(board)[0]] if won?(board) != false
end

# Define your WIN_COMBINATIONS constant
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
