# Define WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  # row win
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  # column win
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  # diagonal win
  [0, 4, 8],
  [2, 4, 6]
]

# Define #display_board method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Define #input_to_index method
def input_to_index(input)
  input.to_i - 1
end

# Define #move method
def move(board, index, current_player)
  board[index] = current_player
end

# Define #position_taken? method
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# Define #valid_move? method
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Define #turn method
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    token = ""
    if turn_count(board) % 2 == 0
      token = "X"
    else
      token = "O"
    end
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

# Define #turn_count method
def turn_count(board)
  turn_count = 0
  board.each do |move|
    if move == "X" || move == "O"
      turn_count += 1
    end
  end
  return turn_count
end

# Define #current_player method
def current_player(board)
  turn = turn_count board
  if turn % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Define #won method
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if combo.all?{|index| position_taken?(board, index) && board[index] == "X"}
      return combo
    elsif combo.all?{|index| position_taken?(board, index) && board[index] == "O"}
      return combo
    end
  end
  nil
end

# Define #full method
def full?(board)
  board.all?{|space| space == "X" || space == "O"}
end

# Define #draw method
def draw?(board)
  !won?(board) && full?(board)
end

# Define #over method
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

# Define #winner method
def winner(board)
  combo = won?(board)
  if combo == nil
    nil
  else
    board[combo[0]]
  end
end

#define #play method
def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
