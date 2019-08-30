# Helper Methods
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

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =
[
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
  for win in WIN_COMBINATIONS
    if win.all? {|index| position_taken?(board, index) && board[index]==board[win[0]]}
      return win
    end
  end
  return false
end

def full?(board)
  full = true
  (0..8).each do |num|
    full = full && position_taken?(board, num)
  end
  return full
end

def draw?(board)
  return full?(board) && !won?(board) ? true : false
end

def over?(board)
  return won?(board) || draw?(board) ? true : false
end

def winner(board)
  won = won?(board)
  return won ? board[won[0]] : nil
end

def turn_count(board)
  pos_counter=0
  board.each do |position|
    if position != "" && position != " "
      pos_counter += 1
    end
  end
  return pos_counter
end

def current_player(board)
  # If current number of plays is even (0 is even), X goes next
  return turn_count(board).even? ? "X" : "O"
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
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
