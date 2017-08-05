# Prints the Board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Takes the number user enters and subtracts 1 to match array index
def input_to_index(index)
  return index.to_i - 1
end

# Adds the players move to the board
def move(board, index, char)
  board[index] = char
end

# Gets user input and checks to see if its not taken
def valid_move?(board, position)
  index = position.to_i
  if position_taken?(board, index) == false && index.between?(0, 8)
    return true
  else
    return false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  if board[index] == " " or board[index] == "" or board[index] == nil
    return false
  elsif board[index] == "X" or board[index] == "O"
    return true
  end
end

# Displays everything to the user asking for input and validates to make sure its available.
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  num_of_turns = 0
  player = ""
  board.each do |turn|
    if turn == "X" or turn == "O"
      num_of_turns += 1
    end
  end
  return num_of_turns
end

def current_player(board)
  players_turn = turn_count(board) % 2 == 0 ? "X" : "O"
end

# Possible WIN combinations
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
 WIN_COMBINATIONS.each do |win_combination|
   win_positions =  [board[win_combination[0]], board[win_combination[1]], board[win_combination[2]]]
   if win_positions == ["X","X","X"] || win_positions == ["O","O","O"]
     return win_combination
   end
 end
 return false
end

def full?(board)
 if board.detect{|i| i == " "}
   return false
 else
   return true
 end
end

def draw?(board)
 if full?(board) == true && won?(board) == false
   return true
 end
end

def over?(board)
 if draw?(board) == true or won?(board) != false
   return true
 else
   return false
 end
end

def winner(board)
 if won?(board) != false
   puts won?(board)[0]
   return board[won?(board)[0]]
 else
   return nil
 end
end

def play(board)
  # main loop of the game won't stop until game is over
  until over?(board) == true
    turn(board)
  end

  winner = winner(board)
  if won?(board) != false
    puts "Congratulations #{winner}!"
  else
    puts "Cats Game!"
  end
end
