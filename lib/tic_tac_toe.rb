WIN_COMBINATIONS = [
  [0, 1, 2],  # top row
  [3, 4, 5],  # middle row
  [6, 7, 8],  # bottom row
  [0, 3, 6],  # left column
  [1, 4, 7],  # middle column
  [2, 5, 8],  # right column
  [0, 4, 8],  # left daigonal
  [6, 4, 2]   # right diagonal
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-------------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-------------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
  return input.to_i - 1
end


def move(board, index, player_character)
  board[index] = player_character
  return board
end


def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end


def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    return true
  else
    return false
  end
end


def turn(board)
  puts "Enter a number between 1-9:"
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
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  return counter
end


def current_player(board)
  turn_count(board).even? ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if combination.all? { |index| position_taken?(board, index) }
      if board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
        return combination
      end
    end
  end
  return false
end


def full?(board)
  return board.all? { |position| position == "X" || position == "O"}
end


def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end


def winner(board)
  return won?(board) ? board[won?(board)[0]] : nil
end


def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
