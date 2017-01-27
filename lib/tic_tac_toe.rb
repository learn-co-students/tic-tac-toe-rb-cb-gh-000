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


def check_win_combination?(board, player, win_combination)
  win_combination.all? do |position|
    board[position] == player
  end
end


def current_player(board)
  turns = turn_count(board)
  if turns % 2 > 0
    "O"
  else
    "X"
  end
end


def display_board(board)
  divider = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts divider
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts divider
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def draw?(board)
  (!won?(board) && full?(board))
end


def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end


def input_to_index(input)
  input.to_i - 1
end


def move(board, position, player)
  board[position] = player
end


def over?(board)
  won?(board) || draw?(board) || full?(board)
end


def play(board)
  until over?(board)
    turn(board)
  end
  congratulate(board)
end


def position_taken?(board, index)
  board[index] == 'X' || board[index] == 'O'
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


def turn_count(board)
  moves = 0
  board.each do |space|
    if space == "X" || space == "O"
      moves += 1
    end
  end
  return moves
end


def valid_move?(board, index)
  if index < 0 || index > 8 || position_taken?(board, index)
    return false
  end
  return true
end


def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end


def congratulate(board)
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if check_win_combination?(board, "X", win_combination)
      return win_combination
    elsif check_win_combination?(board, "O", win_combination)
      return win_combination
    end
  end
  return false
end
