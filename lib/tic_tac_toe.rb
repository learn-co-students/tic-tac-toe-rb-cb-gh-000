
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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, symbol)
  board[index] = symbol
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |symbol|
    if symbol == "X" || symbol == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_positions =  [board[win_combination[0]], board[win_combination[1]], board[win_combination[2]]]
    if win_positions == ["X","X","X"] || win_positions == ["O","O","O"]
      return win_combination
    end
  end
  return false
end

def full?(board)
  !board.any?{|position| position == " " || position == nil}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  end
end

def over?(board)
  if full?(board) == true || won?(board) == true || draw?(board) == true
    return true
  end
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board) == true || draw?(board) == true || won?(board) != false
    turn(board)
  end

  if won?(board) != false
    puts "Congratulations " + winner(board) + "!"
  else
    puts "Cats Game!"
  end
end
