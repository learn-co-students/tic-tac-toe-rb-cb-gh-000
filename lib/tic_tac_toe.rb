# global constant for winning combinations
WIN_COMBINATIONS = [
  # row combinations
  [0,1,2],
  [3,4,5],
  [6,7,8],
  # column combinations
  [0,3,6],
  [1,4,7],
  [2,5,8],
  # diagonal combinations
  [0,4,8],
  [2,4,6]
]

# display_board - displays an arbitrary board state to the screen
# => board - board state to display
def display_board(board)
  separator = ""
  11.times{separator = separator + "-"}
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts separator
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts separator
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# input_to_index - convert user string input to an integer input_to_index
def input_to_index(input)
  return input.to_i - 1
end

# position_taken? - determine if a position on the board is taken or not
# => board - current board state
# => index - index to check for availability
# <= true - the position is taken
# <= false - the position is open
def position_taken?(board, index)
  return !( board[index] == "" ||
  board[index] == " " ||
  board[index] == nil)
end

# valid_move? - determine if a requested move is valid_move
# => board - current board state
# => index - index to check for validity
# <= true - move is valid
# <= false - move is invalid
def valid_move?(board, index)
  index_in_range = index >= 0 || index <= 8
  if(index == 4)
    puts index_in_range
    puts !position_taken?(board, index)
  end
  return index_in_range && !position_taken?(board,index)
end

# move - process a user move
# => board - current board state
# => index - index to check for validity
# => move - token to place for the move
def move(board, index, token)
  board[index] = token
end
