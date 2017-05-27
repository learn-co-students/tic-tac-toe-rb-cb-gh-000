WIN_COMBINATIONS = [
  [0, 1, 2],  # Top
  [3, 4, 5],  # Middle
  [6, 7, 8],  # Bottom

  [0, 3, 6],  # Left
  [1, 4, 7],  # Middle
  [2, 5, 8],  # Right

  [0, 4, 8], # Diagonal 1
  [2, 4, 6]  # Diagonal 2
]

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

def move(board, index, playerChar)
  board[index] = playerChar
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  (!position_taken?(board, index) && index.between?(0, 8)) ? true : false
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
  board.select { |char| char != " " }.length
end

def current_player(board)
  (turn_count(board) % 2 == 0) ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    if combo.all? { |i| board[i] == "X" } || combo.all? { |i| board[i] == "O" }
      return combo
    end
  end
end

def full?(board)
  board.all? { |char| char != " " }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  !won?(board) ? nil :
   won?(board).all? { |i| board[i] == "X" } ? "X" :
   won?(board).all? { |i| board[i] == "O" } ? "O" : nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
