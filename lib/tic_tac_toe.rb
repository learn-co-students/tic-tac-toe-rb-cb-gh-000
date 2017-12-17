
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all? { |index| board[index].strip == "X" } ||
      win_combination.all? { |index| board[index].strip == "O" }
      return win_combination
    end
  end
  false
end

def full?(board)
  board.none? { |cell| cell == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    index_winner = won?(board)[0]
    return board[index_winner].strip
  end
  nil

end
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

# Define your play method below
def play(board)
  round = 1
  while (round <= 9)
    turn(board)
    round += 1
  end
end

def turn_count(board)
  counter = 0
  board.each do |field|
    if field != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
   turn_count(board) % 2 == 0 ? "X" : "O"
end

def congratulate(board)
  puts "Congratulations #{winner(board)}!"
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    congratulate(board)
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
