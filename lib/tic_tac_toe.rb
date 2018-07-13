# defining all the possible (8) win combinations

WIN_COMBINATIONS = [
  #rows
  [0,1,2], [3,4,5], [6,7,8],
  #columns
  [0,3,6], [1,4,7], [2,5,8],
  #diagonals
  [0,4,8], [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, location)
  board[location] != " " && board[location] != "" && board[location] != nil
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  valid_move?(board,index) ? move(board, index, current_player(board)) && display_board(board) : turn(board)
end

def turn_count(board)
  counter = 0
  board.each do |slot|
    slot == "X" || slot == "O" ? (counter += 1) : ()
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
      if ( board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X" || board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O" )
        return win_combination
      end
    end
  return false
end

def full?(board)
  if board.any?{|empty| empty == "" || empty == " " || empty == nil }
    false
  else
    true
  end
end

def draw?(board)
  won?(board) ? (return false) : ()
  full?(board) ? (return true) : (false)
end

def over?(board)
  full?(board) || draw?(board) || won?(board)
end

def winner(board)
  won?(board) ? (return "#{board[won?(board)[0]]}") : ()
end

def play(board)
  until over?(board)
    turn(board)
  end

  message = winner(board)

  if won?(board)
    puts "Congratulations #{message}!"
  else
    puts ("Cat's Game!")
  end
end
