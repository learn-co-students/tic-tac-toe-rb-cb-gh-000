
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
WIN_COMBINATIONS= [[0,3,6],[0,1,2],[3,4,5],[6,7,8],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
# Define your WIN_COMBINATIONS constant
def won?(board)
  tanda=0
  WIN_COMBINATIONS.each do |ok|
    if board[ok[0]]== "X" && board[ok[1]]== "X" && board[ok[2]]=="X"
      tanda=2
      return ok
    elsif board[ok[0]]== "O" && board[ok[1]]== "O" && board[ok[2]]=="O"
      tanda=2
      return ok
    end
  end
  if tanda==0
    return false
  end
end

def full?(board)
  cek=0
  board.each do |bo|
    if bo==" "
      cek=1
    end
  end
  if cek==0
    return true
  else
    return false
  end
end

def draw?(board)
  as=won?(board)
  az=full?(board)
  if az==true && as==false
    return true
  end
end
def over?(board)
  isWon=won?(board)
  isDraw=draw?(board)
  isFull=full?(board)
  if isDraw==true
    return true
  end
  if isWon==false
    ada="ada"
  else
    return true
  end
  if isFull==false
    return false
  end
end

def winner(board)
  ab=won?(board)
  if ab==false
    return nil
  elsif board[ab[0]]=="X" && board[ab[1]]=="X" && board[ab[2]]=="X"
    return "X"
  elsif board[ab[0]]=="O" && board[ab[1]]=="O" && board[ab[2]]=="O"
    return "O"
  end
end
# Define 'your play method below
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
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,"X")
    display_board(board)
  else
    turn(board)
  end
end
def turn_count(board)
  tes=0
  board.each do |ordinat|
    if ordinat != " "
      tes=tes+1
    end
  end
  return tes
end
def current_player(board)
  a=turn_count(board)

  if a%2 ==1
      return "O"
  else
    return "X"
  end
end

def play(board)
  turn(board)
    if over?(board)
        if draw?(board)
            puts "Cats Game!"
        elsif won?(board)
            puts "Congratulations #{winner(board)}!"
        end
    else
        play(board)
    end
end
