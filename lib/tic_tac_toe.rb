def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    postion_taken = true
  else
    position_taken = false
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    true
  else
    false
  end
end


def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board,index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |position|
    if position == "X" || position == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    player = "X"
  else
    player = "O"
  end
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Top left diagonal
  [6,4,2],  # Top right diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      win = true
      return win_combination
    else
      win = false
    end
  end
  if win = false
    return win
  end
end

def full?(board)
  full = true
  board.each do |i|
    if i == " "
      full = false
    end
  end
  full
end

def draw?(board)
  draw = false
  if !won?(board) && full?(board)
    draw = true
  else
    draw = false
  end
  draw
end

def over?(board)
  isover = false
  if won?(board).is_a?(Array) || draw?(board) == true
    isover = true
  end
  isover
end

def winner(board)
  win = won?(board)
  winner = nil
  if win.is_a?(Array)
    if board[win[1]] == "X"
      winner = "X"
    elsif board[win[1]] == "O"
      winner = "O"
    end
  end
end

def play(board)
  until over?(board) || won?(board)
    turn(board)
  end
  if won?(board).is_a?(Array)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
