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

def won?(board)
  WIN_COMBINATIONS.each do |win|
    win_comb_1 = win[0]
    win_comb_2 = win[1]
    win_comb_3 = win[2]
    pos_1 = board[win_comb_1]
    pos_2 = board[win_comb_2]
    pos_3 = board[win_comb_3]

    if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
      return ([win_comb_1, win_comb_2, win_comb_3])
    elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
      return ([win_comb_1, win_comb_2, win_comb_3])
    end
  end
  return false
end

def full?(board)
  board.each do |b|
    if b == " "
      return false
    end
  end
  return true
end

def draw?(board)
  full = full?(board)
  won = won?(board)
  if full == true && won == false
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != false
    position = won?(board)[0]
    return board[position]
  end
end

def input_to_index(move)
  return move.to_i - 1
end

def move(board, position, char)
    board[position] = char
    return board
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index <= 8 && index >= 0
    return true
  else
    return false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  else
    return false
  end
end

def welcome()
  puts "Welcome to Tic Tac Toe!"
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  index = input_to_index(position)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
  turn(board)
end
end
def turn_count(board)
turn_left = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      turn_left +=1
    end
  end
  return turn_left
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else
    return "O"
  end
end

def play(board)
  until over?(board) == true
    turn(board)
    if won?(board) != false
      puts "Congratulations #{winner(board)}!"
    end
  end
  if draw?(board) == true
    puts "Cats Game!"
  elsif won?(board) != false
    puts "Congratulations #{winner(board)}!"
  end
end
