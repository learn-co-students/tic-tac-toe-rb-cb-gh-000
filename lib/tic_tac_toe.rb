# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],  # Diagonal right
  [2,4,6] # Diagonal left
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
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turns = turn_count(board)
  turns % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
    # print "#{win_combination}\n"
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3
    # print "These are the current positions: #{position_1}, #{position_2}, #{position_3}\n"

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      # print "These are the current positions: #{position_1}, #{position_2}, #{position_3}\n"
      return win_combination # return the win_combination indexes that won.
    else
      false
    end
  end
  false
end

def full?(board)
  i = 0
  while i < board.size
    if !position_taken?(board, i)
      false
      break
    end
    i += 1
  end
  i == 9 ? true : false
end

def draw?(board)
  if !won?(board) == false
    false
  else
    full?(board)
  end
end

def over?(board)
  won?(board) || full?(board) || draw?(board) ? true : false
end

def winner(board)
  if won?(board)
    win_combination = won?(board)
    # print win_combination
    return board[win_combination[0]]
  else
    return nil
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
    if won?(board)
      break
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    return
  else
    puts "Cats Game!"
  end
end

board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
play(board)
