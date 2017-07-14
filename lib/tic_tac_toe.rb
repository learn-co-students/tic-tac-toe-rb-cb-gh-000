# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First col
  [1,4,7], # Second col
  [2,5,8], # Third col
  [0,4,8], # Diagonal from upper left
  [2,4,6], # Diagonal from upper right
]

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    ind_one, ind_two, ind_three = comb
    if ["X", "O"].include?(board[ind_one]) &&
      (board[ind_one] == board[ind_two] && board[ind_two] == board[ind_three])
      return comb
    end
  end
  false
end

def full?(board)
  board.all? do |move|
    move == "X" || move == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  indexes = won?(board)
  if indexes
    return board[indexes[0]]
  end
end

def turn_count(board)
  turns = 0
  board.each do |move|
    if move == "X" || move == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end
  won_player = winner(board)
  if won_player
    puts "Congratulations #{won_player}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end

# Helper methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(ind_str)
  ind_str.to_i - 1
end

def move(board, ind, player_char)
  board[ind] = player_char
end

def valid_move?(board, ind)
  (ind >= 0 && ind < 9) && !position_taken?(board, ind)
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, ind)
  board[ind] == "X" || board[ind] == "O"
end

def ask_input
  puts "Please enter 1-9:"
  input = gets.strip
  input_to_index(input)
end

def turn(board)
  index = ask_input()
  while !valid_move?(board, index)
    index = ask_input()
  end
  move(board, index, current_player(board))
  display_board(board)
end
