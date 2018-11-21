# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], # Right column
  [0, 4, 8],
  [2, 4, 6]
]

# prints the current board representation, 1 argument
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# take user_input and convert it to an Integer and subtracts 1, 1 argument string
def input_to_index(input)
  return input.to_i - 1
end

# 3 arguments board, index, value
def move(board, index, value)
  board[index] = value
  return board
end

# evaluating the position selected and checking to see whether pos occupied
def position_taken?(board, index)
  if board[index] == nil or board[index] == "" or board[index] == " "
    return false
  elsif board[index] == "X" or board[index] == "O"
    return true
  end
end

# check the submitted position is present on the game board and not already filled
def valid_move?(board, index)
  if index.between?(0, 8) and not position_taken?(board, index)
    return true
  else
    return false
  end
end

# this method takes in an argument and returns the number of turns played
def turn_count(board)
  cnt = 9
  board.each do |pos|
    if pos == "" or pos == " " or pos == nil
      cnt -= 1
    end
  end
  return cnt
end

# determine if its X's turn or O's turn
def current_player(board)
  return ["X", "O"][turn_count(board) % 2]
end

# encapsulate the logic of a single complete turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end

# return false if there is no win combination present or the winning combination
def won?(board)
  i = 0
  while i < 9
    if board[WIN_COMBINATIONS[i][0]] == "X" and board[WIN_COMBINATIONS[i][1]] == "X" and board[WIN_COMBINATIONS[i][2]] == "X"
      return WIN_COMBINATIONS[i]
    elsif board[WIN_COMBINATIONS[i][0]] == "O" and board[WIN_COMBINATIONS[i][1]] == "O" and board[WIN_COMBINATIONS[i][2]] == "O"
      return WIN_COMBINATIONS[i]
    end
    i += 1
  end
rescue NoMethodError
  return false
end

# check whether every element in the board contains X or O
def full?(board)
  return board.all?{|pos| pos == "X" or pos == "O"}
end

# check whether it can be drawn
def draw?(board)
  if not won?(board)
    return full?(board)
  else
    return false
  end
end

# check whether game over
def over?(board)
  if won?(board) or draw?(board) or full?(board)
    return true
  else
    return false
  end
end

# check winner
def winner(board)
  if over?(board)
    i = 0
    while i < 9
      if board[WIN_COMBINATIONS[i][0]] == "X" and board[WIN_COMBINATIONS[i][1]] == "X" and board[WIN_COMBINATIONS[i][2]] == "X"
        return "X"
      elsif board[WIN_COMBINATIONS[i][0]] == "O" and board[WIN_COMBINATIONS[i][1]] == "O" and board[WIN_COMBINATIONS[i][2]] == "O"
        return "O"
      end
      i += 1
    end
  end
end

# play method
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    w = winner(board)
    if w == "X"
      puts "Congratulations X!"
    elsif w == "O"
      puts "Congratulations O!"
    end
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
