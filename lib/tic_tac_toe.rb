# Display board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# input to index function
def input_to_index(action)
  action.to_i - 1
end

# turn-counter
def turn_count(board)
  board.select{|i| i=="X" || i=="O"}.length
end

# current_player
def current_player(board)
  if turn_count(board) % 2 != 0
    "O"
  else
    "X"
  end
end

###########################################
def move(array, pos, character)
  array[pos] = character
end
###########################################

# position_taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# valid move
def valid_move?(board, index)
  if position_taken?(board, index) == false && index < 9 && index >= 0
    true
  else
    false
  end
end

# TURN
def turn(board)
  puts("Please enter 1-9:")
  action = input_to_index(gets.strip())
  if valid_move?(board, action)
    move(board, action,current_player(board))
    display_board(board)
  else
    while valid_move?(board, action) != true do
      puts("Please enter 1-9:")
      action = input_to_index(gets.strip())
      # valid_move(board, action)
    end
    move(board, action,current_player(board))
    display_board(board)
  end
end

# WIN_COMBINATIONS constant
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

#  win checker
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
      break
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
      break
    end
  end
  false
end

# isfull checker
def full?(board)
  board.all?{|a| a!="" && a!=" " && a!= nil}
end

# draw checker
def draw?(board)
  if !won?(board) && full?(board)
    true
  end
end

# returns true if won/draw/fullboard else false
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

# returns the winner
def winner(board)
  if !won?(board)
    nil
  else
    to_check = won?(board)
    f = board[to_check[0]]
    s = board[to_check[0]]
    t = board[to_check[0]]
    if f == "X" && s == "X" && t == "X"
      "X"
    elsif f == "O" && s == "O" && t == "O"
      "O"
    end
  end
end

# play
def play(board)
  display_board(board)
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    puts("Congratulations #{winner(board)}!")
  elsif draw?(board)
    puts("Cats Game!")
  end
end

# play([" "," "," "," "," "," "," "," "," "])
