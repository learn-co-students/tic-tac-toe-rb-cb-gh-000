WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Diagonal 1
  [2,4,6], # Diagonal 2
  # ETC, an array for each win combination
]

def display_board(bArr)
  puts " #{bArr[0]} | #{bArr[1]} | #{bArr[2]} "
  puts "-----------"
  puts " #{bArr[3]} | #{bArr[4]} | #{bArr[5]} "
  puts "-----------"
  puts " #{bArr[6]} | #{bArr[7]} | #{bArr[8]} "
end

def input_to_index(input)
  input = input.to_i
  index = input - 1
  return index
end

def move(board, index, character)
  board[index] = character
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board, index) == true
    return false
  elsif index.between?(0, 8) == false
    return false
  else
    return true
  end
end

def turn(board)
  #get input
  puts "Please enter 1-9:"
  input = gets.strip

  #convert input to index
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, character = current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def current_player(board)
  turnMove = turn_count(board)
  return turnMove.even? ? "X" : "O"
end


def won?(board)
  # if the array is empty return false
  if board.length == 0
    return false
  elsif
    #for each win_combination in WIN_COMBINATIONS
    WIN_COMBINATIONS.each do | win_combination |
      # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
      # grab each index from the win_combination that composes a win.
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1] # load the value of the board at win_index_1
      position_2 = board[win_index_2] # load the value of the board at win_index_2
      position_3 = board[win_index_3] # load the value of the board at win_index_3

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return win_combination # return the win_combination indexes that won.
      end
    end
  else
    return false
  end
end

def full?(board)
  return !board.any?{|i| i == " "}
end

def draw?(board)
  if !won?(board) && full?(board)
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
  numberOfXs = board.select{|i| i == "X"}
  numberOfOs = board.select{|i| i == "O"}

  if numberOfXs.length > numberOfOs.length
    return "X"
  elsif numberOfXs.length < numberOfOs.length
    return "O"
  else
    return nil
  end
end

def turn_count(board)
  counter = 0;
  board.each do | move |
    if move == "X" || move == "O"
      counter += 1
    end
  end
  return counter
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    end
  elsif draw?(board)
    puts "Cats Game!"
  end
end
