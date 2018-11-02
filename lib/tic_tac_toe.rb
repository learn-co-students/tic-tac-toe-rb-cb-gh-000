def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player = "X")
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
    cur_play = current_player(board)
    move(board, index, cur_play)
    display_board(board)
  else
    turn(board)
  end
end
def turn_count(board)
  counter = 0
  board.each do |item|
    if item != " "
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
# Define your play method below
def play(board)
  if won?(board) != false
    return true
  end
  if draw?(board) == true
    return true
  while over?(board) == false
    turn(board)
  end
end


def won?(board)
  types = ["X", "O"]
  types.each do |type|
    WIN_COMBINATIONS.each do |win_comb|
      if board[win_comb[0]] == type && board[win_comb[1]] == type && board[win_comb[2]] == type
        return win_comb
      end
    end
  end
  return false
end

def full?(board)
  board.each do |boarditem|
    if boarditem == " "
      return false
    end
  end
  return true
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return true
  end
end

def over?(board)
  if won?(board)
    return true
  elsif full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != false
    winComb = won?(board)
    return board[winComb[0]]
  end
end
