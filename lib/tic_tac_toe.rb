WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def full?(board)
  board.all?{|taken| taken == "O" || taken == "X"}
end

def won? (board = [" "," "," ","X","X","X"," "," "," "])
  WIN_COMBINATIONS.each do |win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
    else
    end
  end
  return false
#因为迭代结束才return false 因为第一个迭代不匹配 还有可能其他迭代匹配啊
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def position_taken?(board,location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board,index)
  if index > 8 || index < 0
    return false
  else
    return !position_taken?(board,index)
  end
end

def move(board,index,value)
  board[index] = value
  value = "O"
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2] } "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5] } "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8] } "
end

def input_to_index(input)
  index = input.to_i - 1
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:(as #{current_player(board)})"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board,index)
    turn(board)
  end
  move(board,index,current_player(board))
  display_board(board)
end

def  winner(board)
  win = won?(board)
  if win
    return board[win[0]]
  else
    nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
  end
end
