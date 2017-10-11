# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


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
  if board.select {| position | position == " "}.length == 9
    return false
  end

  WIN_COMBINATIONS.each { | combination |
    player = "X"

    2.times{
      if board[combination[0]] == player && board[combination[1]] == player && board[combination[2]] == player
        return combination
      end
      player = "O"
    }
  }
  return false
end

def full?(board)
  if board.select {| position | position == " "}.length == 0
    return true
  end
  false
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  WIN_COMBINATIONS.each { | combination |
    player = "X"

    2.times{
      if board[combination[0]] == player && board[combination[1]] == player && board[combination[2]] == player
        return player
      end
      player = "O"
    }
  }
  return nil
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
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

  until turn_count(board) == 9 || over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end

def turn_count(board)
  board.select{ | position | position != " "}.length
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end
