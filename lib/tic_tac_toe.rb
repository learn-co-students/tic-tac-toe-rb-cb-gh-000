def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end
# code your input_to_index and move method here!
def input_to_index(input)
  index = input.to_i
  index - 1
end

def move(board, index, character)
  board[index] = character
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
def valid_move?(board,index)
  !(index > 8 || index < 0) && !position_taken?(board,index)
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]

def won?(board)
  WIN_COMBINATIONS.detect do |win_index|
    position_1 = position_taken?(board,win_index[0]) ? board[win_index[0]] : 1
    position_2 = position_taken?(board,win_index[1]) ? board[win_index[1]] : 3
    position_3 = position_taken?(board,win_index[2]) ? board[win_index[2]] : 1
    position_1 == position_2 && position_2 == position_3
  end
end

def full?(board)
  board.all? do |square|
    square == "X" || square == "O"
  end
end

def draw?(board)
  (!won?(board) && full?(board))
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if over?(board) && !draw?(board)
    return board[won?(board)[0]]
  end
end

def turn_count(board)
  count = 0
  board.each do |square|
    if square == "X" || square == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
