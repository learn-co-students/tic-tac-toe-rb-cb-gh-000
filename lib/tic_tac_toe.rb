WIN_COMBINATIONS = [
  [0, 1, 2], # First row
  [3, 4, 5], # Second row
  [6, 7, 8], # Third row
  [0, 3, 6], # First column
  [1, 4, 7], # Second column
  [2, 5, 8], # Third column
  [0, 4, 8], # Top-left to bottom-right diagonal
  [2, 4, 6]  # Top-right to bottom-left diagonal
]

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
  counter = 0

  board.each do |cell|
    if cell == "X" || cell == "O"
      counter += 1
    end
  end

  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
    position_1 = win_combination[0]
    position_2 = win_combination[1]
    position_3 = win_combination[2]

    if board[position_1] == "X" && board[position_2] == "X" && board[position_3] == "X"
      return win_combination
    end

    if board[position_1] == "O" && board[position_2] == "O" && board[position_3] == "O"
      return win_combination
    end

  end

  false
end

def full?(board)
  index = 0

  while index < board.size
    if position_taken?(board, index)
      index += 1
    else
      return false
    end
  end

  true
end

def draw?(board)
  if full?(board)
    if won?(board)
      false
    else
      true
    end
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  win_combination = won?(board)

  win_combination ? board[win_combination[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end

  if draw?(board)
    puts "Cats Game!"
  end

end
