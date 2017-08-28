WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
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

# Array -> number
# Returns the number of occupied places in the Array

def turn_count (board)
	count = 0
	board.each do |cell|
		if (cell == "X" || cell == "O")
			count += 1
		end
	end
	count
end

# Array -> String
# Determines wheteher it is X's move or O's move

def current_player (board)
	count = turn_count(board)
	count % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  count = 0
  while count < 9
    turn(board)
    count += 1
  end
end


# Array -> Array
# Determines if the game is won be any of the players

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if ((board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X") || (board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"))
      return combination
    end
  end
  nil
end

# Array -> Boolean
# Returns True if the board array is full, false otherwise

def full?(board)
  board.none? do |cell|
    cell == " "
  end
end

# Array -> Boolean
# Returns true if the board has not been won and is full and false if the board is not won and the board is not full

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

# Array -> Boolean
# Determines if the game is over

def over?(board)
  if  won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

# Array -> String
# Returns the winner of the game if there is one

def winner (board)
  if won? (board)
    return board[won?(board)[0]]
  else
    nil
  end
end

play(["","","","","","","","",""])
