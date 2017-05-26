# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
#horizontal
  [0,1,2],
  [3,4,5],
  [6,7,8],
#vertical
  [0,3,6],
  [1,4,7],
  [2,5,8],
#diagonal
  [0,4,8],
  [2,4,6]
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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  if board[index] == "" or board[index] == " " or board[index] == nil
    return false
  elsif board[index] == 'X' or board[index] == 'O'
    return true
  end
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |symbol|
    if symbol == "X" or symbol == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  (turn_count(board) % 2 == 0) ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.any? do |indexes|
    if (indexes.all? {|position| board[position] == "X"} or indexes.all? {|position| board[position] == "O"})
      return indexes
    end
  end
end

def full?(board)
  board.all? { |e| e == "X" or e == "O"}
end

def draw?(board)
  (won?(board)) ? false : (full?(board)) ? true : false
end

def over?(board)
  (won?(board) or draw?(board) or full?(board))
end

def winner(board)

  if (!won?(board))
    return nil
  end

  ((won?(board)).all? { |idx| board[idx] == "X"}) ? "X" : (won?(board)).all? { |idx| board[idx] == "O"} ? "O" : nil
end

def play(board)
  while (!over?(board))
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
