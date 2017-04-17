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
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)

    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter=0
  board.each do |player|
    if player.include?(["X","O"])
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else return "O"
  end
end

# Define your play method below
def play(board)
turn(board)
end




# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def won?(board)
  wins=Array.new
  none=Array.new

  if !board.all?{|i| i==" "}
    WIN_COMBINATIONS.each do |index|
   values=board.values_at(index[0],index[1],index[2])

    if values.all?{|val| val=="X"}|| values.all?{|val| val=="O"}
        wins<<[true,index]
    else none<<false
    end
    end
    if none.length == 8
        return false
      elsif wins[0][0]
          return wins[0][1]
      end
  else
    return false
end
end


def full?(board)
  return board.none?{|item| item==" "}
end

def draw?(board)
    return !won?(board) && full?(board)
end

def over?(board)
   return won?(board) || draw?(board) || full?(board)
end
def winner(board)
   index=won?(board)
   if index
      values=board.values_at(index[0],index[1],index[2])
   if values.all?{|val| val=="X"}
     return "X"
   elsif values.all?{|val| val=="O"}
     return "O"
   end
   else return nil
  end
end
