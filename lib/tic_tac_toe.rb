# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Middle row
  [0,3,6],  # Middle row
  [1,4,7],  # Middle row
  [2,5,8],  # Middle row
  [0,4,8],  # Middle row
  [6,4,2],  # Middle row
]

def won?(board)
  counter = -1
  until counter == WIN_COMBINATIONS.size - 1
    counter += 1
    if  board[WIN_COMBINATIONS[counter][0]] == "X" && board[WIN_COMBINATIONS[counter][1]] == "X" && board[WIN_COMBINATIONS[counter][2]] == "X" ||
      board[WIN_COMBINATIONS[counter][0]] == "O" && board[WIN_COMBINATIONS[counter][1]] == "O" && board[WIN_COMBINATIONS[counter][2]] == "O"
      return WIN_COMBINATIONS[counter] # return the win_combination indexes that won.
    end
  end
  return false
end

def full?(board)
  board.detect{|i| i == " "} == nil
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board, current_player)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board, current_player)
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    puts "Current Player: #{current_player(board)}"
    turn(board, current_player(board))
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def turn_count(board)
  turn = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
       turn += 1
    end
  end
  turn
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end
