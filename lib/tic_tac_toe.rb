

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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
  WIN_COMBINATIONS.each do |combo|
    pos1 = combo[0]
    pos2 = combo[1]
    pos3 = combo[2]

    el1 = board[pos1]
    el2 = board[pos2]
    el3 = board[pos3]

    if (el1 == "X" && el2 == "X" && el3 == "X")
      return combo
    elsif (el1 == "O" && el2 == "O" && el3 == "O")
      return combo
    else
      false
    end
  end
  false
end


def full?(board)
  board.each do |el|
    if (el == " ")
      return false
    end
  end
  return true
end

def draw?(board)
  return (!won?(board) && full?(board))
end

def over?(board)
  return won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    arr = won?(board)
    pos = arr[0]
    return board[pos]
  else
    return nil
  end
end


# Helper Methods
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  valid = false
  player = current_player(board)
  while (!valid)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    valid = valid_move?(board, index)
  end
  move(board, index, player)
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |el|
    if (el == " ")
      counter += 1
    end
  end
  return 9-counter
end

def current_player(board)
  player = turn_count(board)
  player = player % 2
  if player == 1
    return "O"
  else
    return "X"
  end
end

def play(board)
  done = false
  while (!done) do
    turn(board)
    done = over?(board)
  end
  if (won?(board))
    win = winner(board)
    puts "Congratulations #{win}!"
  else
    puts "Cats Game!"
  end
end
