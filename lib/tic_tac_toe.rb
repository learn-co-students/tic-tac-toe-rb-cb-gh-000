WIN_COMBINATIONS =[
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

def display_board(board = [" "," "," "," "," "," "," "," "," "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1

end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  !position_taken?(board, index) and index.between?(0, 8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    puts "invalid input"
    turn(board)
  end
end

def turn_count(board)
  counter =  0
  board.each do |element|
    if element != " " #and element != ""
      counter += 1
    end
  end
  counter
end

def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    "X"
  else
    "O"
  end
end
# Define your WIN_COMBINATIONS constant

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
    end
  end
  return false
end

def full?(board)
  board.all?{|value| value == "X" or value == "O"}
end

def draw?(board)
  if won?(board) == false and full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) != false or draw?(board) or full?(board)
    true
  else
    false
  end
end

def winner(board)
  winner = won?(board)
  if winner != false
    if board[winner[0]] == "X"
      "X"
    else
      "O"
    end
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
