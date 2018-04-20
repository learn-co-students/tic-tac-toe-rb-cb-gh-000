def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
#horizontal
[0,1,2],
[3,4,5],
[6,7,8],
#vertical
[0,3,6],
[1,4,7],
[2,5,8],
#diagonal
[0,4,8],
[2,4,6]
]

def turn(board)
  puts "Please enter 1-9:"
  i = gets.strip
  index = input_to_index(i)
  m = valid_move?(board, index)
  if m == true
    move(board, index, current_player(board))
  else m == false
    until m == true
      puts "Sorry, that was an invalid move. Please enter 1-9:"
      display_board(board)
      i = gets.strip
      index = input_to_index(i)
      m = valid_move?(board, index)
      move(board, index, current_player(board))
    end
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def move(board, index, char)
  board[index] = char
  turn_count(board)
  display_board(board)
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

def won? (board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
else
  false
end

def full? (board)
  board.all? do |check_space|
    check_space == "X" || check_space == "O"
  end
end

def draw? (board)
  if won?(board)
    false
  elsif full?(board)
    true
  else
    false
  end
end

def over? (board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner (board)
  if won?(board)
    winning_combo = won?(board)
    first = winning_combo[0]
    board[first]
  end
end

def turn_count (board)
  num_turns = 0
  board.each do |token|
    if token == "X" || token == "O"
      num_turns += 1
    end
  end
  return num_turns
end

def current_player (board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if draw?(board) == true
    puts "Cat's Game!"
  else won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
