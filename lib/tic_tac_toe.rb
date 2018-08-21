WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], #Bottom row
  [0,3,6],  #left columns
  [1,4,7],  #middle column
  [2,5,8], #right columns
  [0,4,8], #top-left to bottom-right diagnal
  [2,4,6] #top-right to bottom-left diagnal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i-1
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
  input = gets
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
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations "+winner(board)+"!"
  else
    puts "Cat's Game!"
  end
end

def turn_count(board)
  count = 0
  board.each do |tile|
    if tile == "X" || tile == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  for combination in WIN_COMBINATIONS
    if board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] && board[combination[2]] == board[combination[0]]
      if (board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X")
        return combination
      elsif (board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O")
        return combination
      end
    end
  end
  return false
end

def full?(board)
  return !board.include?(" ")
end

def draw?(board)
  if full?(board)
    if !won?(board)
      return true
    elsif won?(board)
      return false
    end
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
  return false
end

def winner(board)
  if (won?(board))
    return board[won?(board)[0]]
  end
  return nil
end
