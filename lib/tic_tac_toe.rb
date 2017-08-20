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
  line = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts line
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts line
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
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
  input = gets.chomp
  index = input_to_index(input)
  while !valid_move?(board,index)
    input = gets.chomp
    index = input_to_index(input)
  end
  move(board,index,current_player(board))
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do | position |
    if position != " "
      turns +=1
    end
  end
  turns
end

def current_player(board)
  turn = turn_count(board)
  if turn % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |group|
    win_index_1 = group[0]
    win_index_2 = group[1]
    win_index_3 = group[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
    (position_1 == "O" && position_2 == "O" && position_3 == "O")
  end
end

def full?(board)
  !(board.include?(" "))
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    combo = won?(board)
    board[combo[0]]
  else
    return nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif winner(board) != nil
    puts "Congratulations #{winner(board)}!"
  end
end
