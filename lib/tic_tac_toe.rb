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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(num)
  modified_num = num.to_i
  return modified_num - 1
end

def move(array, index, ch)
  array[index] = ch
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  if index < 0 || index > 8
    return false
  elsif position_taken?(board, index)
    return false
  else
    return true
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
    turn(board);
  end
end

def turn_count(board)
  counter = 0
  board.each do |val|
    if val != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  all_empty = board.all? {|x| x == " "}
  if all_empty == true
    return false
  end

  winningCombo = WIN_COMBINATIONS.detect do |combo|
    combo.all? {|x| board[x] == "X"} || combo.all? {|x| board[x] == "O"}
  end
end

def full?(board)
  !board.any?{|i| i == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if draw?(board)
    return true;
  elsif won?(board)
    return true;
  else
    return false;
  end
end

def winner(board)
  winningCombo = won?(board)
  if !winningCombo.nil?
    return board[winningCombo[0]]
  else
    return nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
