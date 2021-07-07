WIN_COMBINATIONS=[
	  [0,1,2],
	  [3,4,5],
	  [6,7,8],
	  [0,4,8],
	  [2,4,6],
	  [0,3,6],
	  [1,4,7],
	  [2,5,8],
	]
def display_board(board)
	  puts " #{board[0]} | #{board[1]} | #{board[2]} "
	  puts "-----------"
	  puts " #{board[3]} | #{board[4]} | #{board[5]} "
	  puts "-----------"
	  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def turn(board)
  variable=0
  while variable==0
	  puts "Please enter 1-9:"
	  user_input=gets.strip
	  index=input_to_index(user_input)
	  valid_move=valid_move?(board,index)
	  if valid_move==true
      player=current_player(board)
      move(board,index,player)
	    display_board(board)
      variable=1
	  end
  end
end

def input_to_index(user_input)
	  return index=user_input.to_i-1
end

def valid_move?(board,index)
	  if (board[index]==""||board[index]==" ")&&(index>=0&&index<9)
	    return true
	  else
	    return false
	  end
end

def position_taken?(board,index)
	 if board[index]=="X"||board[index]=="O"
	    return true
	 else
	    return false
	 end
end

def move(board,index,token)
	  board[index]=token
	  return board
end

def turn_count(board)
  rejected_array=turn_count_finder(board)
  return rejected_array.size
end
def turn_count_finder(board)
  board.reject do |rejected_array|
    rejected_array==" "
  end
end

def current_player(board)
  turn=turn_count(board)
  if turn%2==0
    return "X"
  else
    return "O"
  end
end

def won?(board)
	  WIN_COMBINATIONS.each {|win_combo|
	    index_0 = win_combo[0]
	    index_1 = win_combo[1]
	    index_2 = win_combo[2]
	    position_1 = board[index_0]
	    position_2 = board[index_1]
	    position_3 = board[index_2]
	  if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
	      return win_combo
	    end
	  }
	else
	  return false
	end

def full?(board)                 #returns true if no_one empty
	  board.none? do|board_array|
	    board_array==" "
	 end
end

def draw?(board)                     #false for win
	  if full?(board) == true && won?(board) == false
	   return true
	  else
	   return false
	  end
end

def over?(board)
	 if full?(board)||won?(board)||draw?(board)
	    return true
	 else
	    return false
	 end
end

def winner(board)
	  array=won?(board)
	 if array==false
	    return nil
	 elsif board[array[0]]=="X"
	    return "X"
	 elsif board[array[0]]=="O"
	    return "O"
	 end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
