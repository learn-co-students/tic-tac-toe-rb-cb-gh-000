# Converts string input to proper board index
def input_to_index(user_input)
  return user_input.to_i - 1
end

# Places a piece on an index in the board
def move(board, index, piece)
  board[index] = piece
end

# Checks if the desired position is already filled
def position_taken?(board, index)
  return board[index] == "X" || board[index] == "O"
end

# Checks index range and if position is open
def valid_move?(board, index)
  if index < 0 || index > 8
    return false
  else
    return !position_taken?(board, index)
  end
end

# Ask current player to pick a move
def turn(board)
  print current_player(board) + ", pick a position 1-9: "
  input = gets.strip
  index = input_to_index(input)

  # If valid, move and display new board
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)

  # Otherwise, ask again
  else
    turn(board)
  end
end

# Print the board array on the grid
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Count each X and O on the board
def turn_count(board)
  turns = 0
  board.each do |piece|
    if piece == "X" || piece == "O"
      turns += 1
    end
  end
  return turns
end

# X goes every even turn and O goes every odd turn
def current_player(board)
  turns = turn_count(board)
  return (turns % 2 == 0 ? "X" : "O")
end

# Return winning combination if any
def won?(board)

  # Try all possible combinations
  WIN_COMBINATIONS.each do |wincomb|

    # Get set of pieces for a current combination
    data = [board[wincomb[0]], board[wincomb[1]], board[wincomb[2]]]

    # If the set contains only one type, and that type is a game piece, return this winning combination
    if data.uniq.size == 1 && (board[wincomb[0]] == "X" || board[wincomb[0]] == "O")
      return wincomb
    end
  end

  # If no winning combinations, return nil for not won
  return
end

# Board is full when 9 game pieces have been placed
def full?(board)
  return turn_count(board) == 9
end

# Draw happens when not won but board is full
def draw?(board)
  if won?(board)
    return false
  else
    return full?(board)
  end
end

# Over if board is won, drawn, or full
def over?(board)
  return won?(board) || draw?(board) || full?(board)
end

# If won, pull piece from winning set
def winner(board)
  win = won?(board)
  if win
    return board[win[0]]

  # Else, nil
  else
    return
  end
end

# Main game loop
def play(board)

  # Run until game over
  until over?(board)
    turn(board)
  end

  # If won, congratulate winner
  if won?(board)
    puts "Congratulations " + winner(board) + "!"

  # Else, specify cat game
  else
    puts "Cat's Game!"
  end
end

# List of winning indices
WIN_COMBINATIONS = [

  # Horizontal
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],

  # Vertical
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],

  # Diagonal
  [0, 4, 8],
  [6, 4, 2]
]
