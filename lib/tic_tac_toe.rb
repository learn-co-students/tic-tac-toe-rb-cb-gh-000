def display_board(board)
  i = 0
  3.times do
    print " #{board[i]} | #{board[i+1]} | #{board[i+2]} "
    print "\n"

    i+=3
    if i < 9
      11.times do
        print "-"
      end
    end
    print "\n"
  end
end


def input_to_index(index)
  index.to_i - 1
end


def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    return true
  else
    return false
  end
end


def turn_count(board)
  tc = 0
  board.each do |token|
    if token == 'X' || token == 'O'
      tc += 1
    end
  end
  return tc
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end


def move(board, index, token)
  board[index] = token
end


def turn(board)
  puts "Please enter 1-9:"
  io = gets.strip
  index = input_to_index(io)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end





# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # middle row
  [6, 7, 8], # bottom row
  [0, 3, 6], # left column
  [1, 4, 7], # middle column
  [2, 5, 8], # right column
  [0, 4, 8], # top-left to bottom-right diagonal
  [2, 4, 6], # top-right to bottom-left diagonal
]

def won?(board)
  return_array = []
  WIN_COMBINATIONS.each do |win_comb_array|
    if board[win_comb_array[0]] == 'X' && board[win_comb_array[1]] == 'X' && board[win_comb_array[2]] == 'X'
      win_comb_array.each {|win_index| return_array << win_index}
    elsif board[win_comb_array[0]] == 'O' && board[win_comb_array[1]] == 'O' && board[win_comb_array[2]] == 'O'
      win_comb_array.each {|win_index| return_array << win_index}
    end
  end
  if return_array != []
    return return_array
  else
    return false
  end
end


def full?(board)
  board.all? {|position| position == 'X' || position == 'O'}
end


def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end


def winner(board)
  winning_combination = won?(board)
  if won?(board)
    return board[winning_combination[0]]
  else
    return nil
  end
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return 'X'
  else
    return 'O'
  end
end


def play(board)
  counter = 0
  while counter <= 8
    if !over?(board)
      turn(board)
    else
      break
    end
    counter += 1
  end

  win = winner(board)
  if win != nil
    puts "Congratulations #{win}!"
  end

  if draw?(board)
    puts "Cat's Game!"
  end
end
