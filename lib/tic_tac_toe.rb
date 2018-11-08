WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Lower row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diagonal starts from top left corner
  [2,4,6]  # Diagonal starts from top right corner
]

def display_board(board_array)
  puts " #{board_array[0]} | #{board_array[1]} | #{board_array[2]} "
  puts "-----------"
  puts " #{board_array[3]} | #{board_array[4]} | #{board_array[5]} "
  puts "-----------"
  puts " #{board_array[6]} | #{board_array[7]} | #{board_array[8]} "
end

def input_to_index(user_input)
  user_index = user_input.to_i
  index = user_index - 1
  return index
end

def move(board, index, character)
  valid_move?(board, index) ? board[index] = character : false
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9"
  input = gets.strip
  index = input_to_index(input)
  valid_move?(board, index) ? move(board,index,current_player(board)) && display_board(board) : gets.strip
end

def turn_count(board)
  board.select {|index| index == "X" || index == "O"}.length
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  winner = []
  WIN_COMBINATIONS.each { |index|
    win_index_1 = index[0]
    win_index_2 = index[1]
    win_index_3 = index[2]
    puts position_1 = board[win_index_1]
    puts position_2 = board[win_index_2]
    puts position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      winner = index
      break
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      winner = index
      break
    end}
   winner == [] ? false : winner
end

def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  index = won?(board) ? won?(board)[0] : false
  index ? board[index] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
