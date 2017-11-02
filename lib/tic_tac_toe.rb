# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =[
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  # ETC, an array for each win combination
]
def won?(board)
  won = false
  WIN_COMBINATIONS.each do |fill|
      if position_taken?(board, fill[0]) && position_taken?(board, fill[1]) && position_taken?(board, fill[2])
        if board[fill[0]] == "X" && board[fill[1]] == "X" && board[fill[2]] == "X"
          won = fill
        elsif board[fill[0]] == "O" && board[fill[1]] == "O" && board[fill[2]] == "O"
          won = fill
        end
      end
  end
  won
end

def full?(board)
  full = true
  board.each do |section|

    if section == " " || section == nil

      full = false
      break
    end
  end
  full
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    if board[won?(board)[0]] == "X" && board[won?(board)[1]] == "X" && board[won?(board)[2]] == "X"
      winner = "X"
    elsif board[won?(board)[0]] == "O" && board[won?(board)[1]] == "O" && board[won?(board)[2]] == "O"
      winner = "O"
    end
  else
    winner = nil
  end
end

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
    token = ""
    if turn_count(board) % 2 == 0
      token = "X"
    else
      token = "O"
    end
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end
def current_player(board)
  if turn_count(board) % 2 == 0
    player = "X"
  else
    player = "O"
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" or space == "O"
      count += 1
    end
  end
  count
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
