#Created by Sankalp Chauhan (@sankalpchauhan-me) on 16/06/2018 for The Web Developer Bootcamp of The Flatrion School
#Thanks to the team of Flatrion School


# WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

#Defines a board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Changes input_to_index
def input_to_index(str)
  num = str.to_i
  num-1
end

#Moves a player
def move(board, index, value)
  board[index] = value
end

#  #position_taken? method here
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# #valid_move? method here
def valid_move?(board, index)
  if(index.between?(0,8) && !position_taken?(board,index))
    return true
  else
    return false
  end
end

# #turn method here:
def turn(board)
  puts "Please enter 1-9:"
  val = gets.strip
  index  = input_to_index(val)

  if(valid_move?(board,index)==true)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# #turn_count method here:
def turn_count(board)
  count=0
  board.each {|mark|
    if(mark == "X"|| mark == "O")
      count = count+1
    end
  }
  count
end

# #current_player method here:
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# which combination won the game:
def won?(board)
  i = 0
  WIN_COMBINATIONS.each{|win_combination|
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
      i +=1
      return win_combination
    elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
      i +=1
      return win_combination
    end
  }
  if i == 0
    return false
  end
end

# is the board full?
def full?(board)
  if board.include?(" ")
    return false
  else
    return true
  end
end

#Is it a draw?
def draw?(board)
  if(full?(board) == true && won?(board) == false )
    return true
  else
    return false
  end
end

#Is the game over?
def over?(board)
  if(draw?(board) || won?(board))
    return true
  else
    return false
  end
end

#who is the winner
def winner(board)
  i = 0
  WIN_COMBINATIONS.each{|win_combination|
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X"
      i +=1
      return "X"
    elsif board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
      i +=1
      return "O"
    end
  }
  if i == 0
    return nil
  end
end

#The play method is the main method of the tic tac toe application and is responsible for the game loop.
def play(board)
  until over?(board)
    turn(board)
  end

  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif(draw?(board) == true)
    puts "Cat's Game!"
  end
end
