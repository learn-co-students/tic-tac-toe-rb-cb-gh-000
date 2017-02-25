def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def empty?(board)
  board.each do |i|
    if (i != " ")
      return false;
    end
  end

  return true
end

def same_player?(board, combo)
  i = combo[0]
  j = combo[1]
  k = combo[2]

  return ((board[i] == 'X' && board[j] == 'X' && board[k] == 'X')\
  || (board[i] == 'O' && board[j] == 'O' && board[k] == 'O'))
end

def won?(board)
  if (empty?(board))
    return false;
  end

  WIN_COMBINATIONS.each do |combo|
    if (same_player?(board, combo))
      return combo;
    end
  end

  return false;
end

def full?(board)
  board.each do |i|
    if i.strip == ""
      return false
    end
  end
  return true
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  return won?(board) || full?(board) || draw?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |combo|
    n = combo[0]
    j = combo[1]
    k = combo[2]
    if (same_player?(board, combo))
      return board[n]
    end
  end

  return nil
end

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
  while (!over?(board))
    turn(board)
  end

  if (winner(board) == "X")
    puts "Congratulations X!"
  elsif (winner(board) == "O")
    puts "Congratulations O!"
  else
    puts "Cats Game!"
  end
end

def turn_count(board)
  x = 0

  board.each do |i|
    if (i != " ")
      x += 1
    end
  end

  return x
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return 'X'
  else
    return 'O'
  end
end
