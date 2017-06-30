WIN_COMBINATIONS = [
  # HORIZONTAL
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  # DIAGONAL
  [0, 4, 8],
  [2, 4, 6],
  # VERTICAL
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
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

def move(board, index, piece)
  if position_taken?(board, index) == false
    board[index] = piece
  end
end

def position_taken?(board, index)
  !(board[index] == " " || board[index].nil?)
end

def valid_move?(board, index)
  position_taken?(board, index) == false && index.between?(0, 8)
end

def turn(board)
  count = turn_count(board)
  if count.even?
    place_piece(board, "X")
  else
    place_piece(board, "O")
  end
end

def place_piece(board, value)
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, value)
  else
    place_piece(board, value)
  end
end

def turn_count(board)
  turn = 0
  board.each_with_index do |piece, index|
    if position_taken?(board, index)
      turn += 1
    end
  end
  turn
end

def current_player(board)
  player = turn_count(board)
  if player.even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_pos_1 = combo[0]
    win_pos_2 = combo[1]
    win_pos_3 = combo[2]
    if board[win_pos_1] == "X" && board[win_pos_2] == "X" && board[win_pos_3] == "X"
      return combo
    elsif board[win_pos_1] == "O" && board[win_pos_2] == "O" && board[win_pos_3] == "O"
      return combo
    end
  end
  false
end

def draw?(board)
  if won?(board) == false && full?(board)
    return true
  end
  false
end

def full?(board)
  full = true
  board.each_with_index do |item, index|
    if position_taken?(board, index) == false
      full = false
    end
  end
  full
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    return true
  end
  false
end

def winner(board)
  if won?(board)
    win = won?(board)
    board[win[0]]
  end
end

def play(board)
  if over?(board) == false
    puts "Enter a number 1-9:"
    turn(board)
    play(board)
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
