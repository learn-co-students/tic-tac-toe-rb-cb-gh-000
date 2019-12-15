# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6],
  [1,4,7], [2,5,8], [0,4,8], [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each { |e|
    if (board[e[0]] =="X"&& board[e[1]] =="X"&& board[e[2]] == "X") || (board[e[0]] =="O"&& board[e[1]] =="O"&& board[e[2]] == "O")
      return e
    end
  }
  return nil
end

def full?(board)
  board.all? { |e| e=="X" || e=="O" }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
   draw?(board) || full?(board) || won?(board)
end

def winner(board)
  won?(board) == nil ? nil : board[won?(board)[0]]
end

def turn_count(board)
  count = 0
  board.each do |element|
    if element == "X" || element == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  count = turn_count(board)
  count % 2 == 1 ? "O" : "X"
end


def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def turn_count(board)
  board.count { |token| token == 'X' || token == 'O' }
end

def turn(board)
  puts 'Please enter 1-9:'
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board) == true
    puts "Cat's Game!"
  elsif winner(board) == "X"
    puts "Congratulations X!"
  else
    puts "Congratulations O!"
  end
end
