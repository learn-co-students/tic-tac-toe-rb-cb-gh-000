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

def input_to_index(user_input)
  user_input.to_i - 1
end

def player_move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, position)
  position.between?(0,8) && !position_taken?(board, position)
end

def move(board, user_input, value="X")
  board[user_input] = value
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  input = input_to_index(input)
  while !valid_move?(board, input)
    puts "Please enter 1-9:"
    input = gets
    input = input_to_index(input)
  end
  move(board, input)
  display_board(board)
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  win = false
  WIN_COMBINATIONS.each do |a_win|
    win_index_1 = a_win[0]
    win_index_2 = a_win[1]
    win_index_3 = a_win[2]

    if (board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X") or (board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O")
      win = a_win
    end
  end
  return win
end

def full?(board)
  board.none? do |cell|
    cell == " "
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board) and !won?(board)
    return true
  elsif !full?(board) and !won?(board)
    return false
  end
end

def over?(board)
  won?(board) or draw?(board) or full?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end
