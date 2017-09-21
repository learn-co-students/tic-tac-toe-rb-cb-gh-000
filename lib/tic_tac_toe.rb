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


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  user_input = index.to_i - 1
end

def move(board,index,value)
  board[index]= value
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board,index)
   board[index] =="" || board[index]== " " || board[index]== nil ? false : true
end

def valid_move?(board, index)
     position_taken?(board,index) == false && index.between?(0,8) == true ? true : false
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index) == true
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end

end


def turn_count(board)
  counter = 0
  board.each do |brd|
    if brd != " "
      counter +=1
    end
  end
  counter
end


def current_player(board)
  #replacement if
  turn_count(board).even? ? "X" : "O"
end


def won?(board)
  result = false
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      result = win_combination
    end
  end
    result
end

def full?(board)
 !board.include?(" ")
end

def draw?(board)
!won?(board) && full?(board) ?  true : false
end

def over?(board)
draw?(board) || full?(board) || won?(board) ? true : false
end

def winner(board)
  over?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cats Game!"
  end
end
