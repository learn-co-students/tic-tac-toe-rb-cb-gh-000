def play(board)
  until over?(board) do
    turn(board)
  end
  if over?(board)
    if draw?(board)
      puts "Cat's Game!"
    elsif winner(board)
      puts "Congratulations " + winner(board) + "!"
    end
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    winCombo = combo.all? do |index|
      board[index] == "X"
    end
    if winCombo
      return combo
    end
    winCombo = combo.all? do |index|
      board[index] == "O"
    end
    if winCombo
      return combo
    end
  end
  return false
end

def full?(board)
  board.none? {|gameitem| gameitem == " "} #=> true
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  itemList = won?(board)
  if itemList
    return board[itemList[0]]
  else
    return nil
end
end

def turn_count(board)
  round = 0
  board.each do |boarditem|
    if boarditem  == "X" or boarditem  == "O"
      round +=1
    end
  end
  return round
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
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
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end
