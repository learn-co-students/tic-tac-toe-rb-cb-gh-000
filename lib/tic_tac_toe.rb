WIN_COMBINATIONS=[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]
def display_board(board)

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def input_to_index(input)
  input.to_i - 1
rescue ArgumentError
  -1
end

def move(arra, index, value)

  arra[index]=value
end
# code your #position_taken? method here!
def position_taken?(board, index)
  if board[index] == " " ||  board[index] == "" ||  board[index] == nil

    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end

end
def valid_move?(board, index)
    if position_taken?(board,index) == false && index.between?(0,8)
      true
    elsif position_taken?(board,index) == true
      false

    elsif !index.between?(0,8)
      false

    end
end
def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip

  index=input_to_index(input)
  until valid_move?(board,index)
    puts "invalid move, please try again"
    input = gets.strip

    index=input_to_index(input)

  end
  move(board,index, current_player(board))
  display_board(board)
end
def turn_count(board)
  count=0
  board.each do |iter|
    if iter == "X" || iter == "O"
      count+=1
    end
  end
  count
end

def current_player(board)
  if turn_count(board)%2 ==0
    "X"
  elsif turn_count(board)%2==1
    "O"
  end
end

def won?(board)

  position=Array.new
  combination=[]
  WIN_COMBINATIONS.each do|combination|
    combination.each do|index|
      position.push(board[index])
    end
    if position == ["X", "X", "X"] || position == ["O","O", "O"]
      return combination
    else
      position.clear
    end

  end
  return false
end

def full?(board)
  board.each do|element|
    if element == " " || element == "" || element==nil
      return false
    end
  end
end

def draw?(board)
  won = won?(board)
  full = full?(board)
  if won == false && full != false
    return true
  else
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
  temp = Array.new
  index =[]
  if over?(board) && won?(board) !=false
    won_index = won?(board)
    if won_index != false
      won_index.each do|index|
        temp.push(board[index])
      end
      if temp == ["X", "X","X"]
        return "X"
      elsif temp ==["O", "O", "O"]
        return "O"
      end
    end
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"

  elsif draw?(board)
    puts "Cats Game!"
  end
end
