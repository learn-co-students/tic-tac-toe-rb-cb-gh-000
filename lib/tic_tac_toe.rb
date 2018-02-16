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

def won?(board)
  a = board
  count = 0
  c1 = 0
  board.each do |ca|
    if ca != "X" && ca != "O"
      count += 1
    end
  end

alpha = nil
  if count < 9
    WIN_COMBINATIONS.each do |combination|
      win_op_1 = combination[0]
      win_op_2 = combination[1]
      win_op_3 = combination[2]
      position_1 = board[win_op_1]
      position_2 = board[win_op_2]
      position_3 = board[win_op_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        alpha = combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        alpha = combination
      end
    end
if alpha == nil
  return false
else
  return alpha
end
elsif count == 9
  return false
end
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

def move(board, position, character)
  if valid_move?(board, position)
    board[position] = character
  else
    return
  end
end

def valid_move?(board, index)
  if index.between?(0, 8)
    if !position_taken?(board, index)
      return true
    else 
      return false
    end
  else
    return false
  end
end


def position_taken?(board, index)
  bitem = board[index]
  if bitem == "" || bitem == " " || bitem == nil
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !move(board, index, current_player(board))
    return turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  number = turn_count(board)
  if number.even?
    return "X"
  elsif number.odd?
    return "O"
  else
    return "X"
  end
end

def won?(board)
  a = board
  count = 0
  c1 = 0
  board.each do |ca|
    if ca != "X" && ca != "O"
      count += 1
    end
  end

alpha = nil
  if count < 9
    WIN_COMBINATIONS.each do |combination|
      win_op_1 = combination[0]
      win_op_2 = combination[1]
      win_op_3 = combination[2]
      position_1 = board[win_op_1]
      position_2 = board[win_op_2]
      position_3 = board[win_op_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        alpha = combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        alpha = combination
      end
    end
if alpha == nil
  return false
else
  return alpha
end
elsif count == 9
  return false
end
end

def full?(board)
  val = board
  asdf = val.all? do |asd|
    asd == "X" || asd == "O"
  end
  if asdf == true
  return true
elsif asdf == false
    return false
end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) == true 
    return true
    elsif full?(board) == true
    return true
    elsif won?(board) != false
    return true
  else
    return false
  end
end

def winner(board)
  val = won?(board)
  if val == false
    return nil
  else
    winner = board[val[0]]
  return winner
end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
  puts "end of game"
end
    
