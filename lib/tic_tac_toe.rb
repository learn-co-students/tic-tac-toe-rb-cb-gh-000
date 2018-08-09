
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], 
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [6,4,2],
  [0,4,8]
  ]
  
def won?(board)
  WIN_COMBINATIONS.each do |combo| 
    if board[combo[0]] == board[combo[1]] &&  board[combo[1]] == board[combo[2]]
      winner = combo.all? do |index| 
        position_taken?(board, index)
        end
      if winner 
         return combo
        break
      end
    end
   end
  return FALSE
end
   
def full?(board)
  board.each_with_index do |space, index|
    if  !position_taken?(board, index)
      return FALSE
    end
  end
  return TRUE
end


def draw?(board)
  full?(board) && !won?(board)
end  

def over?(board)
  won?(board) || draw?(board) 
end

def winner(board)
  winIndex = won?(board)
  if winIndex == FALSE
    return nil
  end
  winChar = board[winIndex[0]] 
  if winChar == "X" || winChar == "O"
    return winChar
  end
end

def current_player(board)
  if turn_count(board) == 0 || turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

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

def move(board, index, player = "X")
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  player = current_player(board)
  puts "Player #{player}, Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
   end
   if draw?(board)
     puts "Cat's Game!"
   else
     puts "Congratulations #{winner(board)}!"
end
end

def turn_count(board)
  count = 0
  board.each do |turn|
    if turn.include? "X" 
      count += 1
    elsif turn.include? "O"
      count += 1
    end
  end
  return count  
end



