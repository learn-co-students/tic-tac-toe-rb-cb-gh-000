def valid_move?(board,index)
  if index < 0 || index > board.length - 1
    return false
  elsif position_taken?(board,index)
    return false
  end
  return true
end

def play(board)
  9.times do
    if over?(board)
      break
    end
    turn(board)
  end
  if won?(board)
    winner_player = winner(board)
    puts "Congratulations #{winner_player}!"
  else
    puts "Cats Game!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board,index)
    board[index] = current_player(board)
    display_board(board)
  else
    if !over?(board)
      turn(board)
    end
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
  return false
end


def turn_count(board)
  counter = 0
  board.each do |i|
    if i == 'X' || i == 'O'
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    return "X"
  else
    return "O"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n"
  puts " #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n"
  puts " #{board[6]} | #{board[7]} | #{board[8]} \n"
end


def input_to_index(input)
  integer = input.to_i
  if integer >= 1 && integer <= 9
    return integer-1
  else
    return -1
  end
end

def move(board,index,player)
  if valid_move?(board,index)
    board[index] = player
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if position_taken?(board,win[0]) && position_taken?(board,win[1]) && position_taken?(board,win[2]) && board[win[0]] == board[win[1]] && board[win[0]] == board[win[2]]
      return win
    end
  end
  return false
end

def full?(board)
  board.each do |player|
    if player != "X" && player != "O"
      return false
    end
  end
  return true
end

def draw?(board)
  if won?(board) == false && full?(board)
    return true
  elsif full?(board)
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
  return false
end

def winner(board)
  win = won?(board)
  if win != false
    return board[win[0]]
  end
end
