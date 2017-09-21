WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6],  # left columns
  [1,4,7],  # middle columns
  [2,5,8],  # right columns
  [0,4,8],  # diagonals 1
  [2,4,6],  # diagonals 2
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  num = input.to_i
  num = num-1
end

def move(board,input,character)
  board[input] = character
end

def valid_move?(board, index)
  validity = nil
  if position_taken?(board, index)
    validity = false
  elsif !(index.between?(0,8))
    validity = false
  else
    validity = true
  end
end

def position_taken?(board,index)

  taken = nil
  if (board[index] ==  " " || board[index] == "" || board[index] == nil)
    taken = false
  else
   taken = true
  end
  taken
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

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def won?(board)
  status = nil
  WIN_COMBINATIONS.detect do |win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      status = win_combination # return the win_combination indexes that won.
    else
      status = false
    end
  end
  return status
end

def full?(board)
  board.all? do |token|
    token == "X" || token == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winning_token = nil
  if won?(board)
    winning_token = board[won?(board)[0]]
  else
    winning_token = nil
  end
  winning_token
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
