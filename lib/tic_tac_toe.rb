# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

# Define display_board that accepts a board and prints
# out the current state.

def display_board(input)
  puts " #{input[0]} " + "|" + " #{input[1]} " + "|" + " #{input[2]} "
  puts "-----------"
  puts " #{input[3]} " + "|" + " #{input[4]} " + "|" + " #{input[5]} "
  puts "-----------"
  puts " #{input[6]} " + "|" + " #{input[7]} " + "|" + " #{input[8]} "
end


def input_to_index(input)
  index = input.to_i
  index = index - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if position_taken?(board,index) == true
    return false
  elsif index.between?(0,8) && position_taken?(board,index) == false
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  user_input_index =  input_to_index(user_input)

  if valid_move?(board,user_input_index) == true
    move(board,user_input_index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
    board.each do |player|
      if player == "O" || player == "X"
        counter += 1
      end
    end
    return counter
end

def current_player(board)
    counter_current_player = turn_count(board)
    counter_current_player = counter_current_player % 2
    if counter_current_player == 0
      return "X"
    else
      return "O"
    end
end

def won?(board)
  WIN_COMBINATIONS.each do | win_combination|

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return  win_combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return  win_combination
    end
  end
    false
end

def full?(board)
    board.all? {|i| (i == "X" || i == "O")}
end

def draw?(board)
    full?(board) && !won?(board)
end

def over?(board)
    won?(board) || full?(board) || draw?(board)
end

def winner(board)
    result = won?(board)
    if result
      return board[result[0]]
    else
      return nil
   end
end

def play(board)
    until over?(board)
      turn(board)
    end
  if winner(board) != nil
      puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
      puts "Cats Game!"
  end
end
