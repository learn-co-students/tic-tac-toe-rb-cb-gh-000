
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board (board = Array.new(n*n, " "), n = 3) # width = heighh of square board
  result = Array.new
  n.times do |i|
    temp = Array.new
    n.times do |j|
      temp << " " + board[n*i + j] + " "
    end
    result << temp.join("|") + "\n"
    temp.clear
  end
  puts result.join("-"*11+"\n")
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
  board
end

def position_taken?(board, index)
  if board[index] == " "  || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index >= 0 && index <= 8 && !position_taken?(board, index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  until valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" || board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end
  return false
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def over?(board)
  won?(board) || full?(board)
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) != nil
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
