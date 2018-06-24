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

def input_to_index(user_input)
  converted_input = user_input.to_i - 1
end

def move(array, index, value)
  array[index] = value
  return array
end

def position_taken?(board,position)
  if position.between?(0,8) == true
    if board[position] ==" " || board[position] == "" || board[position]==nil
      return false
    end
  end
  return true
end

def valid_move?(board,position)
  if position_taken?(board,position)==false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board,index)==true
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |element|
    if element !=" "
      count+=1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|

    if board[win_combination[0]]==board[win_combination[1]] && board[win_combination[1]]==board[win_combination[2]] && (board[win_combination[0]]=="X" || board[win_combination[0]]=="O")
      return win_combination
    end
  end
  return false
end
def full?(board)
  board.all?{|i| i=="X" || i=="O"}
end

def draw?(board)
  (!won?(board) && full?(board))
end

def over?(board)
  !(!(won?(board) || full?(board) || draw?(board)))
end

def winner(board)
  win_combination=won?(board)
  if(win_combination!=false)
    winning=board[win_combination[0]]
    return winning
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts"Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
