WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2],
]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# input = gets.strip

def input_to_index(input)
  input.to_i - 1
end

def move(board, pos, char)
  board[pos] = char
end

def position_taken?(board, pos)
  if board[pos] == "" || board[pos] == " " then
    return false
  else
    return true
  end
end

def valid_move?(board, pos)
  if pos.between?(0,8) && !position_taken?(board, pos) then
    return true
  else
    return false
  end
end

def turn(board)

  puts "Please enter a number 1-9 for a position"

  input = gets.strip

  pos = input_to_index(input)

  if valid_move?(board, pos) == true then
    move(board, pos, current_player(board))
  else
    puts "Invalid move, try again!"
    input = gets.strip()
  end

end

def turn_count(board)
  # count = 0
  # board.select do |num|
  #   if num != " " then
  #     count += 1
  #   end
  # end
  # puts count
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  if turn_count(board).odd? == true then
    current_player = "O"
  else
    current_player = "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end


def full?(board)
  if board.any? {|i| i == " "} then
    return false
  else
    return true
  end
end

def draw?(board)
  if !won?(board) && full?(board) then
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) then
    return true
  elsif won?(board) then
    return true
  end
end

def winner(board)
  if winning_combo = won?(board) then
    board[winning_combo.first]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board) then
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) then
    puts "Cats Game!"
  end
end
