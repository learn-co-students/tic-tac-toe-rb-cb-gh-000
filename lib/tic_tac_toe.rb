# Helper Methods
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

def turn_count(board)
  count = 0;
  board.each do |cell|
    if (cell == "X" || cell == "O")
      count += 1
    end
  end
  return count
end

def current_player(board)
  count = turn_count(board)
  (count % 2 == 0) ? "X" : "O"
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

def won?(board)
  winning = WIN_COMBINATIONS.find do |combination|
    position_taken?(board,combination[0]) && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
  end
  winning == [] ? nil : winning
end

def full?(board)
  board.all? do |cell|
    cell == "X" || cell == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  combination = won?(board)
  return (combination ? board[combination[0]] : nil)
end

def play(board)
  until over?(board)
    turn(board)
  end
  # Congratulate winner
  winner = winner(board)
  if (winner)
    puts "Congratulations #{winner}!"
  end
  if (draw?(board))
    puts "Cats Game!"
  end
end
