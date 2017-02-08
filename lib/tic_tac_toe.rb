# Helper Methods
# WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],   # Top row
  [3, 4, 5],   # Middle row
  [6, 7, 8],   # End row
  [0, 3, 6],   # Left column
  [1, 4, 7],   # Middle column
  [2, 5, 8],   # Right column
  [0, 4, 8],   # \ Diaganol
  [2, 4, 6]    # / Diaganol
]

#Displays the board to the user
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Returns the index of the user's input
def input_to_index(user_input)
  user_input.to_i - 1
end

# Places an 'X' or an 'O' on the board.
# @param The board array,
# @param The index in the board array that the player would like to fill out with an "X" or and "O"
# @param The player's character (either "X" or "O").
def move(board, index, current_player)
  board[index] = current_player
end

# Checks to see if a board's index is vacant or if it contains an "X" or an "O"
# If the position is free the method will return false.
# @param The board array.
# @param A specific location on the board.
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
# Accepts a board and an index to check and
# returns true if the move is valid and false or nil if not.
# @param The board array.
# @param A specific index on the board.
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

def turn_count(board)
  counter = 0

  board.each do | value |
    if value.upcase == "X" || value.upcase == "O"
      counter += 1
    end
  end

  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  return_value = WIN_COMBINATIONS.select do
    |win_combination|

    flag = true
    num_x = 0
    num_o = 0
    i = 0
    while i < win_combination.size && flag
      if board[win_combination[i]].eql?("X") && num_o == 0
        num_x += 1
      elsif board[win_combination[i]].eql?("O") && num_x == 0
        num_o += 1
      else
        flag = false
      end

      i += 1
    end

    num_x == 3 || num_o == 3
  end

  return_value.size > 0 ? return_value[0] : false
end

def full?(board)
  board.all? { |e| (e.eql?("X") || e.eql?("O")) }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  champion = won?(board)

  if champion
    x_or_y = board[champion[0]]
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
