WIN_COMBINATIONS = [
  [0,1,2], #WIN_COMBINATIONS [0] Top Row Win
  [3,4,5], #WIN_COMBINATIONS [1] Middle Row Win
  [6,7,8], #WIN_COMBINATIONS [2] Bottom Row Win
  [2,4,6], #WIN_COMBINATIONS [3] Top Right Diagonal to Bottom Left Win
  [0,4,8], #WIN_COMBINATIONS [4] Top Left Diagonal to Bottom Right Win
  [0,3,6], #WIN_COMBINATIONS [5] Left Horizontal Win
  [1,4,7], #WIN_COMBINATIONS [6] Middle Horizontal Win
  [2,5,8]  #WIN_COMBINATIONS [7] Right Horizontal Win
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

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  value = current_player(board)
  if valid_move?(board, index) == true
    move(board, index, value)
  else
    turn(board)
  end
end

def turn_count (board)
  counter = 0
  board.each do |position|
    if position == "X" || position =="O"
    counter += 1
  end
end
counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    value = "X"
  else
    value = "O"
  end
end

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
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
       false
    end
  end
   false
end

def full?(board)
  if board.any? { |position| position == "" || position == " " || position == nil }
     false
  else
     true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    puts "Cat's Game!"
    true
  else
     false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
     true
  else
     false
  end
end

def winner(board)
  if win_combination = won?(board)
    board[win_combination.first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end

end
