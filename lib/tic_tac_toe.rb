# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" or space == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
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

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  else
    puts "Cats Game!"
  end
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    pos_1 = board[win_index_1]
    pos_2 = board[win_index_2]
    pos_3 = board[win_index_3]

    if (pos_1 == "X" and pos_2 == "X" and pos_3 == "X") or
       (pos_1 == "O" and pos_2 == "O" and pos_3 == "O")
       return combo
    end
  end
  return false
end

def full?(board)
  board.each do |space|
    if space != "X" and space != "O"
      return false
    end
  end
  return true
end

def draw?(board)
  if !won?(board) and full?(board)
    return true
  end
  return false
end

def over?(board)
  if won?(board) or draw?(board) or full?(board)
    return true
  end
  return false
end

def winner(board)
  if draw?(board)
    return nil
  end
  if over?(board)
    win_combo = won?(board)
    return board[win_combo[0]]
  end
end
