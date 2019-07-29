
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

def move(board, index, current_player )
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[0, 4, 8],
[2, 4, 6]
]

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    pos1 = board[comb[0]]
    pos2 = board[comb[1]]
    pos3 = board[comb[2]]
    if ((pos1 == "X" && pos2 == "X" && pos3 == "X") || (pos1 == "O" && pos2 == "O" && pos3 == "O"))
      return comb
    end
  end
  return false
end

def full?(board)
    board.each do |elem|
      if (elem == " ")
        return false
      end
    end
    return true
end

def draw?(board)
  if (full?(board) && !won?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if (won?(board) || draw?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if (draw?(board))
    return nil
  elsif (won?(board))
    win = won?(board)
    pos1 = board[win[0]]
    if (pos1 == "X")
      return "X"
    else
      return "O"
    end
  end
end

def turn_count(board)
  turn_count1 = 0
  board.each do |item|
    smt = item
    if (smt == "X" || smt == "O")
      turn_count1 += 1;
    end
  end
  turn_count1
end

def current_player(board)
  num = turn_count(board)
  if (num % 2 == 0)
     "X"
  else
     "O"
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if (draw?(board))
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
