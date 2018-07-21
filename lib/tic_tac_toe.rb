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
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

 def input_to_index(input)
   return input.to_i - 1
 end

 def move(board, index, player)
   if valid_move?(board, index)
     board[index] = player
   end
 end

 def position_taken?(board, index)
   !(board[index].nil? || board[index] == " ")
 end

def valid_move?(board, index)
  (index > -1 && index < 9 && !position_taken?(board, index) )
end

def turn(board)
  #puts "Please enter 1-9:"
  ##display_board(board)
  #input = gets.strip
  #index = input_to_index(input)
  #while !valid_move?(board,index)
  #  puts "Please enter 1-9:"
  #  input = gets.strip
  #  index = input_to_index(input)
  #end
  #move(board, index)
  #display_board(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each {|value|
    if value == "X"
      count +=1
    end
    if  value == "O"
      count += 1
    end
  }
  return count
end
def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  if board.all?{|value| value == " "}
    return false
  else
    WIN_COMBINATIONS.each do |combi|
        if board[combi[0]] == board[combi[1]] && board[combi[1]] == board[combi[2]] && board[combi[0]] != " "
          return combi
        end
    end
      return nil
    end
end
def full?(board)
  board.none?{|value| value == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
arr = won?(board)
  if arr
    return board[arr[0]]
  else
    return nil
  end
end

def play(board)
  if !over?(board)
    turn(board)
    play(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
