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

PLAYER = ["X", "O"]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  integer = input.to_i
  if integer == 0
    return -1
  end
  return integer - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  PLAYER.include?(board[index])
end

def valid_move?(board, index)
  !(!board[index] || PLAYER.include?(board[index]) || !index.between?(0,8))
end

def turn(board)
  index = 0
  loop do
    puts "Please choose your position in range of 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if index != -1 && valid_move?(board, index)
      break
    end
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  board.select { |field| PLAYER.include?(field) }.length
end

def current_player(board)
  (turn_count(board) % 2 == 0) ? PLAYER[0] : PLAYER[1]
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if win.all? { |field|  board[field] == PLAYER[0]}
      return win
    end
    if win.all? { |field|  board[field] == PLAYER[1]}
      return win
    end
  end
  return false
end

def full?(board)
  board.all? { |field| PLAYER.include?(field)}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if !won?(board)
    return nil
  end
  return board[won?(board)[0]]
end

def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
