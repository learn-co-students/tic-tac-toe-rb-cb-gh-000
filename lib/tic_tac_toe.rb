
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
  count=0
  board.each do |pos|
    if pos=="X" || pos=="O"
      count+=1

    end
  end
  return count
end

def current_player(board)
  count = turn_count(board)
  if count%2==0
    return "X"
  end
  return "O"
end

def won?(board)
  x_won = false
  o_won = false
  WIN_COMBINATIONS.each do |combi|
    x_won = combi.all? { |e| board[e]=="X" }
    o_won = combi.all? { |e| board[e]=="O" }
    if x_won || o_won
      return combi
    end
  end
  return false
end

def full?(board)
  return !(board.any? { |e| e==" "})
end

def draw?(board)
  return full?(board) && !(won?(board))
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  result = won?(board)
  if result==false
    return nil
  end
  return board[result[0]]
end

def play(board)
  until over?(board) do
    turn(board)
  end

  p_win = winner(board)
  if p_win=="X" || p_win=="O"
    puts "Congratulations #{p_win}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end

end
