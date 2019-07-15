
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
  return index
end

def move(board, position, token)
  board[position] = token
  return board
end

def position_taken?(board, position)
  if(board[position] == "X" || board[position] == "O")
    return true
  else
    return false
  end
end

def valid_move?(board, move)
  if(position_taken?(board, move) || move < 0 || move > 8)
    return false
  else
    return true
  end
end

def turn(board)
  puts "Enter position 1-9"
  pos = input_to_index(gets)
  if(valid_move?(board, pos))
    move(board, pos, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |el|
    if(el == "X" || el == "O")
      count += 1
    end
  end
  return count
end

def current_player(board)
  if(turn_count(board)%2 == 0)
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    if (board[comb[0]] == "X" && board[comb[1]] == "X" && board[comb[2]] == "X")
      return comb
    elsif (board[comb[0]] == "O" && board[comb[1]] == "O" && board[comb[2]] == "O")
      return comb
    end
  end
  return nil
end

def full?(board)
  board.each do |el|
    if(el == " ")
      return false
    end
  end
  return true
end

def draw?(board)
  if(!won?(board) && full?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if(draw?(board) || won?(board))
    return true
  else
    return false
  end
end

def winner(board)
  won = won?(board)
  if(won)
     return board[won[0]]
  end
  return nil
end

def play(board)
  while(!over?(board))
    turn(board)
  end

  if (won?(board))
    if(winner(board) == "X")
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  elsif (draw?(board))
    puts "Cat's Game!"
  end
end
