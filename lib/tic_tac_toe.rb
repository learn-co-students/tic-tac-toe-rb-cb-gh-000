WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, value)
  board[index] = value
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, input)
  if input < 0 || input > 8
    return false
  end
  if position_taken?(board,input)
    return false
  end
  return true
end

def turn(board)
  turn_validity = true
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

def turn_count(board)
  count = 0
  board.each do |i|
    if (i != " ")
      count += 1
    end
  end
  return count
end

def current_player(board)
  count = turn_count(board)
  if (count % 2) == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |y|
    win_index_1 = y[0]
    win_index_2 = y[1]
    win_index_3 = y[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      return y
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return y
    end
  end
  return nil
end

def full?(board)
  board.none? do |i|
    i == " "
  end
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if (won?(board) || full?(board) || draw?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if draw?(board)
    return nil
  end

  win_pos = won?(board)
  if !win_pos
    return nil
  end
  winner = board[win_pos[1]]
end

def play(board)
  while !over?(board) do
    turn(board)
  end

  win = winner(board)

  if win == nil
    puts "Cat's Game!"
  else
    puts "Congratulations #{win}!"
  end
end
