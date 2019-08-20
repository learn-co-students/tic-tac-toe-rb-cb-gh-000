# global constant for winning combinations
WIN_COMBINATIONS = [
  # row combinations
  [0,1,2],
  [3,4,5],
  [6,7,8],
  # column combinations
  [0,3,6],
  [1,4,7],
  [2,5,8],
  # diagonal combinations
  [0,4,8],
  [2,4,6]
]

# display_board - displays an arbitrary board state to the screen
# => board - board state to display
def display_board(board)
  separator = ""
  11.times{separator = separator + "-"}
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts separator
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts separator
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# input_to_index - convert user string input to an integer input_to_index
def input_to_index(input)
  return input.to_i - 1
end

# position_taken? - determine if a position on the board is taken or not
# => board - current board state
# => index - index to check for availability
# <= true - the position is taken
# <= false - the position is open
def position_taken?(board, index)
  return !( board[index] == "" ||
  board[index] == " " ||
  board[index] == nil)
end

# valid_move? - determine if a requested move is valid_move
# => board - current board state
# => index - index to check for validity
# <= true - move is valid
# <= false - move is invalid
def valid_move?(board, index)
  index_in_range = index >= 0 && index <= 8
  if (index_in_range == false)
    return false
  end
  position_taken = position_taken?(board, index)
  if(position_taken == true)
    return false
  end
  return true
end

# move - process a user move
# => board - current board state
# => index - index to check for validity
# => move - token to place for the move
def move(board, index, token)
  board[index] = token
end

# turn_count - counts occupied positions on the board
# => board - current board state
# <= count - the number of occupied spaces on the board
def turn_count(board)
  count = 0
  board.each do |space|
    if space == 'X' || space == 'O'
      count += 1
    end
  end
  return count
end

# current_player - determines the current player
# => board - current board state
# <= 'X' - if the turn count is everything
# <= 'O' - if the turn count is odd
def current_player(board)
  turns =  turn_count(board)
  return turns % 2 == 0 ? 'X' : 'O'
end

# turn - execute a turn of tic-tac-toe-rb
# => board - current board state
# => token - token symbol for the move, default = 'X'
def turn(board)
  token = current_player(board)
  exec_count = 0
  made_move = false
  while !made_move
    puts "Please enter 1-9:"
    input = gets.strip()
    index = input_to_index(input)
    if(valid_move?(board, index))
      move(board, index, token)
      display_board(board)
      made_move = true
    end
  end
end

 # full? - determine if the board is full
 # => board - current board state
 # <= true - if there are no open spaces on the board
 # <= false - if there are open spaces on the board
 def full?(board)
   return board.all?{ |space| space == 'X' || space == 'O'}
<<<<<<< HEAD
 end
=======
 endn
>>>>>>> e28656a5e52be612ebac8afc21d988911c9518cc

# win? - determine if someones has won the game
# => board - current board state
# <= win - a set of indices for a winning play
# <= nil - if there is no winner
def won?(board)
  x_spaces = (0..board.size-1).select{ |idx| board[idx] == 'X'}
  o_spaces = (0..board.size-1).select{ |idx| board[idx] == 'O'}

  WIN_COMBINATIONS.each do |win|
<<<<<<< HEAD
    if win & x_spaces == win || win & o_spaces == win
=======
      if win & x_spaces == win ||
         win & o_spaces == win
>>>>>>> e28656a5e52be612ebac8afc21d988911c9518cc
      return win
    end
  end
  return false
end

# draw? - determines if the game is a draw
# => board - current board state
# <= true - the board is drawn
# <= false - the board contains a win or is not yet fully
def draw?(board)
  if(!full?(board))
    return false
  end
  return won?(board) == false
end

# over? - determines if the game is over
# => board - current board state
# <= true - if the game has ended
# <= false - if the game can continue
def over?(board)
  if(won?(board) != false)
    return true
  end
  return draw?(board)
end

# winner - determine who won the game
# => board - current board state
# <= 'X' - the winner is 'X'
# <= 'O' - the winner is 'O'
# <= nil - there is no winner
def winner(board)
  win_state = won?(board)
  if(win_state != false)
    return board[win_state[0]]
  end
  return nil
end

# play - execute the game code
# => board - a game board
def play(board)
  n = 0
<<<<<<< HEAD
  until over?(board)
    turn(board)
  end

  token = winner(board)
  if(token != nil)
    puts "Congratulations #{token}!"
  else
    puts "Cat's Game!"
=======
  while n < 10
    turn(board)
    if(over?(board))
      token = winner(board)
      if(token != nil)
        puts "Congratulations #{token}!"
      else
        puts "Cat's Game!"
      end
      break
     end
    n += 1
>>>>>>> e28656a5e52be612ebac8afc21d988911c9518cc
  end
end
