# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

#methods
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
  return false
end

def full?(board)
    board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  if won?(board)==false&&full?(board)==true
    return true
  end
end

def over?(board)
  if draw?(board)||won?(board)||full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  win_combination=won?(board)
  if(win_combination!=false)
    winning=board[win_combination[0]]
    return winning
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
  is_x=true
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end
def turn_count(board)
  turns_played=0
  board.each do |square|
    if square=="X"||square=="O"
      turns_played+=1
    end
  end
  return turns_played
end

def current_player(board)
  x_count=0
  o_count=0
  board.each do |square|
    if turn_count(board)%2==0
      return "X"
    else
      return "O"
    end
  end
end

# Define your play method below
def play(board)

  until over?(board)==true
    turn(board)
  end
  if won?(board)
    if winner(board) =="X"
      puts "Congratulations X!"
    elsif winner(board) =="O"
      puts "Congratulations O!"
    end
  else
      puts "Cat's Game!"
  end
end
