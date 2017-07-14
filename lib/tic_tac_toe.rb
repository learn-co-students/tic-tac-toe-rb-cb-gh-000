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

def move(board, index,current_player)
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end

def turn_count(board)
  counter = 0
  board.each do |tile|
    if tile == "X" || tile == "O"
      counter+=1
    end
  end
  return counter
end
def current_player(board)
  return turn_count(board)%2==0 ? "X" : "O"
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if (board[win[0]]=="X" && board[win[1]]=="X" && board[win[2]]=="X") || (board[win[0]]=="O" && board[win[1]]=="O" && board[win[2]]=="O")
      return [win[0],win[1],win[2]]
    end
  end
  return false
end
def full?(board)
  board.all? {|tile| tile!=" "}
end
def draw?(board)
  return !won?(board) && full?(board)
end
def over?(board)
  return won?(board) || full?(board)
end
def winner(board)
  WIN_COMBINATIONS.each do |win|
    if board[win[0]]=="X" && board[win[1]]=="X" && board[win[2]]=="X"
      return "X"
    elsif board[win[0]]=="O" && board[win[1]]=="O" && board[win[2]]=="O"
      return "O"
    end
  end
  return nil
end
