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
  while(!over?(board))
     turn(board)
   end
   if won?(board)
     puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
     puts "Cats Game!"
   end
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
    return board.count{|token| token == "X" || token == "O"}
end

def won?(board)
  WIN_COMBINATIONS.each do |iter|
    winnerX = iter.all? do |posistion| board[posistion] == "X"  end
    winnerO = iter.all? do |posistion| board[posistion] == "O"  end
    if winnerX || winnerO
      return iter
    end
  end
  return false
end

def full?(board)
  isFull = board.all? do |value| (value == "X" || value == "O") end
  if isFull
    return true
  end
  return false
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
  return false
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  end
  return false
end

def winner(board)
  if champion = won?(board)
    return board[champion[0]]
  end
  return nil
end
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], #Bot Row
  [0,3,6], #left col
  [1,4,7], #mid col
  [2,5,8], #right col
  [0,4,8], #right diag
  [6,4,2]  #left diag
]
