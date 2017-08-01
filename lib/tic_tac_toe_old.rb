
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #TOP row
  [3,4,5], #MIDDLE row
  [6,7,8], #BOTTOM row
  [0,3,6], #LEFT COLLUM
  [1,4,7], #MIDDLE COLLUMN
  [2,5,8],  #RIGHT COLLUMN
  [0,4,8], #backward diagonals
  [6,4,2]  #forward diagonals
]

def play(board)
  flag = true
  while flag

    input = gets.strip
    player = current_player(board)
    puts player
    input_legit = input_to_index(input)
    move(board, input_legit, player)
    if over?(board)
      flag = false
    end
  end
  puts "end of game"
end

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(position)
  pos = position.to_i
  pos = pos - 1
  return pos
end

def move(board, index, character)
  board[index] = character
  return board
end

# code your #position_taken? method here!
def position_taken?(board, index)
  if (board[index] == " ") || (board[index] == "")
    return false
  elsif board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if(index >= 0 ) && (index <= 8)
    if position_taken?(board, index)
      return false
    else
      return true
    end
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  usr_input = gets.strip
  alt_input = input_to_index(usr_input)
  if valid_move?(board, alt_input)
    move(board,alt_input, "X")
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |index|
    (index == "X" || index == "O") ? count += 1 : count += 0
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
  #check if board is empty
  all_empty = board.all? do |empty|
    if empty == "" || empty == " "
      empty = true
    end
  end

  if all_empty
    return false
  end

  WIN_COMBINATIONS.each do |win_combination|
    # WINNING COMBINATION CONSTANTS
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] #board[0] = X
    position_2 = board[win_index_2] #board[1] = X
    position_3 = board[win_index_3] #board[2] = X

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    end

    if position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return false
end

def draw?(board)
  #checks for draw
  if won?(board)
    return false
  # else
  #   return true
  end

  if full?(board)
    return true
  end


  if board[0] == "X" && board[1] == "X" && board[2] == "X"
    return false
  elsif (board[0] == "X" && board[4] == "X" && board[8] == "X") || (board[2] == "X" && board[4] == "X" && board[6] == "X")
    return false
  end
  draw = board.all? do |occupied|
    if occupied == "X" || occupied == "O"
      occupied = true
    end
  end
  if draw
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    return true
  else
    return false
  end
end

def full?(board)

  inP = board.all? do |used|
    if used == "X" || used == "O"
      inP = true
    end
  end

  if inP
    return true
  else
    return false
  end

  if draw?(board)
    return true
  # else
  #   return false
  end
end

def winner(board)
  count_x = 0
  count_o = 0
  if won?(board) != false
    board.each do |i|
      if i == "X"
        count_x += 1
      end
      if i == "O"
        count_o += 1
      end
    end
    count_x > count_o ? "X" : "O"
  elsif over?(board)
    return false
  end


end
