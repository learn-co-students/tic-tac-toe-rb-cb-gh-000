def turn_count(board)
  int = 0
  board.each do |element|
    if(element != " ")
      int += 1
    end
  end
  int
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    return "X"
  end
  "O"
end
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |top_row_win|
    if ((board[top_row_win[0]] == board[top_row_win[1]]) && (board[top_row_win[1]] == board[top_row_win[2]])) && (board[top_row_win[0]] != " ")
      return top_row_win
    end
  end
  false
end

def full?(board)
  if(board.detect{|x| x == " "})
    return false
  end
  true
end

def draw?(board)
  bool1 = full?(board)
  bool2 = won?(board)
  if(bool1 && !(bool2))

    return true
  end
  false
end

def over?(board)
  if(draw?(board) || won?(board))
    return true
  end
  false
end

def winner(board)
  if(draw?(board) || !(over?(board)))
    return nil
  end
  ary = won?(board)
  return board[ary[1]]
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!

def input_to_index(n)
  number = n.to_i
  number = number - 1
  number
end

def move(array, index, value)
  array[index] = value
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
    move(board, index,  current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while (!(over?(board))) do
      turn(board)


  end
  if(draw?(board))
     puts "Cats Game!"
elsif(won?(board))
     puts "Congratulations #{winner(board)}!"
  end
end
