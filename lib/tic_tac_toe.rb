WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def player_move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  return board[position] == "X" || board[position] == "O"
end

def valid_move?(board, position)
  return position.between?(0,8) && !position_taken?(board, position)
end

def turn(board)
  puts "Position 1-9"
  user_input = gets
  user_input = input_to_index(user_input)
  while !valid_move?(board, user_input)
    puts "Position 1-9"
    user_input = gets
    user_input = input_to_index(user_input)
  end
  player_move(board, user_input, current_player(board))
  display_board(board)
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  win_combo = false
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    if board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X" || board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O"
      win_combo = win_combination
    end
  end
  win_combo
end

def full?(board)
  board.none? {|cell| cell.include?(" ")}
end

def draw?(board)
  w = won?(board)
  f = full?(board)
#returns true if the board has not been won and is full
  if (!w && f)
    return true
  end
#returns false if the board is not won and the board is not full, and false if the board is won.
  if (!w && !f || w)
    return false
  end
end

def over?(board)
#returns true if the board has been won, is a draw, or is full
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
#return the token, "X" or "O" that has won the game given a winning board
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
# until the game is over
#   take turns
# end
#
# if the game was won
#   congratulate the winner
# else if the game was a draw
#   tell the players it has been a draw
# end

  while !over?(board)
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat\'s Game!"
  end

end
