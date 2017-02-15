WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  # ETC, an array for each win combination
  [6,7,8], [0,3,6], [1,4,7],[2,5,8],[0,4,8],[2,4,6],

]

def won?(board)
  WIN_COMBINATIONS.each{|comba|
    if board[comba[0]]==board[comba[1]] && board[comba[0]]!=" "&& board[comba[0]]!=""
      if board[comba[1]]==board[comba[2]]
        return board=[comba[0],comba[1],comba[2]]
      end
    end
  }
  return false
end

def full?(board)
  board.all?{|char| char=="X" or char=="O"}
end

def draw?(board)
  full=full?(board)
  won=won?(board)
  if !full
    return false
  end
return !won
end

def over?(board)
  if won?(board)
    true
  elsif draw?(board)
    true
  elsif full?(board)
    true
  else
    false
  end
end

def winner(board)
  winnerIndex=won?(board)
  if won?(board)
    return board[winnerIndex[0]]
  end
end

def display_board(board=[" "," "," "," "," "," "," "," "," "])
  def row(num,board)
    puts " #{board[0+num]} | #{board[1+num]} | #{board[2+num]} "
  end
  def breaks
    puts "-----------"
  end
  row(0,board)
  breaks
  row(3,board)
  breaks
  row(6,board)
end

def input_to_index(index="1")
  indexInt=index.to_i-1
  return indexInt
end

def move(board,index, character)
  board[index]=character
end

def valid_move?(board,index)
  if index.between?(0,8)==false
   false
 else
   !position_taken?(board,index)
 end
end
# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


=begin def turn(board)
  puts "Please enter 1-9:"
  input=gets.strip
  while 1
    index=input_to_index(input)
    valid=valid_move?(board,index)
    if valid
      board=move(board,index)
      display_board(board)
      break
    end
    puts "#{input} is not a valid number.Enter another between 1-9"
    input=gets.strip
  end
end
=end
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def move(board,index, character)
  board[index]=character
  return board
end

def turn_count(board)
  count=0
  board.each { |char|
    if char=="X" or char=="O"
      count+=1
    end
    }
  return count
end

def current_player(board)
  num=turn_count(board)
  if num%2==1
    return "O"
  else
    return "X"
  end
end

=begin def play(board)
  count=true
  while 1
    index=input_to_index(input)
    valid=valid_move?(board,index)
    if valid
      board=move(board,index)
      display_board(board)
      break
    end
    puts "#{input} is not a valid number.Enter another between 1-9"
    input=gets
  end
  while count
    if over?(board)
      count=false
      if won?(board)
        winn=winner(board)
        puts "Congratulations #{winn}!"
      end
      if draw?(board)
        puts "Cats Game!"
      end
    end
    if count == true
      turn(board)
    end
  end
end
=end 
def play(board)
    until   over?(board)

turn(board)

    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"

    end
end
