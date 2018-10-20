def display_board(board)
    print" #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} \n"
  end
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
### input_to_index
def input_to_index(ui)
  ui.to_i - 1

end
###move
def move(board, index, player='X')
  board[index] = player
end
###Valid_move?
def valid_move?(board, index)
  a = board[index]
  filled = a == "X" || a == "O"
  index.between?(0,8) && !filled
end
### turn(board)
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end
# Define your play method below
def play(board)
  i = 0
  while i < 9
turn(board)
i += 1
end
end
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

# Define won?, full?, draw?, over?, and winner below
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end
