WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,4,8], # Diagonal 1
  [2,4,6], # Diagonal 2
  [0,3,6], # Column 1
  [1,4,7], # Column 2
  [2,5,8]  # Column 3
  # ETC, an array for each win combination
]
 def won?(board)
  WIN_COMBINATIONS.detect do |arr_comb|
	board[arr_comb[0]]!=" " && board[arr_comb[0]]==board[arr_comb[1]] && board[arr_comb[0]]==board[arr_comb[2]]
  end
end
 def full?(board)
  board.none? do |element|
	element == " "
  end
end
 def draw?(board)
  !won?(board) && full?(board)
end
 def over?(board)
  won?(board) || full?(board) || draw?(board)
end
 def winner (board)
  winner_combination = won?(board)
  if winner_combination!= nil
	   board[winner_combination[0]]
  end
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
 def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
 def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
 def turn_count(board)
  board.select{|i| i!=" "}.length
end
 def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
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
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts winner(board)
    puts "Congratulations "+ winner(board) +"!"
  else
    puts "Cat's Game!"
  end
end
