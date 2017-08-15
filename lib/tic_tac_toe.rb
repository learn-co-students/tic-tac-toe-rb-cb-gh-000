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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    ['X', 'O'].each do |token|
      if win_combination.all? { |e| board[e] == token }
        return win_combination
      end
    end
  end
  return false
end

def full?(board)
  index = 0
  while index < 9
    if board[index] == " "
      return false
    end
    index += 1
  end
  return true
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  win_combination = won?(board)
  if win_combination
    return board[win_combination[0]]
  end
  return nil
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "Invalid move"
    turn(board)
  end
end

def turn_count(board)
  turn_count = 0
  board.each do |token|
    if token != '' && token != ' '
      turn_count += 1
    end
  end
  return turn_count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return 'X'
  else
    return 'O'
  end
end


# Define your play method below

def play(board)
  until over?(board)
    turn(board)
  end

  winner = winner(board)
  if winner
    puts "Congratulations #{winner}!"
  else
    puts "Cats Game!"
  end
end
