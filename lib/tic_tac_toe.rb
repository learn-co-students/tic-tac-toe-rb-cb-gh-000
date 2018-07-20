# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4 ,6]
]

def play(board)
  until over?(board) || draw?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    puts "invalid"
    turn(board)
  else
    move(board, index, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  turns = board.select do |symbol|
    symbol == "X" || symbol == "O"
  end
  return turns.length
end

def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
end

def valid_move?(board_positions, position)
  !position_taken?(board_positions, position) && position.between?(0, 8)
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  combo = WIN_COMBINATIONS.select do |combination|
    start = board[combination[0]]
    combination.none?{|index| !position_taken?(board, index) || board[index] != start}
  end
  combo == [] ? false : combo[0]
end

def full?(board)
  !board.any?{|symbol| symbol == "" || symbol == " "}
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
    return false
end

def over?(board)
  full?(board) || won?(board) ? true : false
end

def winner(board)
  !won?(board) ? nil : board[won?(board)[0]]
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  input = input.to_i - 1
end

def move(board_array, index, value)
  board_array[index] = value
end
