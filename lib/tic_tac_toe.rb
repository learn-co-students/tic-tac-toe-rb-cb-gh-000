def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def valid_move?(board,index)
  if index.between?(0,8) and !position_taken?(board,index)
    return true
  else
     return nil
  end
end

def position_taken?(board,index)
  if board[index] == "" or board[index] == " " or board[index] == nil
    return false
  elsif board[index] == 'X' or board[index] == "O"
    return true
  end
end
def input_to_index(a)
  a = a.to_i
  a = a - 1
end
def move(board,index,player)
  #index = input_to_index(index)
  board[index] = player
end

def turn(board)
  puts "Please enter 1-9:"
  int = gets.strip

  int = input_to_index(int)

  if valid_move?(board,int)
    move(board,int,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |element|
    (element == "X" or element =="O") ? counter +=1 : counter
  end
  counter
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end

WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],[1,4,7],[0,3,6],[5,2,8],[0,4,8],[2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.detect do |element|
    element.all? {|x| board[x] == "X"} or element.all? {|o| board[o] == "O"}
  end
end

def full?(board)
  board.all? do |ind|
    !(ind.nil? || ind == " ")
  end
end

def draw?(board)
  full?(board) and !won?(board)
end

def over?(board)
  full?(board) or won?(board) or draw?(board)
end

def winner(board)
  x = won?(board)
  if x
    if x.all? {|a| board[a] == "X"}
      "X"
    elsif x.all? {|a| board[a] == "O"}
      "O"
    end
  else
    nil
  end
end

def  play(board)
  until over?(board) do
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
