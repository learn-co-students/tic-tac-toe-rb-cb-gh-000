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

def play(board)
  until over?(board) do
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

def turn_count(board)
  turns_played = 0
  board.each do |item|
    if item == "X" || item == "O"
       turns_played += 1
    end
  end
  return turns_played
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X":"O"
end

WIN_COMBINATIONS = [
  #rows
  [0,1,2], 
  [3,4,5], 
  [6,7,8], 
  
  #columns
  [0,3,6], 
  [1,4,7], 
  [2,5,8], 
  
  #diagonals
  [0,4,8], 
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    won_x = win_combination.all? do |i|
      board[i] == "X"
    end
    
    won_o = win_combination.all? do |i|
      board[i] == "O"
    end
    
    if won_x || won_o
      return win_combination
    end
  end
  
  return false
end

def full?(board)
  board.all? do |i|
    i == "X" || i == "O"
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  win_combination = won?(board)
  if win_combination != false
    winner = board[win_combination[0]]
  end
end