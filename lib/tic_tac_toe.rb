
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

# Prints out ASCII art of the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Returns true if position has been taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Decrements input to work on indexing starting at 0
def input_to_index(input)
  index = (input.to_i) - 1
end

# Set board position equal to desired character
def move(board,position,char)
  board[position] = char
end

# Returns true if requested move is valid
def valid_move?(board,index)
  if position_taken?(board,index)
    false
  else
    if index.between?(0,board.size-1)
      true
    else
      false
    end
  end
end

# Execute one turn
def turn(board)
  while true
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board,index)
      move(board,index,current_player(board))
      display_board(board)
      break
    end
  end
end

# Count the current number of turns taken
def turn_count(board)
  turns = 0
  board.each do |position|
    if position == "X" || position == "O"
      turns += 1
    end
  end
  return turns
end

# Returns player whose turn it is now
def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Returns true if winning combination found
def won?(board)
  if [0,1,2,3,4,5,6,7,8].none?{|index| position_taken?(board,index)}
    return false
  end

  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_taken?(board,win_index_1)
      if position_1 == position_2 && position_2 == position_3
        return win_combination
      else
        false
      end
    else
      false
    end
  end
  false
end

# Checks to see if board is completely full
def full?(board)
  [0,1,2,3,4,5,6,7,8].all?{|index| position_taken?(board,index)}
end

# Checks for a draw situation
def draw?(board)
  !won?(board) && full?(board)
end

# Checks if game is over
def over?(board)
  won?(board) || draw?(board)
end

# Returns who has won the game
def winner(board)
  if over?(board)
    if draw?(board)
      return nil
    elsif won?(board)
      win_combination = won?(board)
      return board[win_combination[0]]
    end
  end
end

def play(board)
  display_board(board)
  until over?(board)
    turn(board)
  end

  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
