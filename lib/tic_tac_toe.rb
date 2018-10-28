def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6]]



def input_to_index(input)
  index=input.to_i
  return index-1
end

def move(board,index,char)
  board[index]=char
end

def position_taken?(board,index)
  if board[index-1]=="X"||board[index-1]=="O"
    return true
  else
    return false
  end
end

def valid_move?(board,index)
  if (index<=9) && (index>=1) && (position_taken?(board,index))
    return true
  else
    return false
  end
end

def turn(board)
  puts "enter the input"
  input=gets
  index=input_to_index(input)
    if valid_move?(board,index)
      puts "Enter the character"
      char=gets
      move(board,index,char)
      display_board(board)
    else
      puts "please enter a valid move"
      turn(board)
    end
end


def turn_count(board)
  counter=0
  board.each do |item|
    if item=="X"||item=="O"
      counter+=1
    end

    end
 return counter
end


def current_player(board)
  current=turn_count(board)
  if current.odd?
    return "O"
  else
    return "X"
  end

end


def win?(board)
  WIN_COMBINATIONS.any?{|i|
   (i.all? do |j|
   board[j]=='X'
  end)||(i.all? do |j|
   board[j]=='O'
  end)
  }
end


def full?(board)
  board.all? do |i|
    i=='X'||i=='O'
  end
end

def draw?(board)
  if full?(board) && !(win?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if win?(board)||draw?(board)||full?(board)
    return true
  else
    return false
  end
end


def winner(board)
  if win?(board)
    display_board(board)
    current_player(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if win?(board)
    puts "congrats"
  else
    puts "Draw Match"
  end
end


play(["","","","","","","","",""])
