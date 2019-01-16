# All methods & constants go here.

# Defining constant
WIN_COMBINATIONS = [
       [0, 1, 2],
       [3, 4, 5],
       [6, 7, 8],
       [0, 3, 6],
       [1, 4, 7],
       [2, 5, 8],
       [0, 4, 8],
       [2, 4, 6]
]

# Displays the current state of the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Converts string user input to board array index
def input_to_index(user_input)
  user_input.to_i - 1
end

# Move the token 'X' or 'O' to user-specified board position
def move(board, index, current_player)
  board[index] = current_player
end

# Checks for empty board positions
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Check if the move is valid
def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

# Asks the user for move recursively
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Counts the total #turns played
def turn_count(board)
  total_turns_played = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      total_turns_played += 1
    end
  end
  return total_turns_played
end

# Determines the eligible player at the beginning of each turn
def current_player(board)
  turn_count(board).even?? "X" : "O"
end

# Processes a win combination
def won?(board)
  board_empty = board.all? {|element| element == " "}
  result_array = false
  if board_empty
    return false
  else
    WIN_COMBINATIONS.each do |win_combination|
      winning_positions_taken = position_taken?(board, win_combination[0]) &&
                                position_taken?(board, win_combination[1]) &&
                                position_taken?(board, win_combination[2])

      if winning_positions_taken
        # All Xs
        all_Xs = (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X")

        # All Os
        all_Os = (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")

        if all_Xs || all_Os
          result_array = win_combination
          # break
        end
      end
    end
  end
  return result_array
end

# Checks if board is full
def full?(board)
  return !board.include?(" ")
end

# Checks if game is a tie
def draw?(board)
  # if full?(board) && !won?(board)
  #   return true
  # elsif !full?(board) && !won?(board)
  #   return false # for in-progress game
  # elsif won?(board)
  #   return false
  # # else
  # #   return true
  #  end
  !won?(board) && full?(board)
end

# Checks if game is complete
def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
end

# Evaluates the moves, and confirms the winner
def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

# The main method which simulates the complete game
def play(board)
  until over?(board)
    if turn_count(board) < 10
      turn(board)
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    # break
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
