#function to display the board
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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [2,5,8],
  [1,4,7],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |com|
    i1 = com[0]
    i2 = com[1]
    i3 = com[2]
    char = board[i1]
    if position_taken?(board,i1) and position_taken?(board,i2) and position_taken?(board,i3) then
      if board[i2]==char and board[i3]==char then
        return com
      end
    end
  end
  return false
end

def full?(board)
  board.none?{|i| i==" "}
end

def draw?(board)
  f = full?(board)
  w = won?(board)

  f and w ? false : true
end

def over?(board)
  full?(board) or won?(board) ? true : false
end

def winner(board)
  pos = won?(board)
  pos ? board[pos[0]] : nil
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

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

def turn_count(board)
  x = board.reject{|i| i==" "}
  x.length
end

def current_player(board)
  turn_count(board)%2==0 ? "X" : "O"
end

#play function called by bin/tictacttoe
def play(board)
  until over?(board) do
    turn(board)
    break if draw?(board)
  end

  if won?(board) then
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
