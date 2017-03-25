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
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end
def turn_count(board)
  turn_count = 0
  board.each do |slot|
    if slot=="X" || slot=="O"
      turn_count+=1
    end
  end
  turn_count
end
def current_player(board)
  if turn_count(board)%2==0
    "X"
  else
    "O"
  end
end
def won?(board)
  odp = WIN_COMBINATIONS.detect do |comb|
    board[comb[0]]=="X" && board[comb[1]]=="X" && board[comb[2]]=="X" || board[comb[0]]=="O" && board[comb[1]]=="O" && board[comb[2]]=="O"
      end
odp ? odp : false
end
def full?(board)
  board.all?{|slot| slot == "X" || slot == "O"}? true : false
end
def draw?(board)
  won?(board) ? false : full?(board) ? true : false
end
def over?(board)
  won?(board) || draw?(board) || full?(board)
end
def winner(board)
  win = won?(board)
  if(!win)
    nil
  else
    board[win[0]]
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
