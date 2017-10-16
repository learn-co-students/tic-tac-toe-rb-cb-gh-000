
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(pos)
  return pos.to_i - 1
end

def move(board,index,value)
  board[index]=value
end

def position_taken?(board,index)
  if board[index]==" " || board[index]=="" || board[index]==nil
    return false
  else
    return true
  end
end

def valid_move?(board,index)
  if (index>=0 && index<9 && !(position_taken?(board,index)))
    return true
  else
    return false
  end
end


def turn(board)

  puts "Please enter 1-9:"
  position=gets.strip
  index=input_to_index(position)
  if(!valid_move?(board,index))
      turn(board)
  end
  move(board,index,current_player(board))

  display_board(board)
end

def turn_count(board)
  count=0
  board.each do |box|
    count = box!=" " ? count+1  : count
  end
  return count
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |pos|
    if(board[pos[0]] == board[pos[1]] && board[pos[1]] == board[pos[2]] && board[pos[0]]!= " ")
      return pos
    end
  end
  return false
end

def full?(board)
  return !(board.any? {|num| num == " " } )
end

def draw?(board)
  return !(won?(board)) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if (won?(board))
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  until (over?(board) || winner(board))
    turn(board)
  end
  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif (draw?(board))
    puts "Cats Game!"
  end
end
