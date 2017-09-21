
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def won?(board)
  winning_arr = []
  WIN_COMBINATIONS.each do |arr|
    if board[arr[0]] != " " && board[arr[0]] == board[arr[1]] && board[arr[1]] == board[arr[2]]
      winning_arr.push(arr[0]).push(arr[1]).push(arr[2])
    end
  end

  if winning_arr == []
    false
  else
    winning_arr
  end
end

# board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
  def full?(board)
    if board.select{|i| i == " "}.length == 0
      true
    end
  end

# board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
  def draw?(board)
    if won?(board) == false && full?(board)
      true
    end
  end

def over?(board)
  if draw?(board) || won?(board)
    true
  end
end

def winner(board)
  if won?(board) != false
    board[won?(board)[0]]
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def valid_move?(board, position)
  if position > 8 || position < 0
    false
  else
    if board[position] != " "
      false
    else
      true
    end
  end
end

def turn(board)
  i = gets
  index = input_to_index(i)

  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    i= gets
  end
end

def turn_count(board)
  board.select{|i| i == "X" || i == "O"}.length
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board) != []
    puts "Congratulations #{winner(board)}!"
  end

  if draw?(board)
    puts "Cats Game!"
  end

end
