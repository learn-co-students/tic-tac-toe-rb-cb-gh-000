WIN_COMBINATIONS = [
  [0,1,2], # row wins
  [3,4,5],
  [6,7,8],
  [0,3,6], # column wins
  [1,4,7],
  [2,5,8],
  [0,4,8], # horizontal wins
  [2,4,6]
]

# Define display_board that accepts a board and prints
# out the current state.
def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

# used to make a move
def move(board, position, player)
  board[position] = player
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, player)
  board[position] = player
end

def position_taken? (board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

def valid_move?(board, index)
  index.between?(0,8)  && !position_taken?(board, index)
end

def turn(board)
  index = -1

  # get input until move is valid
  until (valid_move?(board, index))
    # Get position of move
    puts "Please enter 1-9:"
    input = gets.strip

    # Correct the index
    index = input_to_index(input)
  end

  # make the move
  move(board, index, current_player(board))

  # display board after move
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turns = turn_count(board)
  turns & 1 == 1 ? "O" : "X"
end

def won?(board)
  # initalise win status
  win_status = nil

  WIN_COMBINATIONS.each do |win_combination|
    # check if all positions are occupied
    win_positions_occupied = win_combination.all?{|position| position_taken?(board, position)}

    if win_positions_occupied
      # identify player
      player = board[win_combination[0]]

      # check if all positions are occupied by player
      if win_combination.all?{|position| board[position] == player}
        win_status = win_combination
        break
      end
    end
  end
  win_status
end

def full?(board)
  board.none?{|position| position == " " }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || (won?(board) != nil)
end

def winner(board)
  win_status = won?(board)
  if win_status != nil
    return board[win_status[0]]
  end
  return nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
