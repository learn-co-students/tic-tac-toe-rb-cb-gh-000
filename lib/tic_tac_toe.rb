
WIN_COMBINATIONS = [
  [0, 1, 2], #top row wins
  [3, 4, 5], #middle row wins
  [6, 7, 8], #bottom row wins
  [0, 3, 6], #l colum wins
  [1, 4, 7], #M colum wins
  [2, 5, 8], #R colum wins
  [0, 4, 8], #diagonal wins
  [2, 4, 6]  #diagonal wins
]

def display_board(input)
  puts " #{input[0]} ""|"" #{input[1]} ""|"" #{input[2]} "
  puts "-----------"
  puts " #{input[3]} ""|"" #{input[4]} ""|"" #{input[5]} "
  puts "-----------"
  puts " #{input[6]} ""|"" #{input[7]} ""|"" #{input[8]} "
end

def input_to_index(input)
  int = input.to_i
  index = int - 1
  return index
end

def move(board, index, char = "X")
  board[index] = char
end

def position_taken?(board, index)
  if board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  else
    return true
  end
end

def move(board, index, char)
  board[index] = char
end

def valid_move?(board, index)
  int = index.to_i
  if int.between?(0, 8) && position_taken?(board, index) == false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) && current_player(board) == "X"
    move(board, index, "X")
    display_board(board)
  elsif valid_move?(board, index) && current_player(board) == "O"
    move(board, index, "O")
    display_board(board)
  else
    turn(board)
  end
  return nil
end

def turn_count(board)
  playCount = 0
  board.each do |occupied|
    if occupied == "X" || occupied == "O"
      playCount += 1
    end
  end
  return playCount
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  x = "X"
  o = "O"
  counterX = 0
  counterY = 0

  WIN_COMBINATIONS[0].each do |win_combination|
    checkFor = board[win_combination]
     if checkFor.include?(x)
      counterX += 2
     elsif checkFor.include?(o)
      counterY += 1
     end
  end
  # puts counter
  if counterX == 6 || counterY == 3
    # puts WIN_COMBINATIONS[0]
    return WIN_COMBINATIONS[0]
  end

  counterX = 0
  counterY = 0

  WIN_COMBINATIONS[1].each do |win_combination|
    checkFor = board[win_combination]
     if checkFor.include?(x)
      counterX += 2
     elsif checkFor.include?(o)
      counterY += 1
     end
  end
  # puts counter
  if counterX == 6 || counterY == 3
    # puts WIN_COMBINATIONS[1]
    return WIN_COMBINATIONS[1]
  end

  counterX = 0
  counterY = 0

  WIN_COMBINATIONS[2].each do |win_combination|
    checkFor = board[win_combination]
     if checkFor.include?(x)
      counterX += 2
     elsif checkFor.include?(o)
      counterY += 1
     end
  end
  # puts counter
  if counterX == 6 || counterY == 3
    # puts WIN_COMBINATIONS[2]
    return WIN_COMBINATIONS[2]
  end

    counterX = 0
    counterY = 0

  WIN_COMBINATIONS[3].each do |win_combination|
    checkFor = board[win_combination]
     if checkFor.include?(x)
      counterX += 2
     elsif checkFor.include?(o)
      counterY += 1
     end
  end
  # puts counter
  if counterX == 6 || counterY == 3
    # puts WIN_COMBINATIONS[3]
    return WIN_COMBINATIONS[3]
  end

  counterX = 0
  counterY = 0

  WIN_COMBINATIONS[4].each do |win_combination|
    checkFor = board[win_combination]
     if checkFor.include?(x)
      counterX += 2
     elsif checkFor.include?(o)
      counterY += 1
     end
  end
  # puts counter
  if counterX == 6 || counterY == 3
    # puts WIN_COMBINATIONS[4]
    return WIN_COMBINATIONS[4]
  end

  counterX = 0
  counterY = 0

  WIN_COMBINATIONS[5].each do |win_combination|
    checkFor = board[win_combination]
     if checkFor.include?(x)
      counterX += 2
     elsif checkFor.include?(o)
      counterY += 1
     end
  end
  # puts counter
  if counterX == 6 || counterY == 3
    # puts WIN_COMBINATIONS[5]
    return WIN_COMBINATIONS[5]
  end

  counterX = 0
  counterY = 0

  WIN_COMBINATIONS[6].each do |win_combination|
    checkFor = board[win_combination]
     if checkFor.include?(x)
      counterX += 2
     elsif checkFor.include?(o)
      counterY += 1
     end
  end
  # puts counter
  if counterX == 6 || counterY == 3
    # puts WIN_COMBINATIONS[6]
    return WIN_COMBINATIONS[6]
  end

  counterX = 0
  counterY = 0

  WIN_COMBINATIONS[7].each do |win_combination|
    checkFor = board[win_combination]
     if checkFor.include?(x)
      counterX += 2
     elsif checkFor.include?(o)
      counterY += 1
     end
  end
  # puts counter
  if counterX == 6 || counterY == 3
    # puts WIN_COMBINATIONS[7]
    return WIN_COMBINATIONS[7]
  end
  return false
end

def full?(board)
  find = board.find {|key, value| key == " "}
  if find == " "
    # puts false
    return false
  else
    # puts true
    return true
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    # puts "board not been won but is full"
    return true
  # elsif won?(board) == false && full?(board) == false
  #   # puts "not full not won"
  #   return false
  else
    # puts "board is won"
    return false
  end
end

def over?(board)
  if won?(board) ==  false && full?(board) == true
    # puts "true for draw"
    return true
  elsif full?(board) == true && won?(board) != false
    # puts "true for won game when board is full"
    return true
  elsif full?(board) == false && won?(board) != false
    # puts "true for won game when board in not full"
    return true
  else
    # puts "in progress game"
    return false
  end
end

def winner(board)
  x = "X"
  o = "O"
  counterX = 0
  counterY = 0

  if won?(board) == false
    return nil
  end

  won?(board).each do |win_combination|
    checkFor = board[win_combination]
    if checkFor.include?(x)
      counterX += 2
    elsif checkFor.include?(o)
      counterY += 1
    end
  end

  if counterX == 6
    # puts "X"
    return "X"
  elsif counterY == 3
    # puts "O"
    return "O"
  end
end

def play(board)

  until over?(board) == true || draw?(board) == true
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
  return nil
end
