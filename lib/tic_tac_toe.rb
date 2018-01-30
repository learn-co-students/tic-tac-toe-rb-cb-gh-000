def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board,index) == false
    return true
  end
  return false
end

def input_to_index(input)
  input.to_i-1
end

def move(board, index, current_player)
  board[index] = current_player
end

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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    winx = win_combination.all? do |cell|
      board[cell]=="X"
    end
    wino = win_combination.all? do |cell|
      board[cell]=="O"
    end
    if winx || wino
      return win_combination
    end
  end
  return false
end

def full?(board)
   board.all? do |cell|
     cell!=" "
   end
end

def draw?(board)
  if won?(board)
    return false
  else
    if full?(board)
      return true
    else
      return false
    end
  end
end

def over?(board)
  won?(board)||full?(board)||draw?(board)
end

def winner(board)
  win = won?(board)
  if win
    winner = board[win[0]]
  else
    return nil
  end
  winner
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board,index,player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count=0
  for value in board do
    value!=" " ? count+=1: count = count
  end
  return count
end

def current_player(board)
  turn_count(board).even? ? "X":"O"
end

def play(board)
  until over?(board)
    turn(board)
    over?(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end
