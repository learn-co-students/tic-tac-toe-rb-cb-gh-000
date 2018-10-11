WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5 ,8],
  [0, 4, 8],
  [2, 4, 6]
]

def position_taken?(board, index)
  return board[index] != ' '
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def valid_move?(board, position)
  if position < 0 || position > 8
    return false
  elsif position_taken?(board, position)
    return false
  end

  return true
end

def move(board, position, player)
  if !position_taken?(board, position)
    board[position] = player
  end
end

def turn_count(board)
  counter = 0

  board.each do |e|
    if e != ' '
      counter += 1
    end
  end

  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def turn(board)
  input = gets
  input = input_to_index(input)

  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if(board[win[0]] == board[win[1]] && board[win[0]] == board[win[2]] && position_taken?(board, win[0]))
      return win
    end
  end

  return false
end

def full?(board)
  return board.all? { |e| e != ' ' }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end

  if won?(board)
    return false
  end

  return false
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end

  return nil
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
