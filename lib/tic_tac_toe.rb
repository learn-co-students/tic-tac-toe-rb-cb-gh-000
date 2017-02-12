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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  #index = index.to_i - 1
  if (index.between?(0,8) && !position_taken?(board, index))
    true
  else
    false
  end
end

def position_taken?(board,index)
  if (board[index] == nil || board[index] == " " || board[index] == "")
     false
  else
     true
  end
end

def input_to_index(move)
  move = move.to_i - 1
  move
end

def move(board,index,token)
  board[index] = token
end

def turn(board)
  puts "Please enter 1-9:"
  temp = gets.strip()
  val = input_to_index(temp)
  if (valid_move?(board, val))
    token = current_player(board)
    move(board, val, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |state|
    if (state == "X" || state == "O")
      count += 1
    end
  end
  count
end

def current_player(board)
  player = turn_count(board)
  if (player % 2 == 0)
    player = "X"
  else
    player = "O"
  end
end

def won?(board)
  temp = false
  WIN_COMBINATIONS.each do |row|
    win_index_1 = row[0]
    win_index_2 = row[1]
    win_index_3 = row[2]
    if (board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X")
      temp = row
    elsif(board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O")
      temp = row
    end
  end
  temp
end

def full?(board)
 full = true
 board.each do |val|
   if (val.nil? || val == " " || val == "")
      full = false
    end
 end
 full
end

def draw?(board)
  temp = true
  (!won?(board) && full?(board)) ? temp : temp = false
end


def over?(board)
  if (won?(board) || draw?(board))
    true
  else
    false
  end
end

def winner(board)
  val = nil
  if (won?(board))
    temp = won?(board)
    val = board[temp[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if (won?(board))
     val = winner(board)
     puts "Congratulations #{val}!"
  elsif (draw?(board))
     puts "Cats Game!"
  end
end
