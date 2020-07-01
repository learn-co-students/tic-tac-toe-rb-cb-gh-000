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
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end

def valid_move?(board, position)
  if position.between?(0,8) && position_taken?(board, position) != true
    true
  else
    false
  end
end

def turn_count(board)
  counter = 0
  board.each do |item|
    if item == "X" || item == "O"
      counter += 1
    else
      nil
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
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

def won?(board)
  WIN_COMBINATIONS.detect do |win_index|
    if board[win_index[0]] == "X" && board[win_index[1]] == "X" && board[win_index[2]] == "X"
      return win_index
    elsif board[win_index[0]] == "O" && board[win_index[1]] == "O" && board[win_index[2]] == "O"
      return win_index
    else
      false
    end
  end
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if won?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  winner = won?(board)
  if !winner
    nil
  else
    board[winner[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
    if draw?(board) || won?(board)
      break
    end
  end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
end
