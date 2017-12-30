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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  return board.select{|e| e != " "}.length
end
def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
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

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
]

def end?(board)
  ["X", "O"].each do |token|
    WIN_COMBINATIONS.each do |combo|
      if combo.all?{|i| board[i] == token}
        puts "Congratulations #{token}!"
        return 1
      elsif board.each_index.select{|i| board[i] != " "}.length == 9
        puts "Cats game!"
        return 2
      else
        return false
      end
    end
  end
end

# these are just here to pass tests
def play(board)
  until over?(board) do
    turn(board)
  end
end

def winner(board)
  return won?(board)
end

def won?(board)
  ["X", "O"].each do |token|
    WIN_COMBINATIONS.each do |combo|
      if combo.all?{|i| board[i] == token}
        puts "Congratulations #{token}!"
        return token
      end
    end
  end
  return nil
end

def full?(board)
  return board.each_index.select{|i| board[i] != " "}.length == 9
end
def draw?(board)
  if (!won?(board) && full?(board))
    puts "Cat's Game!"
    return true
  else
    return false
  end
end

def over?(board)
  return won?(board) || draw?(board)
end
