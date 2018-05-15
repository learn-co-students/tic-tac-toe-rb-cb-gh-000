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
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input = user_input.to_i
  user_input -= 1
  if user_input < 0
    return -1
  else
    return user_input
  end
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] != " "
    true
  else
    false
  end
end

def valid_move?(board, index)
  if index >= 0 && index < 9
    if(position_taken?(board, index) != true)
      true
    end
  end
end

def turn(board)
  user_input = gets.strip
  user_input = input_to_index(user_input)
  if user_input > -1 && valid_move?(board, user_input)
    move(board, user_input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |value|
    if value == "X" || value == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if(turn_count(board).even?)
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if(board[combination[0]] == board[combination[1]])
      if(board[combination[0]] == board[combination[2]])
        if(position_taken?(board, combination[0]))
          return combination
        end
      end
    end
  end
  if board.all? { |value| value != "" }
    return false
  end
  return nil
end

def full?(board)
  if board.all? { |value| value != " " }
    true
  else
    false
  end
end

def draw?(board)
  is_full = full?(board)
  if !won?(board) && is_full
    return true
  end
  if !won?(board) && !is_full
    return false
  end
  if(won?(board))
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if(won?(board))
    win_line = won?(board)
    board[win_line[0]]
  else
    nil
  end
end

def play(board)
  while over?(board) == false do
    puts "Please enter a number between 1-9"
    turn(board)
    if draw?(board)
      break
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end
end
