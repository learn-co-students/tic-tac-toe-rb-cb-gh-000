WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left Column
  [1,4,7], # Central column
  [2,5,8], # Right Column
  [0,4,8], # Diagonal 1
  [2,4,6] # Diagonal 2
]

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

# we'll see if i need to fix the input here...
def move(board, index, token)
  board[index] = token
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
  current_player = current_player(board)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |elt|
    if elt == "X" || elt == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  count = turn_count(board)
  if count.even?
    "X"
  else
    "O"
  end
end

def won?(board)
  # it is possible to do this with 3 lines by using #detect
  # #detect returns first combo that satisfies that condition
  # else it returns nil. Also, #detect is the same is #find.
 WIN_COMBINATIONS.detect do |combo|
   win_index_1 = combo[0]
   win_index_2 = combo[1]
   win_index_3 = combo[2]
   position_1 = board[win_index_1]
   position_2 = board[win_index_2]
   position_3 = board[win_index_3]

   # there is a more elegant way to do this, but this is the most
   # human readable way to do it...
   (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
   (position_1 == "O" && position_2 == "O" && position_3 == "O")
    end
end

def full?(board)
  !(board.include?(" "))
end

def draw?(board)
  full?(board) && !won?(board) #this is such a nice example of readable ruby
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  # remember, that returning anything other than nil, or false is truthy, so
  # the fact that #won? returns the index of the winning combo is no problem
  if won?(board)
    combo = won?(board)
    board[combo[0]]
  else
    return nil
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
