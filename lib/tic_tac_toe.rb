
WIN_COMBINATIONS = [
   [0,1,2],
   [3,4,5],
   [6,7,8],
   [0,3,6],
   [1,4,7],
   [2,5,8],
   [0,4,8],
   [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} |"
  puts " #{board[3]} | #{board[4]} | #{board[5]} |"
  puts "-----------"
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} |"
end

def input_to_index(number)
  if number.is_a? Integer
    return number
  else
    return number.to_i - 1
  end
end

def move(board, index, token)
  board[input_to_index(index)] = token
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if(position_taken?(board, index) == false && index.between?(0,8))
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  result = false
  WIN_COMBINATIONS.each do |combo|
      if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
        result = [combo[0], combo[1], combo[2]]
      elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
        result = [combo[0], combo[1], combo[2]]
      end
  end
  return result
end

def full?(board)
  full_board = board.all? do |number|
     number != " " && number != "" && number != nil
  end
  return full_board
end

def draw?(board)
  won = won?(board)
  isFull = full?(board)
  if won == false && isFull == true
    return true
  elsif won != false && isFull == false
    return false
  elsif won == false && isFull == false
    return false
  end
end

def over?(board)
  if draw?(board) || full?(board) || won?(board) != false
    return true
  else
    return false
  end
end

def winner(board)
  token = won?(board)
  if token != false
    return board[token[0]]
  else
    return nil
  end
end

def turn_count(board)
  count = 0
  board.each do |num|
    if num == "X" || num == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  player = turn_count(board)
  if player > 0 && player.odd?
    return "O"
  else
    return "X"
  end
end

def play(board)
  while over?(board) != true do
    turn(board)
  end

  if winner(board) != nil
    boss = winner(board)
    if boss == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  else
    puts "Cat's Game!"
  end
end
