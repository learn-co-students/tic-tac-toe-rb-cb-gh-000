WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
  ]
  
def display_board(board = [])
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n"
  puts "-----------\n"
  puts " #{board[3]} | #{board[4]} | #{board[5]} \n"
  puts "-----------\n"
  puts " #{board[6]} | #{board[7]} | #{board[8]} \n"
  
end

def input_to_index(num)
  integer = num.to_i - 1
end

def move(array, index, character = "X")
  array[index] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  isWithinBoard = index.between?(0, 8)
  positionNotTaken = !position_taken?(board, index)
  
  return isWithinBoard && positionNotTaken
end 


def turn(board)
  puts "Please enter 1-9:"
   input = gets
   
   myIndex = input_to_index(input)
   
   if !valid_move?(board, myIndex) 
     turn(board)
   end
   
   move(board, myIndex, "X")
   display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |item|
    if item == "X" || item == "O"
      counter += 1 
    end
  end
  
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else return "O"
end
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combo|
        win_index_1 = win_combo[0]
        win_index_2 = win_combo[1]
        win_index_3 = win_combo[2]
         
        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]
        
        if position_1 == "X" && position_2 == "X" && position_3 == "X"
          return win_combo
        elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
          return win_combo
        end
      end
        return false
  end
  
 
  def full?(board)
    board.all? {|square| square == "X" || square == "O" }
  end
 
  def draw?(board)
    if won?(board) == false && full?(board) 
      return true
    elsif won?(board) == false && full?(board) == false
      return false
    elsif won?(board)
      return false
    end 
  end
  
  def over?(board)
    if won?(board) || draw?(board) || full?(board)
      return true
    else
      return false
    end
  end
  
  def winner(board)
      WIN_COMBINATIONS.each do |win_combo|
        win_index_1 = win_combo[0]
        win_index_2 = win_combo[1]
        win_index_3 = win_combo[2]
         
        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]
        
        if position_1 == "X" && position_2 == "X" && position_3 == "X"
          return "X"
        elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
          return "O"
        end
      end
        return nil
  end


def play(board)
  turns = 0
  while turns < 9 do
    turn(board)
    turns += 1
  end
  
  if won?(board) && winner(board) == "X"
    puts "Congratulations player X!"
  elsif won?(board) && winner(board) == "O"
    puts "Congratulations player O!"
  elsif draw?(board)
    puts "The game is a draw"
  end
  
end





