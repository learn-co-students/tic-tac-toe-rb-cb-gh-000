# Helper Methods
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

def move(board, index, current_player)
  board[index] = current_player
  return board
end



def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def current_player(board)
  count = 0
  board.each do |cell| 
    if cell!=" " 
      count+=1
    end
  end
  
  if count.even?
    return "X"
  end  
  return "O"
end
  

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    board=move(board, index,current_player(board))
    display_board(board)
  else
    Kernel.exit(false)
    turn(board)
  
      
    
  end
end


# Define your play method below
def play(board)
  9.times do
    turn(board)
  end
end
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
[3,4,5],
[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]
]

def full?(board)
  return !(board.any? {|cell| cell==" "})
end

def draw?(board)
  if won?(board)==nil and full?(board)
    return true
  end
  return false
end

def over?(board)
  if full?(board) or won?(board) != nil
    return true
  end
  return false
    
end

def winner(board)
  returned= won?(board)
  if returned!=nil
    return board[returned[0]]
  end
  return nil
end

def won?(board)
  WIN_COMBINATIONS.each do |combinations|
    if board[combinations[0]]==board[combinations[1]] and board[combinations[2]] == board[combinations[1]] and board[combinations[1]] != " "
      return combinations
    end
  end
  return nil

end
