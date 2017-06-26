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
  print " #{board[0]} | #{board[1]} | #{board[2]} \n"
  print "-----------\n"
  print " #{board[3]} | #{board[4]} | #{board[5]} \n"
  print "-----------\n"
  print " #{board[6]} | #{board[7]} | #{board[8]} \n"
end

def input_to_index(x)
    x.to_i-1
end

def move (bArray, bIndex, current_player)
  bArray[bIndex] = current_player
end

def valid_move?(board, index)
  if position_taken?(board, index) || (index<0 || index>8)
    return false
  else
    return true
  end
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
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

def turn_count(board)
  playCount = 0
  board.each do |playSpace|
    if playSpace == "X" || playSpace == "O"
      playCount+=1
    end
  end
  return playCount
end

def current_player(board)
  playerTurn = turn_count(board)
  if playerTurn % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won? (board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
  return win_combination
    end
  end
    return false
end

def full?(board)
  board.all?{|a| a!="" && a!=" " && a=!nil}
end

def draw?(board)
    !won?(board) && full?(board)
end

def over?(board)
 won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if !won?(board)
    return nil
  else
    win_combination = won?(board)
    win_index_1 = board[win_combination[0]]
    win_index_2 = board[win_combination[0]]
    win_index_3 = board[win_combination[0]]
    if win_index_1 == "X" && win_index_2 == "X" && win_index_3 == "X"
      return "X"
    elsif win_index_1 == "O" && win_index_2 == "O" && win_index_3 == "O"
      return "O"
    end
  end
end


def play (board)
  while !over?(board)
    turn(board)
  end

  if won?(board) != nil
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board) == true
  puts "Cats Game!"
  end
end
