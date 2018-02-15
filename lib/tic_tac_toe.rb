# Methods

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

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

def move(array, index, data)
  array[index] = data
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(array, index)
  if index >= 0
    if array[index] && !position_taken?(array, index)
      return true
    else
      return false
    end
  else
    return false
  end
end

def turn(board)
  puts 'Please enter 1-9:'
  user_input = gets.strip()
  index = input_to_index(user_input)

  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0

  board.each do |i|
    if (i == "X" || i == "O")
      counter += 1
    end
  end

  return counter
end

def current_player(board)
  if turn_count(board) == 0
    return 'X'
  elsif turn_count(board) % 2 == 0
    return 'X'
  else
    return 'O'
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |i|
    board[i[0]] == board[i[1]] && board[i[0]] == board[i[2]] && position_taken?(board, i[1])
  end
end

def full?(board)
  if board.any? { |e| e == '' || e == ' ' || e == nil }
    return false
  else
    return true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    won_token = won?(board)
    return board[won_token[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end

  if winner(board) == 'X'
    puts 'Congratulations X!'
  elsif winner(board) == 'O'
    puts 'Congratulations O!'
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
