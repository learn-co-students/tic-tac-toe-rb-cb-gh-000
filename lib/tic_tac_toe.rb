WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left row
  [1,4,7],  # Center row
  [2,5,8],  # Right row
  [0,4,8],  # First diagonal
  [2,4,6]   # Second diagonal
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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

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
  board.select { |position| position == "X" || position == "O" }.size
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    moves = combination.collect { |position| board[position] }.join()
    if moves == "XXX" || moves == "OOO"
      return combination
    end
  end
  false
end

def full?(board)
  !board.any? { |value| value.nil? || value == "" || value == " " }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  combination = won?(board)
  if combination
    board[combination[0]]
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
