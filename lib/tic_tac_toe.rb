
"0 1 2
 3 4 5
 6 7 8"

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

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
return input.to_i - 1
end

def position_taken?(board, index)
!(board[index] == " " || board[index] == "" || board[index] == nil)
end

def move (board, index, current_player)
  board[index] = current_player
  return board
end

def valid_move?(board, index)
  if index.between?(0, 8)
   return !(position_taken?(board, index))
  end
  return false
end


def turn_count (board)
occupied_pos = board.select {|i| i == "O" || i == "X"}
return occupied_pos.count
end

def current_player(board)
  #predict who should play next
  turns = turn_count(board) -1
if (turns % 2) == 0
  return "O"
elsif (turns % 2) != 0
  return "X"
end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
  move(board, index, current_player(board))
else
  puts "invalid"
  turn(board)
end
  display_board(board)
end

def won?(board)
WIN_COMBINATIONS.each do |checked_position|
  positions = checked_position.select {|index| position_taken?(board, index)}
  if positions.count == 3
  if (board [positions[0]] == board [positions[1]]) && (board [positions[0]] == board [positions[2]])
    return positions
  end
  end
end
return false
end

def full?(board)
board.all? {|element| element == "X" || element == "O"}
end

def draw?(board)
if (!won?(board)) && full?(board)
puts "Cats Game!"
return true
end
end

def over?(board)
won?(board) || draw?(board) || full?(board)
end

def winner(board)
if positions = won?(board)
  return board[positions[0]]
end
end


def play(board)
  puts "Welcome to Tic Tac Toe!"
  display_board(board)
turns = 0
while turns < 9 do
  if over?(board)
    break
  end
  turn(board)
  turns += 1
end
if possible_winner = winner(board)
puts "Congratulations #{possible_winner}!"
else
puts "It has been a draw"
end
end
