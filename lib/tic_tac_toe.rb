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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, index, char)
  board[index] = char
  board
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
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
  until valid_move?(board,index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 1
    "O"
  else
    "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if ( (board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") || (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O") )
      return combo
    end
  end
  return false
end

def full?(board)
  counter = -1
  board.all? do |val|
    counter += 1
    position_taken?(board, counter)
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  else
    nil
  end
end

def play(b)
  until over?(b)
    turn(b)
  end
  if winner(b) != nil
    puts "Congratulations " + winner(b) + "!"
  elsif draw?(b)
    puts "Cats Game!"
  end
end
