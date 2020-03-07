WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
separator = "|"
lines = "-----------"

puts " #{board[0]} #{separator} #{board[1]} #{separator} #{board[2]} "
puts "#{lines}"
puts " #{board[3]} #{separator} #{board[4]} #{separator} #{board[5]} "
puts "#{lines}"
puts " #{board[6]} #{separator} #{board[7]} #{separator} #{board[8]} "
end

def input_to_index(input)
  input.to_i-1
end

def move(board,position,token)
  board[position]=token
end
def position_taken?(board,index)
  if board[index]==""||board[index]==" "||board[index]== nil
    return false
  else
    true
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  userInput = gets.strip
  index = input_to_index(userInput)
  if !valid_move?(board, index)
    turn(board)
  else
    move(board, index, current_player(board))
  end
display_board(board)
end

def turn_count(board)
  count = 0
board.each do |index|
  if index != " "
    count += 1
  end
end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
    else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each {|win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  }
  return false
end


def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
  # true if no winner and board is full
  !(won?(board)) && full?(board)
end

    def over?(board)
      if full?(board) == true
        return true # returns true for a won game / draw
      end
      return false # returns false for an in-progress game
    end

def over?(board)
  if full?(board) == true
    return true # returns true for a won game / draw
  end
    return false # returns false for an in-progress game
end

def winner (board)
  index = []
  index = won?(board)
  if index == false
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  while !over?(board) && !won?(board) && !draw?(board) # if the game isnt over
    turn(board) # play another turn
  end

# if the game is over
  if won?(board)
   puts "Congratulations #{winner(board)}!"
 end

# if its a draw
 if draw?(board)
   puts "Cat's Game!"
 end

end
