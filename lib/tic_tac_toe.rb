# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(user_input)
  user_input = user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# code your #valid_move? method here
def valid_move?(board, index)
  index.between?(0, 8) && (position_taken?(board, index) == false)
end

#code your turn method here
#def turn(board)
#  puts "Please enter 1-9:"
#  user_num = gets.to_i
#  index = input_to_index(user_num)
#  if valid_move?(board, index)
#    move(board, index, current_player(board))
#    display_board(board)
#  else
#    turn(board)
#  end
#end

def turn(board)
  puts "Please enter a number between 1-9:"
  input = gets.strip
  if (valid_move?(board, input_to_index(input)))
    move(board, input_to_index(input), current_player(board))
    display_board(board)
  else
    puts "Invalid input!"
    turn(board)
  end
end

#define your tur_count method here
def turn_count(board)
  count = 0
  board.each do |space|
    if space != " "
      count += 1
    end
  end
  count
end

#current_player method
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Define your won? method below
def won?(board)
  WIN_COMBINATIONS.each do |combination|
    index1 = combination[0]
    index2 = combination[1]
    index3 = combination[2]
    if position_taken?(board, index1) && position_taken?(board, index2) && position_taken?(board, index3)
      if (board[index1] == board[index2]) && (board[index2] == board[index3])
        return combination
      end
    end
  end
  return false
end

def full?(board)
   board.all? do |position|
    position == "O" || position == "X"
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if draw?(board) || !over?(board)
    return nil
  else
    return board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
