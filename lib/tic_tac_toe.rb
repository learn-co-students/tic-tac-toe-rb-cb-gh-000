WIN_COMBINATIONS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8],
  [0, 3, 6], [1, 4, 7], [2, 5, 8],
  [0, 4, 8], [2, 4, 6]
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  index.to_i - 1
end
def move(board, pos, val)
  board[pos] = val
end

def position_taken?(board, pos)
   board[pos]=="X" || board[pos]=="O"
end

def valid_move?(board, pos)
  (pos >= 0 && pos <=8) && !position_taken?(board, pos)
end

def turn(board)
  puts "Please enter a number between 1-9:"
  number = input_to_index(gets.strip)
  if valid_move?(board, number)
    move(board, number, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |i|
    if i == "X" || i == "O"
      count += 1
    end
  end
  return count
end
def current_player(board)
  n = turn_count(board)
  if n%2 == 0
    return "X"
  end
  return "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_comb|
    if (win_comb.all? { |i| board[i] == "X"} || win_comb.all? { |i| board[i]=="O"})
      return win_comb
    end
  end
  return false
end

def full?(board)
  return board.all?{|el| !(el==nil || el == " ")}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win_comb|
    if win_comb.all? { |i| board[i] == "X"}
      return "X"
    end
    if win_comb.all? { |i| board[i] == "O"}
      return "O"
    end
  end
return nil
end

def play(board)
  display_board(board)
  over = over?(board)
  while !over
    turn(board)
    over = over?(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
