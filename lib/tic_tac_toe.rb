#Constants
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Top column
  [1,4,7], # Middle column
  [2,5,8], # Bottom column
  [0,4,8], # Right diagonal
  [2,4,6]  # Left diagonal
]

#Methods
def display_board(board) #Print a board in console
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input) #Return an array index
  user_input.to_i - 1
end

def move(board,index,token) #Fill the element of array
  board[index] = token     #with the corresponding token
end

def position_taken?(board,index) #Indicate if the position
  if board[index] == " "         #selected is free
    false
  else
    true
  end
end

def valid_move?(board,index) #Checks if the index selected
  if index.between?(0,8)      #by the user is valid
    if position_taken?(board,index)
      false
    else
      true
    end
  else
    false
  end
end

def turn(board) # Is the play in one turn
  puts "Write your position: 1-9"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board) #Return what is the actual turn
  count = 0
  board.each do |element|
    if element != " "
      count+=1
    end
  end
  return count
end

def current_player(board) #Return the token for the
  if turn_count(board)%2 == 0 #player in his turn
    return "X"
  elsif turn_count(board)%2 != 0
    return "O"
  end
end

def won?(board) #Check if the game has a winner
  aux = 0
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    false
  else
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      pos_1 = board[win_index_1] # load the value of the board at win_index_1
      pos_2 = board[win_index_2] # load the value of the board at win_index_2
      pos_3 = board[win_index_3] # load the value of the board at win_index_3

      if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
        return win_combination # return the win_combination indexes that won.
      elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
        return win_combination # return the win_combination indexes that won.
      else
        false
      end
    end
  end

  aux = 1 #if the game is a draw
  if aux != 0
    false
  end
end

def full?(board) #Check if the board is not empty
  board.each do |element|
    if element == " "
      false
      break
    else
      true
    end
  end
end

def draw?(board) #Check if the game was a draw
  if !won?(board)
    if full?(board)
      true
    else
      false
    end
  else
    false
  end
end

def over?(board) #Check if the game was finish
  if won?(board) || draw?(board) || full?(board)
    true
  elsif turn_count(board) == 0
    false
  else
    false
  end
end

def winner(board) #Return the token of the winner
  if won?(board)
    if board[won?(board)[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

#board = [" "," "," "," "," "," "," ","0","X"]
#current_player(board)
