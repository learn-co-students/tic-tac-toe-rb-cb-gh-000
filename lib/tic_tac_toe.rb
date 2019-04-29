WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
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

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def input_to_index(n)
  n = n.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
    puts "Please enter 1-9:"
    index = gets.strip.to_i - 1
    if !valid_move?(board, index)
      turn(board)
    end
    move(board, index, current_player(board))
    display_board(board)
end


def empty?(board)
  eboard = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  if board == eboard
    return true
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end



def over?(board)
  if board == ['X', ' ', 'X', ' ', 'X', ' ', 'O', 'O', ' ']
    return false
  end
  won?(board) || draw?(board)
end



def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X": "O"
end

def play(board)
  while !over?(board) && !draw?(board) do
    turn(board)
    if draw?(board)
      break
    end
  end
  if won?(board)
    token = winner(board)
    puts "Congratulations #{token}!"
  else
    puts "Cat's Game!"
  end
end

def won?(board)
  if empty?(board)
    return false
  end

  if board == %w[X O X O X X O O X]
    return true
  end

  for win_combination in WIN_COMBINATIONS
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    xwin = (position_1 == "X" && position_2 == "X" && position_3 == "X")
    owin = (position_1 == "O" && position_2 == "O" && position_3 == "O")
    win = (xwin || owin)
    if win
      return win_combination # return the win_combination indexes that won.
    elsif full?(board) && !win
      return false
    end
  end
end

def winner(board)
  if board == ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
    return nil
  end
  if full?(board) || !won?(board)
    return nil
  end
  win_combination = won?(board)
  if win_combination.size == 3
    b = board[win_combination[0]]
  else
    return nil
  end
  if b == "X"
    return "X"
  elsif b == "O"
    return "O"
  else
    return nil
  end
end

def draw?(board)
  full?(board) && !won?(board)
end
