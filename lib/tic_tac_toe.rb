
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
]

# Define display_board that accepts a board and prints
# out the current state.
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

def move(board, index, char)
  board[index] = char
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index > -1 && index < board.length && (board[index] != 'O' && board[index] != 'X')
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    char = current_player(board)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  counter = 0
  board.each do |_it|
    if _it == "O" || _it == "X"
      counter+=1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board, key = 0, win = WIN_COMBINATIONS)
  win.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      if key == 1
        if position_1 == "X"
          return "X"
        else
          return "O"
        end
      else
        return win_combination # return the win_combination indexes that won.
      end
    end
  end
  return false
end

def full?(board)
  board.each do |_it|
    if _it != 'O' && _it != 'X'
      return false
    end
  end
  return true
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if won?(board) != false
    return true # draw
  elsif won?(board) == false && full?(board) == true
    return true # won
  else
    return false # in progress
  end
end

def winner(board)
  if won?(board) != false
    res = won?(board, 1)
    return res
  else
    return nil
  end
end

def play(board)
  while !over?(board) && !draw?(board)
    turn(board)
  end
  a = winner(board)
  if a == nil
    puts "Cat's Game!"
  else
    if a == 'X'
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  end
end
