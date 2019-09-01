# Helper Method
def play board
  # until the game is over
  #   take turns
  # end
  #
  # if the game was won
  #   congratulate the winner
  # else if the game was a draw
  #   tell the players it has been a draw
  # end

  while !over?(board) do
    turn board
  end

  winner = winner(board)
  if winner
    puts "Congratulations #{winner}!"
  end

  if draw?(board)
    puts "Cat's Game!"
  end
end

def turn_count board
  count = 0
  board.each do |cell|
    if cell == 'O' || cell == 'X'
      count += 1
    end
  end
  count
end

def current_player board
   (turn_count(board) % 2 == 0 ) ? "X" : "O"
end


def turn board
  # we are using recursion here
  # get input
  # convert input to index
  # if index is valid
  #   make the move for input
  # else
  #   ask for input again until you get a valid input
  # end
  puts "Please enter 1-9:"
  input = input_to_index (gets.to_i)
  if valid_move? board, input
    token = current_player board
    move(board, input, token)
    display_board board
  else
    turn board
  end
end

def display_board board
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index input
  input.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move? board, index
  if (index >= 0 && index <= 8) && !position_taken?(board, index)
    true
  else
    false
  end
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

def won? board
  for win_combination in WIN_COMBINATIONS do
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  false
end

def full? board
  board.all? {|position| position == "X" || position == "O"}
end

def draw? board
  # if full? && !won? return true
  # if !won? && !full? return false
  # if won? return false

  if full?(board) && !won?(board)
    return true
  end
end

def over? board
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner board
  has_won = won?(board)
  if has_won
    return board[has_won[0]]
  end
end

def move board, index, token
  #do we need to add validations here of in the bin file
  board[index] = token
end
