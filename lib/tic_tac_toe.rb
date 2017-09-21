# Helper Method
def display_board(cells)
    print " #{cells[0]} | #{cells[1]} | #{cells[2]} \n-----------\n #{cells[3]} | #{cells[4]} | #{cells[5]} \n-----------\n #{cells[6]} | #{cells[7]} | #{cells[8]} \n"
end

def move(board, index, value)
  board[index] = value
  board
end

# code your input_to_index and move method here!
def input_to_index(num)
  num.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  return false if position_taken?(board,index) || index < 0 || index > 8
  true
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def turn_count(board)
  iterator = 0
  board.each { |cell| iterator += 1 if cell == "X" || cell == "O" }
  iterator
end

def current_player(board)
  return "X" if turn_count(board) % 2 == 0
  "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination# return the win_combination indexes that won.
    end
  end
  false
end

def full?(board)
  board.all? do |cell|
    cell == "X" || cell == "O"
  end
end

def draw?(board)
  return true  if full?(board) && !won?(board)
  false
end

def over?(board)
  return true if won?(board) || draw?(board) || full?(board)
  false
end

def winner(board)
  if won?(board)
    win_index = won?(board)[0]
    who_won = board[win_index]
    return who_won
  else
    nil
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
