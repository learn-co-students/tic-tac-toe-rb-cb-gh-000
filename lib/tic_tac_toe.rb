def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
##############################################################
def input_to_index(input)
  index=input.to_i
  index=index-1
  return index
end
##############################################################
def move(board,index,player_char)
  board[index]=player_char
end
##############################################################
def position_taken?(board, index)
  if (board[index]==" " || board[index]=="" || board[index]==nil)
    return false
  elsif (board[index]=="X" || board[index]=="O")
    return true
  end
end
###############################################################
def valid_move?(board, index)
  if (index>=0 && index <=8 && board[index]==" ")
    return true
  end
end
###############################################################
def turn(board)
  puts "Please enter 1-9:"
  num=gets.strip
  input_to_index(num)
  index=num.to_i
  index=index-1
  while !(valid_move?(board, index))
    puts "Please enter 1-9:"
    num=gets.strip
    input_to_index(num)
    index=num.to_i
    index=index-1
  end
  move(board,index,current_player(board))
  display_board(board)
end
##############################################################
def turn_count(board)
  number=0
  board.each do |turn|
    if (turn!=" ")
      number=number+1
    end
  end
    return number
end
################################################################
def current_player(board)
  number=turn_count(board)
  if number%2==0
    return "X"
  else
    return "O"
  end
end
#################################################################
WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  x=Array.new
  o=Array.new
  num=0
  until num==9 do
    if board[num]=="X"
      x << num
    elsif board[num]=="O"
      o << num
    end
    num=num+1
  end
  num=0
  until num==WIN_COMBINATIONS.length do
    i=0
    j=0
    WIN_COMBINATIONS[num].each do|n|
      if x.include? n
        i=i+1
      end
      if o.include? n
        j=j+1
      end
    end
    if i==3
      return x
    elsif j==3
      return o
    end
    num=num+1
  end
  return false
end

def full?(board)
  num=0
  until num==9 do
    if board[num]==" "
      return false
    end
    num=num+1
  end
  return true
end

def draw?(board)
  full?(board)
  won?(board)
  x=Array.new
  o=Array.new
  num=0
  until num==9 do
    if board[num]=="X"
      x << num
    elsif board[num]=="O"
      o << num
    end
    num=num+1
  end
  num=0
  until num==WIN_COMBINATIONS.length do
    i=0
    j=0
    WIN_COMBINATIONS[num].each do|n|
      if x.include? n
        i=i+1
      end
      if o.include? n
        j=j+1
      end
    end
    if i==3 || j==3
      return false
    end
    num=num+1
  end
  return true
end

def over?(board)
  full?(board)
end

def winner(board)
  x=Array.new
  o=Array.new
  num=0
  until num==9 do
    if board[num]=="X"
      x << num
    elsif board[num]=="O"
      o << num
    end
    num=num+1
  end
  num=0
  until num==WIN_COMBINATIONS.length do
    i=0
    j=0
    WIN_COMBINATIONS[num].each do|n|
      if x.include? n
        i=i+1
      end
      if o.include? n
        j=j+1
      end
    end
    if i==3
      return "X"
    elsif j==3
      return "O"
    end
    num=num+1
  end
end

def play(board)
  while over?(board)==false do
    turn(board)
    if winner(board)=="X"
      puts "Congratulations X!"
      break
    elsif winner(board)=="O"
      puts "Congratulations O!"
      break
    end
  end
  if over?(board)==true && winner(board) !="X" && winner(board) !="O"
    puts "Cats Game!"
  end
end
