WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def display_board(board)
  index = 0

  while index <= 6
    puts " #{board[index]} | #{board[index+1]} | #{board[index+2]} "

    if index != 6
      puts "------------"
    end
    index += 3
  end
end

def input_to_index(input)
  return input.to_i-1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  return board[index] != " "
end

def valid_move?(board, index)
  if index > board.length || index < 0
    return false
  end

  return !position_taken?(board,index)
end

def turn(board)
  puts "Choose a position between: 1-9"
  input = gets.strip
  index = input_to_index(input)

  while !valid_move?(board,index)
    puts "Choose a position between: 1-9"
    input = gets.strip
    index = input_to_index(input)
  end
  move(board,index, current_player(board))
end

def turn_count(board)
  turns = 0
  board.each{|cell|
    if cell != " "
      turns += 1
    end
  }
  return turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each{|combo|
    if board[combo[0]] != " " && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
      return combo
    end
  }
  return false
end

def full?(board)
  board.each{|cell|
    if cell == " "
      return false
    end
  }
  return true
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  wincomb = won?(board)
  if wincomb == false
    return nil
  else
    return board[wincomb[1]]
  end
end

def play(board)
  until over?(board)
    puts "Choose position: 1-9"
    input = gets.strip
    index = input_to_index(input)
    move(board,index, current_player(board))
  end

winner = winner(board)
if winner != nil
  puts "Congratulations #{winner}!"
end

if draw?(board)
  puts "Cat's Game!"
end

end
